unit App.System.Connection;

interface

uses

{$REGION '| SYSTEM |'}
   System.SysUtils,
{$ENDREGION}

{$REGION '| FIREDAC |'}
   FireDAC.Comp.Client,
   FireDAC.Stan.Def,
   FireDAC.DApt,
   FireDAC.VCLUI.Wait,
   FireDAC.Phys.FB,
   FireDAC.Phys.Intf,
   FireDAC.Stan.Param,
   FireDAC.Stan.Async,
   FireDAC.UI.Intf,
   FireDAC.Comp.ScriptCommands,
   FireDAC.Stan.Util,
   FireDAC.Stan.Intf,
   FireDAC.Stan.Error,
   FireDAC.Comp.Script,
{$ENDREGION}

{$REGION '| APP |'}
   App.System.Consts;
{$ENDREGION}

type

   TConnectionParams = class
   strict private
      FCharacterSet: UnicodeString;
      FDriverName: UnicodeString;
      FLoginPrompt: Boolean;
      FPort: Integer;
      FDataBasePath: UnicodeString;
      FPassWord: UnicodeString;
      FUserName: UnicodeString;
      FServer: UnicodeString;
      procedure SetCharacterSet(const Value: UnicodeString);
      procedure SetDataBasePath(const Value: UnicodeString);
      procedure SetDriverName(const Value: UnicodeString);
      procedure SetLoginPrompt(const Value: Boolean);
      procedure SetPassWord(const Value: UnicodeString);
      procedure SetPort(const Value: Integer);
      procedure SetServer(const Value: UnicodeString);
      procedure SetUserName(const Value: UnicodeString);
   public
      property DriverName: UnicodeString read FDriverName write SetDriverName;
      property LoginPrompt: Boolean read FLoginPrompt write SetLoginPrompt;
      property UserName: UnicodeString read FUserName write SetUserName;
      property PassWord: UnicodeString read FPassWord write SetPassWord;
      property Server: UnicodeString read FServer write SetServer;
      property Port: Integer read FPort write SetPort;
      property CharacterSet: UnicodeString read FCharacterSet write SetCharacterSet;
      property DataBasePath: UnicodeString read FDataBasePath write SetDataBasePath;
   end;

   TConnection = class
   private
      FParams: TConnectionParams;
      FFDConnection: TFDConnection;
      procedure SetFDConnection(const Value: TFDConnection);
      procedure SetParams(const Value: TConnectionParams);
   protected
      property FDConnection: TFDConnection read FFDConnection write SetFDConnection;
      property Params: TConnectionParams read FParams write SetParams;
   public
      /// <summary>
      ///    Obtém a instância do TFDConnection vinculado
      /// </summary>
      function GetFDConnection: TFDConnection;

      /// <summary>
      ///    Inclui os parâmetros de conexão, no objeto do TFDConnection
      /// </summary>
      /// <param name="AIncludeDataBaseName">
      ///    Caso não seja para incluir o nome do banco de dados na conexão, é usado este parâmetro
      /// </param>
      procedure IncludeParamsOnConnection(const AIncludeDataBaseName: Boolean = True);

      /// <summary>
      ///    Tenta se conectar o banco de dados
      /// </summary>
      function TryConnect: Boolean;

      /// <summary>
      ///    Executa um determinado script utilizando TFDScript
      /// </summary>
      function ExecuteScript(const AScript: UnicodeString): Boolean;

      /// <summary>
      ///    Executa uma determinada SQL utilizando a conexão própria
      /// </summary>
      function ExecuteSQL(const ASQL: UnicodeString): Boolean;

      /// <param name="AParams">
      ///    Define os parâmetros da conexão
      /// </param>
      constructor Create(const AParams: TConnectionParams); overload;
      destructor Destroy; override;
   end;

implementation

uses
   App.Common.Utils;

{ TConnection }

