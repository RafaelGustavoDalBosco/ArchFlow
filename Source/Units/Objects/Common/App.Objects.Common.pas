unit App.Objects.Common;

interface

uses
   System.SysUtils, App.Common.Types, System.Classes;

type

   TApplicationDirectorys = class
   strict private
      FImagens: UnicodeString;
      FHTML: UnicodeString;
      FSystem: UnicodeString;
      FLog: UnicodeString;
      FFiles: UnicodeString;
      FJSON: UnicodeString;
      FCommon: UnicodeString;
      FTemp: UnicodeString;
      FDownload: UnicodeString;
      procedure SetCommon(const Value: UnicodeString);
      procedure SetFiles(const Value: UnicodeString);
      procedure SetHTML(const Value: UnicodeString);
      procedure SetImagens(const Value: UnicodeString);
      procedure SetJSON(const Value: UnicodeString);
      procedure SetLog(const Value: UnicodeString);
      procedure SetSystem(const Value: UnicodeString);
      procedure SetTemp(const Value: UnicodeString);
      procedure SetDownload(const Value: UnicodeString);

      function GetSystem: UnicodeString;
      function GetCommon: UnicodeString;
      function GetFiles: UnicodeString;
      function GetImagens: UnicodeString;
      function GetHTML: UnicodeString;
      function GetLog: UnicodeString;
      function GetJSON: UnicodeString;
      function GetTemp: UnicodeString;
      function GetDownLoad: UnicodeString;
   public
      property System: UnicodeString read GetSystem write SetSystem;
      property Common: UnicodeString read GetCommon write SetCommon;
      property Files: UnicodeString read GetFiles write SetFiles;
      property Temp: UnicodeString read GetTemp write SetTemp;
      property Imagens: UnicodeString read GetImagens write SetImagens;
      property HTML: UnicodeString read GetHTML write SetHTML;
      property Log: UnicodeString read GetLog write SetLog;
      property JSON: UnicodeString read GetJSON write SetJSON;
      property Download: UnicodeString read GetDownload write SetDownload;
   end;

   TApplicationSettingsCustomize = class
   strict private
      FRememberUser: Boolean;
      FUserNameDefault: UnicodeString;
      FUseEscapeKeyToLeave: Boolean;
      FShowConfirmMessage: Boolean;
      FDisableWeather: Boolean;
      FDisableSpellChecker: Boolean;
      procedure SetDisableSpellChecker(const Value: Boolean);
      procedure SetDisableWeather(const Value: Boolean);
      procedure SetShowConfirmMessage(const Value: Boolean);
      procedure SetUseEscapeKeyToLeave(const Value: Boolean);
      procedure SetRememberUser(const Value: Boolean);
      procedure SetUserNameDefault(const Value: UnicodeString);
   public
      property RememberUser: Boolean read FRememberUser write SetRememberUser;
      property UserNameDefault: UnicodeString read FUserNameDefault write SetUserNameDefault;
      property UseEscapeKeyToLeave: Boolean read FUseEscapeKeyToLeave write SetUseEscapeKeyToLeave;
      property ShowConfirmMessage: Boolean read FShowConfirmMessage write SetShowConfirmMessage;
      property DisableWeather: Boolean read FDisableWeather write SetDisableWeather default True;
      property DisableSpellChecker: Boolean read FDisableSpellChecker write SetDisableSpellChecker default False;
   end;

   TApplicationSettingsSystem = class
   strict private
      FDoNotUpdate: Boolean;
      FTraceDebug: Boolean;
      procedure SetTraceDebug(const Value: Boolean);
      procedure SetDoNotUpdate(const Value: Boolean);
   public
      property DoNotUpdate: Boolean read FDoNotUpdate write SetDoNotUpdate;
      property TraceDebug: Boolean read FTraceDebug write SetTraceDebug;
   end;

   TApplicationSettingsConnection = class
   strict private
      FDataBaseName: UnicodeString;
      FServerPath: UnicodeString;
      procedure SetDataBaseName(const Value: UnicodeString);
      procedure SetServerPath(const Value: UnicodeString);
   public
      property DataBaseName: UnicodeString read FDataBaseName write SetDataBaseName;
      property ServerPath: UnicodeString read FServerPath write SetServerPath;
   end;

   TApplicationSettings = class
   strict private
      FCustomize: TApplicationSettingsCustomize;
      FConnection: TApplicationSettingsConnection;
      FSystem: TApplicationSettingsSystem;
      procedure SetSystem(const Value: TApplicationSettingsSystem);
      procedure SetConnection(const Value: TApplicationSettingsConnection);
      procedure SetCustomize(const Value: TApplicationSettingsCustomize);

      function GetConnection: TApplicationSettingsConnection;
      function GetCustomize: TApplicationSettingsCustomize;
      function GetSystem: TApplicationSettingsSystem;
   public
      property Connection: TApplicationSettingsConnection read GetConnection write SetConnection;
      property Customize: TApplicationSettingsCustomize read GetCustomize write SetCustomize;
      property System: TApplicationSettingsSystem read GetSystem write SetSystem;

      destructor Destroy; override;
   end;

   TEnderecoCEP = class
   strict private
      FLogradouro: UnicodeString;
      FBairro: UnicodeString;
      FUF: UnicodeString;
      FCEP: UnicodeString;
      FCidade: UnicodeString;
      procedure SetBairro(const Value: UnicodeString);
      procedure SetCEP(const Value: UnicodeString);
      procedure SetCidade(const Value: UnicodeString);
      procedure SetLogradouro(const Value: UnicodeString);
      procedure SetUF(const Value: UnicodeString);
   public
      property CEP: UnicodeString read FCEP write SetCEP;
      property Logradouro: UnicodeString read FLogradouro write SetLogradouro;
      property Cidade: UnicodeString read FCidade write SetCidade;
      property Bairro: UnicodeString read FBairro write SetBairro;
      property UF: UnicodeString read FUF write SetUF;
   end;

   TWeatherLocation = class
   strict private
      FLatitude: Extended;
      FLongitude: Extended;
      FTemperatura: Currency;
      FPrecipitacao: Currency;
      FSensacao: Currency;
      FCloudCover: Currency;
      FWindSpeed: Currency;
      FDescricao: UnicodeString;
      FWindDirection: UnicodeString;
      FUmidade: Currency;
      procedure SetCloudCover(const Value: Currency);
      procedure SetDescricao(const Value: UnicodeString);
      procedure SetPrecipitacao(const Value: Currency);
      procedure SetSensacao(const Value: Currency);
      procedure SetUmidade(const Value: Currency);
      procedure SetWindDirection(const Value: UnicodeString);
      procedure SetWindSpeed(const Value: Currency);
      procedure SetLatitude(const Value: Extended);
      procedure SetLongitude(const Value: Extended);
      procedure SetTemperatura(const Value: Currency);
   public
      property Latitude: Extended read FLatitude write SetLatitude;
      property Longitude: Extended read FLongitude write SetLongitude;
      property Temperatura: Currency read FTemperatura write SetTemperatura;
      property Umidade: Currency read FUmidade write SetUmidade;
      property Sensacao: Currency read FSensacao write SetSensacao;
      property Precipitacao: Currency read FPrecipitacao write SetPrecipitacao;
      property Descricao: UnicodeString read FDescricao write SetDescricao;
      property WindSpeed: Currency read FWindSpeed write SetWindSpeed;
      property WindDirection: UnicodeString read FWindDirection write SetWindDirection;
      property CloudCover: Currency read FCloudCover write SetCloudCover;
   end;

   TParamsSenderEmail = class
   strict private
      FBodyText: UnicodeString;
      FFromAddress: UnicodeString;
      FFromName: UnicodeString;
      FSubject: UnicodeString;
      FRecipients: TStringList;
      FPort: Word;
      FPassWord: UnicodeString;
      FHost: UnicodeString;
      FUserName: UnicodeString;
      FFileName: UnicodeString;
      procedure SetFileName(const Value: UnicodeString);
      procedure SetBodyText(const Value: UnicodeString);
      procedure SetFromAddress(const Value: UnicodeString);
      procedure SetFromName(const Value: UnicodeString);
      procedure SetHost(const Value: UnicodeString);
      procedure SetPassWord(const Value: UnicodeString);
      procedure SetPort(const Value: Word);
      procedure SetRecipients(const Value: TStringList);
      procedure SetSubject(const Value: UnicodeString);
      procedure SetUserName(const Value: UnicodeString);
   public
      property Port: Word read FPort write SetPort;
      property Host: UnicodeString read FHost write SetHost;
      property UserName: UnicodeString read FUserName write SetUserName;
      property PassWord: UnicodeString read FPassWord write SetPassWord;
      property FromAddress: UnicodeString read FFromAddress write SetFromAddress;
      property FromName: UnicodeString read FFromName write SetFromName;
      property Recipients: TStringList read FRecipients write SetRecipients;
      property Subject: UnicodeString read FSubject write SetSubject;
      property BodyText: UnicodeString read FBodyText write SetBodyText;
      property FileName: UnicodeString read FFileName write SetFileName;

      constructor Create; overload;
      destructor Destroy; override;
   end;

   TFileGoogleDrive = class
   strict private
      FFilePath: UnicodeString;
      FFileName: UnicodeString;
      FLinkDownload: UnicodeString;
      FExtension: UnicodeString;
      FFileId: UnicodeString;
      procedure SetFileId(const Value: UnicodeString);
      procedure SetExtension(const Value: UnicodeString);
      procedure SetFileName(const Value: UnicodeString);
      procedure SetFilePath(const Value: UnicodeString);
      procedure SetLinkDownload(const Value: UnicodeString);
   public
      property FileName: UnicodeString read FFileName write SetFileName;
      property FilePath: UnicodeString read FFilePath write SetFilePath;
      property FileId: UnicodeString read FFileId write SetFileId;
      property LinkDownload: UnicodeString read FLinkDownload write SetLinkDownload;
      property Extension: UnicodeString read FExtension write SetExtension;
   end;

