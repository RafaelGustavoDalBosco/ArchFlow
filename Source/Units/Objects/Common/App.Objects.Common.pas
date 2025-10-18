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
   public
      property System: UnicodeString read FSystem;
      property Common: UnicodeString read FCommon;
      property Files: UnicodeString read FFiles;
      property Temp: UnicodeString read FTemp;
      property Imagens: UnicodeString read FImagens;
      property HTML: UnicodeString read FHTML;
      property Log: UnicodeString read FLog;
      property JSON: UnicodeString read FJSON;
      property Download: UnicodeString read FDownload;

      constructor Create; overload;
   end;

   TApplicationFiles = class
   strict private
      FSpellChecker_Dic_File: UnicodeString;
      FSpellChecker_Aff_File: UnicodeString;
      FTradution_DevExpress_File: UnicodeString;
   public
      property SpellChecker_Dic_File: UnicodeString read FSpellChecker_Dic_File;
      property SpellChecker_Aff_File: UnicodeString read FSpellChecker_Aff_File;
      property Tradution_DevExpress_File: UnicodeString read FTradution_DevExpress_File;

      constructor Create; overload;
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
      FUseCloudLogin: Boolean;
      procedure SetUseCloudLogin(const Value: Boolean);
      procedure SetTraceDebug(const Value: Boolean);
      procedure SetDoNotUpdate(const Value: Boolean);
   public
      property DoNotUpdate: Boolean read FDoNotUpdate write SetDoNotUpdate;
      property TraceDebug: Boolean read FTraceDebug write SetTraceDebug;
      property UseCloudLogin: Boolean read FUseCloudLogin write SetUseCloudLogin;
   end;

   TApplicationSettingsConnection = class
   strict private
      FDataBaseName: UnicodeString;
      FServerPath: UnicodeString;
      FConnectionType: ShortInt;
      FDataBasePort: SmallInt;
      FDataBasePassWord: UnicodeString;
      FDataBaseUser: UnicodeString;
      procedure SetDataBasePassWord(const Value: UnicodeString);
      procedure SetDataBasePort(const Value: SmallInt);
      procedure SetDataBaseUser(const Value: UnicodeString);
      procedure SetConnectionType(const Value: ShortInt);
      procedure SetDataBaseName(const Value: UnicodeString);
      procedure SetServerPath(const Value: UnicodeString);
   public
      property DataBaseName: UnicodeString read FDataBaseName write SetDataBaseName;
      property ServerPath: UnicodeString read FServerPath write SetServerPath;
      property ConnectionType: ShortInt read FConnectionType write SetConnectionType;
      property DataBaseUser: UnicodeString read FDataBaseUser write SetDataBaseUser;
      property DataBasePassWord: UnicodeString read FDataBasePassWord write SetDataBasePassWord;
      property DataBasePort: SmallInt read FDataBasePort write SetDataBasePort;
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

   TCompanyCloud = class
   strict private
      FDataBase_PassWord: UnicodeString;
      FDataBase_User: UnicodeString;
      FDataBase_Name: UnicodeString;
      FPort: SmallInt;
      FServer: UnicodeString;
      FExpiration_Date: TDateTime;
      FRazaoSocial: UnicodeString;
      procedure SetRazaoSocial(const Value: UnicodeString);
      procedure SetExpiration_Date(const Value: TDateTime);
      procedure SetDataBase_Name(const Value: UnicodeString);
      procedure SetDataBase_PassWord(const Value: UnicodeString);
      procedure SetDataBase_User(const Value: UnicodeString);
      procedure SetPort(const Value: SmallInt);
      procedure SetServer(const Value: UnicodeString);
   public
      property DataBase_Name: UnicodeString read FDataBase_Name write SetDataBase_Name;
      property Server: UnicodeString read FServer write SetServer;
      property Port: SmallInt read FPort write SetPort;
      property DataBase_User: UnicodeString read FDataBase_User write SetDataBase_User;
      property DataBase_PassWord: UnicodeString read FDataBase_PassWord write SetDataBase_PassWord;
      property Expiration_Date: TDateTime read FExpiration_Date write SetExpiration_Date;
      property RazaoSocial: UnicodeString read FRazaoSocial write SetRazaoSocial;
   end;

implementation

{ TAppSettingsConnection }

uses App.Common.Utils, App.System.Vars, App.System.Consts;

procedure TApplicationSettingsConnection.SetConnectionType(const Value: ShortInt);
begin
   FConnectionType := Value;
end;

procedure TApplicationSettingsConnection.SetDataBaseName(const Value: UnicodeString);
begin
   FDataBaseName := Value;
end;

procedure TApplicationSettingsConnection.SetDataBasePassWord(const Value: UnicodeString);
begin
   FDataBasePassWord := Value;
end;

procedure TApplicationSettingsConnection.SetDataBasePort(const Value: SmallInt);
begin
   FDataBasePort := Value;
end;

procedure TApplicationSettingsConnection.SetDataBaseUser(const Value: UnicodeString);
begin
   FDataBaseUser := Value;
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

constructor TApplicationDirectorys.Create;
begin
   FSystem := PathUtils.GetApplicationPath + 'System';
   FCommon := PathUtils.GetApplicationPath + 'Common';
   FFiles := FCommon + '\Files';
   FDownload := FFiles + '\Download';
   FHTML := FFiles + '\HTML';
   FImagens := FFiles + '\Imagens';
   FJSON := FFiles + '\JSON';
   FLog := FFiles + '\Log';
   FTemp := FFiles + '\Temp';
   inherited Create;
end;

{ TApplicationSettings }

destructor TApplicationSettings.Destroy;
begin
   FConnection.Destroy;
   FCustomize.Destroy;
   FSystem.Destroy;
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

procedure TApplicationSettingsSystem.SetUseCloudLogin(const Value: Boolean);
begin
   FUseCloudLogin := Value;
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

{ TCompanyCloud }

procedure TCompanyCloud.SetDataBase_Name(const Value: UnicodeString);
begin
   FDataBase_Name := Value;
end;

procedure TCompanyCloud.SetDataBase_PassWord(const Value: UnicodeString);
begin
   FDataBase_PassWord := Value;
end;

procedure TCompanyCloud.SetDataBase_User(const Value: UnicodeString);
begin
   FDataBase_User := Value;
end;

procedure TCompanyCloud.SetExpiration_Date(const Value: TDateTime);
begin
   FExpiration_Date := Value;
end;

procedure TCompanyCloud.SetPort(const Value: SmallInt);
begin
   FPort := Value;
end;

procedure TCompanyCloud.SetRazaoSocial(const Value: UnicodeString);
begin
   FRazaoSocial := Value;
end;

procedure TCompanyCloud.SetServer(const Value: UnicodeString);
begin
   FServer := Value;
end;

{ TApplicationFiles }

constructor TApplicationFiles.Create;
begin
   FSpellChecker_Dic_File := gvDirectories.Files + '\' + SName_SpellChecker_DicFile;
   FSpellChecker_Aff_File := gvDirectories.Files + '\' + SName_SpellChecker_AffFile;
   FTradution_DevExpress_File := gvDirectories.Files + '\' + SName_Tradution_File;
   inherited Create;
end;

end.