constructor TConnection.Create(const AParams: TConnectionParams);
begin
   ObjUtils.CheckAndRaiseNilObject(AParams);
   SetParams(AParams);
   FFDConnection := TFDConnection.Create(nil);
   inherited Create;
end;

destructor TConnection.Destroy;
begin
   ObjUtils.Release_(FParams);
   FFDConnection.Close;
   ObjUtils.Release_(FFDConnection);
   inherited Destroy;
end;

function TConnection.ExecuteScript(const AScript: UnicodeString): Boolean;
var
   LScript: TFDScript;
begin
   if (not AScript.IsEmpty) then
   begin
      LScript := TFDScript.Create(nil);
      try
         LScript.Connection := FDConnection;
         LScript.SQLScripts.Add.SQL.Text := AScript;
         LScript.ValidateAll;

         Result := LScript.ExecuteAll;
      finally
         FreeAndNil(LScript);
      end;
   end
   else
      Result := False;
end;

function TConnection.ExecuteSQL(const ASQL: UnicodeString): Boolean;
begin
   if (ASQL.IsEmpty) then
      Exit(False);

   try
      Result := (FDConnection.ExecSQL(ASQL) > 0);
   except
        on E: EFDDBEngineException do
         raise Exception.CreateFmt('Erro ao tentar executar a SQL: ' + sLineBreak + '%s' + sLineBreak + 'Motivo: ' + '%s', [ASQL, E.Message]);
   end;
end;

function TConnection.GetFDConnection: TFDConnection;
begin
   if (FFDConnection.Connected) then
      Result := FFDConnection
   else
      Result := nil;
end;

procedure TConnection.IncludeParamsOnConnection(const AIncludeDataBaseName: Boolean);
begin
   FDConnection.DriverName := Params.DriverName;
   FDConnection.LoginPrompt := Params.LoginPrompt;
   FDConnection.Params.Values['user_name'] := Params.UserName;
   FDConnection.Params.Values['password'] := Params.PassWord;
   FDConnection.Params.Values['server'] := Params.Server;
   FDConnection.Params.Values['port'] := Params.Port.ToString;
   FDConnection.Params.Values['characterSet'] := Params.CharacterSet;

   if (AIncludeDataBaseName) then
      FDConnection.Params.Values['database'] := Params.DataBasePath
   else
      FDConnection.Params.Values['database'] := 'postgres'
end;

procedure TConnection.SetFDConnection(const Value: TFDConnection);
begin
   FFDConnection := Value;
end;

procedure TConnection.SetParams(const Value: TConnectionParams);
begin
   FParams := Value;
end;

function TConnection.TryConnect: Boolean;
begin
   try
      FDConnection.Params.Values['OpenMode'] := 'Open';

      if (not FDConnection.Connected) then
         FDConnection.Open;

      Result := True;
   except
      on E: EFDDBEngineException do
         raise Exception.CreateFmt('Erro ao tentar conectar ao banco de dados! Motivo: ' + sLineBreak + '%s', [E.Message]);
   end;
end;

{ TConnectionParams }

procedure TConnectionParams.SetCharacterSet(const Value: UnicodeString);
begin
   FCharacterSet := Value;
end;

procedure TConnectionParams.SetDataBasePath(const Value: UnicodeString);
begin
   FDataBasePath := Value;
end;

procedure TConnectionParams.SetDriverName(const Value: UnicodeString);
begin
   FDriverName := Value;
end;

procedure TConnectionParams.SetLoginPrompt(const Value: Boolean);
begin
   FLoginPrompt := Value;
end;

procedure TConnectionParams.SetPassWord(const Value: UnicodeString);
begin
   FPassWord := Value;
end;

procedure TConnectionParams.SetPort(const Value: Integer);
begin
   FPort := Value;
end;

procedure TConnectionParams.SetServer(const Value: UnicodeString);
begin
   FServer := Value;
end;

procedure TConnectionParams.SetUserName(const Value: UnicodeString);
begin
   FUserName := Value;
end;

end.