implementation

{ TAppSettingsConnection }

uses App.Common.Utils;

procedure TApplicationSettingsConnection.SetDataBaseName(const Value: UnicodeString);
begin
   FDataBaseName := Value;
end;

procedure TApplicationSettingsConnection.SetServerPath(const Value: UnicodeString);
begin
   FServerPath := Value;
end;

{ TAppSettingsCustomize }

procedure TApplicationSettingsCustomize.SetDisableSpellChecker(
  const Value: Boolean);
begin
  FDisableSpellChecker := Value;
end;

procedure TApplicationSettingsCustomize.SetDisableWeather(const Value: Boolean);
begin
   FDisableWeather := Value;
end;

procedure TApplicationSettingsCustomize.SetRememberUser(const Value: Boolean);
begin
   FRememberUser := Value;
end;

procedure TApplicationSettingsCustomize.SetShowConfirmMessage(const Value: Boolean);
begin
   FShowConfirmMessage := Value;
end;

procedure TApplicationSettingsCustomize.SetUseEscapeKeyToLeave(const Value: Boolean);
begin
   FUseEscapeKeyToLeave := Value;
end;

procedure TApplicationSettingsCustomize.SetUserNameDefault(const Value: UnicodeString);
begin
   FUserNameDefault := Value;
end;

