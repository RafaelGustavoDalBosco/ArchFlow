unit App.Controller.AmazonCloud.Cognito;

interface

uses
  System.SysUtils, System.Classes, System.NetEncoding, IdHTTP, IdSSLOpenSSL,
  IdContext, Winapi.Windows, IdSSLOpenSSLHeaders, IdHTTPServer, IdCustomHTTPServer, ShellAPI;

type

   TCognitoAuth = class
   private
      FDomain: UnicodeString;
      FClientId: UnicodeString;
      FRedirectUri: UnicodeString;
      FPort: Integer;
      FState: UnicodeString;
      FServer: TIdHTTPServer;
      procedure StartLoopBackServer;
      procedure StopLoopBackServer;
      procedure OnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
      procedure ExchangeCodeForTokens(const ACode: UnicodeString);
   public
      AccessToken: UnicodeString;
      IdToken: UnicodeString;

      /// <summary>
      ///    Inicia o login pela AWS Cognito
      /// </summary>
      procedure BeginLogin;

      /// <param name="ADomain">
      ///    Dominio na AWS
      /// </param>
      /// <param name="AClientId">
      ///    Client ID que está na AWS
      /// </param>
      /// <param name="APort">
      ///    Porta, por padrão será 53682
      /// </param>
      constructor Create(const ADomain, AClientId: UnicodeString; APort: Integer = 53682);
      destructor Destroy; override;
   end;

implementation

uses
  System.JSON;

{ TCognitoAuth }

constructor TCognitoAuth.Create(const ADomain, AClientId: UnicodeString; APort: Integer);
begin
   inherited Create;
   FDomain := ADomain.TrimRight(['/']);
   FClientId := AClientId;
   FPort := APort;
   FRedirectUri := Format('http://localhost:%d/callback', [FPort]);
end;

destructor TCognitoAuth.Destroy;
begin
   StopLoopbackServer;
   inherited;
end;

procedure TCognitoAuth.StartLoopBackServer;
begin
   if Assigned(FServer) then
      Exit;

   FServer := TIdHTTPServer.Create(nil);
   FServer.DefaultPort := FPort;
   FServer.OnCommandGet := OnCommandGet;
   FServer.Active := True;
end;

procedure TCognitoAuth.StopLoopBackServer;
begin
   if Assigned(FServer) then
   begin
      FServer.Active := False;
      FreeAndNil(FServer);
   end;
end;

procedure TCognitoAuth.BeginLogin;
var
   LAuthUrl: UnicodeString;
begin
   StartLoopbackServer;
   FState := IntToHex(Random(MaxInt), 8);

  LAuthUrl :=
    FDomain + '/login' +
    '?client_id=' + FClientId +
    '&response_type=code' +
    '&scope=' + TNetEncoding.URL.Encode('email openid phone') +
    '&redirect_uri=' + TNetEncoding.URL.Encode(FRedirectUri) +
    '&state=' + FState;

   ShellExecute(0, 'open', PChar(LAuthUrl), nil, nil, SW_SHOWNORMAL);
end;

procedure TCognitoAuth.OnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
   LCode, LState: UnicodeString;
begin
   if ARequestInfo.Document = '/callback' then
   begin
      LCode := ARequestInfo.Params.Values['code'];
      LState := ARequestInfo.Params.Values['state'];

      if (LCode <> '') and (LState = FState) then
      begin
         ExchangeCodeForTokens(LCode);
         AResponseInfo.ContentText := '<html><body><h2>Login realizado com sucesso. Pode fechar esta janela.</h2></body></html>';
      end
      else
         AResponseInfo.ContentText := '<html><body>Falha no login.</body></html>';

      TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(300);
        StopLoopbackServer;
      end).Start;
   end
   else
      AResponseInfo.ContentText := 'OK';
end;

procedure TCognitoAuth.ExchangeCodeForTokens(const ACode: UnicodeString);
var
   LHTTP: TIdHTTP;
   LSSL: TIdSSLIOHandlerSocketOpenSSL;
   LReq, LResp: TStringStream;
   LParams, LBody: UnicodeString;
   LObj: TJSONObject;
begin
  LParams :=
    'grant_type=authorization_code' +
    '&client_id=' + FClientId +
    '&code=' + ACode +
    '&redirect_uri=' + TNetEncoding.URL.Encode(FRedirectUri);

   LHTTP := TIdHTTP.Create(nil);
   LSSL := TIdSSLIOHandlerSocketOpenSSL.Create(LHTTP);
   try
      LHTTP.IOHandler := LSSL;
      LHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      LSSL.SSLOptions.Mode := sslmClient;
      LSSL.SSLOptions.SSLVersions := [sslvTLSv1_1, sslvTLSv1_2];
      LReq := TStringStream.Create(LParams, TEncoding.UTF8);
      LResp := TStringStream.Create('', TEncoding.UTF8);
      try
         LHTTP.Post(FDomain + '/oauth2/token', LReq, LResp);
         LBody := LResp.DataString;

         LObj := TJSONObject.ParseJSONValue(LBody) as TJSONObject;
         try
           if Assigned(LObj) then
           begin
             AccessToken := LObj.GetValue<UnicodeString>('access_token', '');
             IdToken := LObj.GetValue<UnicodeString>('id_token', '');
           end;
         finally
           LObj.Destroy;
         end;
      finally
         LReq.Destroy;
         LResp.Destroy;
      end;
   finally
      LSSL.Destroy;
      LHTTP.Destroy;
   end;
end;

end.