{ TApplicationDirectorys }

function TApplicationDirectorys.GetCommon: UnicodeString;
begin
   FCommon := PathUtils.GetApplicationPath + 'Common';
   Result := FCommon;
end;

function TApplicationDirectorys.GetDownLoad: UnicodeString;
begin
   FDownload := Files + '\Download';
   Result := FDownload;
end;

function TApplicationDirectorys.GetFiles: UnicodeString;
begin
   FFiles := FCommon + '\Files';
   Result := FFiles;
end;

function TApplicationDirectorys.GetHTML: UnicodeString;
begin
   FHTML := FFiles + '\HTML';
   Result := FHTML;
end;

function TApplicationDirectorys.GetImagens: UnicodeString;
begin
   FImagens := FFiles + '\Imagens';
   Result := FImagens;
end;

function TApplicationDirectorys.GetJSON: UnicodeString;
begin
   FJSON := FFiles + '\JSON';
   Result := FJSON;
end;

function TApplicationDirectorys.GetLog: UnicodeString;
begin
   FLog := FFiles + '\Log';
   Result := FLog;
end;

function TApplicationDirectorys.GetSystem: UnicodeString;
begin
   FSystem := PathUtils.GetApplicationPath + 'System';
   Result := FSystem;
end;

function TApplicationDirectorys.GetTemp: UnicodeString;
begin
   FTemp := FFiles + '\Temp';
   Result := FTemp;
end;

procedure TApplicationDirectorys.SetCommon(const Value: UnicodeString);
begin
   FCommon := Value;
end;

procedure TApplicationDirectorys.SetDownload(const Value: UnicodeString);
begin
   FDownload := Value;
end;

procedure TApplicationDirectorys.SetFiles(const Value: UnicodeString);
begin
   FFiles := Value;
end;

procedure TApplicationDirectorys.SetHTML(const Value: UnicodeString);
begin
   FHTML := Value;
end;

procedure TApplicationDirectorys.SetImagens(const Value: UnicodeString);
begin
   FImagens := Value;
end;

procedure TApplicationDirectorys.SetJSON(const Value: UnicodeString);
begin
   FJSON := Value;
end;

procedure TApplicationDirectorys.SetLog(const Value: UnicodeString);
begin
   FLog := Value;
end;

procedure TApplicationDirectorys.SetSystem(const Value: UnicodeString);
begin
   FSystem := Value;
end;

procedure TApplicationDirectorys.SetTemp(const Value: UnicodeString);
begin
   FTemp := Value;
end;

{ TApplicationSettings }

destructor TApplicationSettings.Destroy;
begin
//   AppObject.CheckAndFreeObject(FConnection);
//   AppObject.CheckAndFreeObject(FCustomize);
//   AppObject.CheckAndFreeObject(FSystem);
   inherited Destroy;
end;

function TApplicationSettings.GetConnection: TApplicationSettingsConnection;
begin
   if (not Assigned(FConnection)) then
      FConnection := TApplicationSettingsConnection.Create;

   Result := FConnection;
end;

function TApplicationSettings.GetCustomize: TApplicationSettingsCustomize;
begin
   if (not Assigned(FCustomize)) then
      FCustomize := TApplicationSettingsCustomize.Create;

   Result := FCustomize;
end;

function TApplicationSettings.GetSystem: TApplicationSettingsSystem;
begin
   if (not Assigned(FSystem)) then
      FSystem := TApplicationSettingsSystem.Create;

   Result := FSystem;
end;

procedure TApplicationSettings.SetConnection(const Value: TApplicationSettingsConnection);
begin
   FConnection := Value;
end;

procedure TApplicationSettings.SetCustomize(const Value: TApplicationSettingsCustomize);
begin
   FCustomize := Value;
end;

procedure TApplicationSettings.SetSystem(const Value: TApplicationSettingsSystem);
begin
   FSystem := Value;
end;

{ TEnderecoCEP }

procedure TEnderecoCEP.SetBairro(const Value: UnicodeString);
begin
   FBairro := Value;
end;

procedure TEnderecoCEP.SetCEP(const Value: UnicodeString);
begin
   FCEP := Value;
end;

procedure TEnderecoCEP.SetCidade(const Value: UnicodeString);
begin
   FCidade := Value;
end;

procedure TEnderecoCEP.SetLogradouro(const Value: UnicodeString);
begin
   FLogradouro := Value;
end;

procedure TEnderecoCEP.SetUF(const Value: UnicodeString);
begin
   FUF := Value;
end;

{ TParamsSenderEmail }

constructor TParamsSenderEmail.Create;
begin
   FRecipients := TStringList.Create;
   inherited Create;
end;

destructor TParamsSenderEmail.Destroy;
begin
   FRecipients.Clear;
   FreeAndNil(FRecipients);
   inherited Destroy;
end;

procedure TParamsSenderEmail.SetBodyText(const Value: UnicodeString);
begin
   FBodyText := Value;
end;

procedure TParamsSenderEmail.SetFileName(const Value: UnicodeString);
begin
   FFileName := Value;
end;

procedure TParamsSenderEmail.SetFromAddress(const Value: UnicodeString);
begin
   FFromAddress := Value;
end;

procedure TParamsSenderEmail.SetFromName(const Value: UnicodeString);
begin
   FFromName := Value;
end;

procedure TParamsSenderEmail.SetHost(const Value: UnicodeString);
begin
   FHost := Value;
end;

procedure TParamsSenderEmail.SetPassWord(const Value: UnicodeString);
begin
   FPassWord := Value;
end;

procedure TParamsSenderEmail.SetPort(const Value: Word);
begin
   FPort := Value;
end;

procedure TParamsSenderEmail.SetRecipients(const Value: TStringList);
begin
   FRecipients := Value;
end;

procedure TParamsSenderEmail.SetSubject(const Value: UnicodeString);
begin
   FSubject := Value;
end;

procedure TParamsSenderEmail.SetUserName(const Value: UnicodeString);
begin
   FUserName := Value;
end;

{ TApplicationSettingsSystem }

procedure TApplicationSettingsSystem.SetDoNotUpdate(const Value: Boolean);
begin
   FDoNotUpdate := Value;
end;

procedure TApplicationSettingsSystem.SetTraceDebug(const Value: Boolean);
begin
   FTraceDebug := Value;
end;

{ TFileGoogleDrive }

procedure TFileGoogleDrive.SetExtension(const Value: UnicodeString);
begin
   FExtension := Value;
end;

procedure TFileGoogleDrive.SetFileId(const Value: UnicodeString);
begin
   FFileId := Value;
end;

procedure TFileGoogleDrive.SetFileName(const Value: UnicodeString);
begin
   FFileName := Value;
end;

procedure TFileGoogleDrive.SetFilePath(const Value: UnicodeString);
begin
   FFilePath := Value;
end;

procedure TFileGoogleDrive.SetLinkDownload(const Value: UnicodeString);
begin
   FLinkDownload := Value;
end;

{ TWeatherLocation }

procedure TWeatherLocation.SetCloudCover(const Value: Currency);
begin
   FCloudCover := Value;
end;

procedure TWeatherLocation.SetDescricao(const Value: UnicodeString);
begin
   FDescricao := Value;
end;

procedure TWeatherLocation.SetLatitude(const Value: Extended);
begin
   FLatitude := Value;
end;

procedure TWeatherLocation.SetLongitude(const Value: Extended);
begin
   FLongitude := Value;
end;

procedure TWeatherLocation.SetPrecipitacao(const Value: Currency);
begin
   FPrecipitacao := Value;
end;

procedure TWeatherLocation.SetSensacao(const Value: Currency);
begin
   FSensacao := Value;
end;

procedure TWeatherLocation.SetTemperatura(const Value: Currency);
begin
   FTemperatura := Value;
end;

procedure TWeatherLocation.SetUmidade(const Value: Currency);
begin
   FUmidade := Value;
end;

procedure TWeatherLocation.SetWindDirection(const Value: UnicodeString);
begin
   FWindDirection := Value;
end;

procedure TWeatherLocation.SetWindSpeed(const Value: Currency);
begin
   FWindSpeed := Value;
end;

end.

