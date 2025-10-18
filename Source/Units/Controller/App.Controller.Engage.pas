unit App.Controller.Engage;

interface

uses
   System.SysUtils, App.System.Connection, App.System.Types;

type

   TControllerEngage = class
   private
      /// <summary>
      ///    Abre a tela de configuração de database, e coloca no out
      ///    as variavéis necessárias para iniciar a conexão com o banco de dados
      /// </summary>
      /// <param name="ADataBaseName">
      ///    Nome do banco de dados
      /// </param>
      /// <param name="AServer">
      ///    local do banco de dados (local, remoto)
      /// </param>
      /// <param name="ADataBaseUser">
      ///    Nome do usuário do banco de dados Ex.: postgres
      /// </param>
      /// <param name="ADataBasePassWord">
      ///    Senha do banco de dados Ex.: postgres
      /// </param>
      /// <param name="APort">
      ///    Número da porta de conexão
      /// </param>
      /// <param name="ATypeConnection">
      ///    Tipo da Conexão com o banco de dados | local ou remoto
      /// </param>
      procedure Open_Engage_Form(out ADataBaseName, AServer, ADataBaseUser, ADataBasePassWord: UnicodeString; out APort: SmallInt; out ATypeConnection: TTypeConnection);
   protected
      /// <summary>
      ///    Inicia as variaveis globais da aplicação
      /// </summary>
      procedure Engage_GlobalVariables;

      /// <summary>
      ///    Destroi a instância das variaveis globais
      /// </summary>
      procedure Finalize_GlobalVariables;

      /// <summary>
      ///    Cria os diretórios da aplicação
      /// </summary>
      procedure Engage_Folders;

      /// <summary>
      ///    Inicia o motor do banco de dados
      /// </summary>
      procedure Engage_DataBase;

      /// <summary>
      ///    Verifica se a base de dados existe localmente
      /// </summary>
      function Check_DataBase_Local: Boolean;
   strict protected
      /// <summary>
      ///    GetConnectionParams: Cria o objeto TConnectionParams que será usado na conexão
      /// </summary>
      function Get_Connection_Params(const ADataBaseName, AServer: UnicodeString): TConnectionParams;

      /// <summary>
      ///    Inicia a conexão com o banco de dados
      /// </summary>
      function Engage_Connection: Boolean;
   public
      /// <summary>
      ///    Inicia a aplicação
      /// </summary>
      /// <remarks>
      ///    Caso alguma validação, não tenha sido concluída com sucesso
      ///    esta função irá retornar False, e a aplicação não será iniciada
      /// </remarks>
      function Execute: Boolean;

      destructor Destroy; override;
   end;

implementation

{ TControllerEngage }

uses
   App.System.Vars,
   App.Common.Vars,
   App.Objects.Common,
   App.Common.Utils,
   App.Common.Files.Settings,
   App.System.Engine.DataBase,
   Frm.System.Engage,
   App.System.SQL.Pattern,
   App.System.Connection.Query;

function TControllerEngage.Check_DataBase_Local: Boolean;
var
   LQuery: TQuery;
begin
   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(AppSQLPatternDB.DataBaseOnSchemaPostGres);

      Result := LQuery.GetData;
   finally
      FreeAndNil(LQuery);
   end;
end;

destructor TControllerEngage.Destroy;
begin
   Finalize_GlobalVariables;
   inherited Destroy;
end;

function TControllerEngage.Engage_Connection: Boolean;
var
   LParams: TConnectionParams;
   LDataBaseName, LServerPath, LUserName, LPassWord: UnicodeString;
   LPort: SmallInt;
begin
   LDataBaseName := gvSettings.Connection.DataBaseName;
   LServerPath := gvSettings.Connection.ServerPath;

   gvTypeConnection := TTypeConnection(gvSettings.Connection.ConnectionType);

   if (LDataBaseName.IsEmpty) or (LServerPath.IsEmpty) then
      Open_Engage_Form(LDataBaseName, LServerPath, LUserName, LPassWord, LPort, gvTypeConnection);

   LParams := Get_Connection_Params(LDataBaseName, LServerPath);

   gvConnection := TConnection.Create(LParams);

   if (gvTypeConnection = tcLocal) then
   begin
      gvConnection.IncludeParamsOnConnection(False);
      gvConnection.TryConnect;

      if (not Check_DataBase_Local) then
         gvConnection.ExecuteScript(AppSQLPatternDB.CreateDataBase(LDataBaseName));
   end;

   gvConnection.IncludeParamsOnConnection;

   Result := gvConnection.TryConnect;
end;

procedure TControllerEngage.Engage_DataBase;
var
   LEngine: TSystemEngineDataBase;
begin
   LEngine := TSystemEngineDataBase.Create;
   try
      LEngine.Execute;
   finally
      FreeAndNil(LEngine);
   end;
end;

procedure TControllerEngage.Engage_Folders;
begin
   FileUtils.CheckAndCreate_Folder(gvDirectories.System);
   FileUtils.CheckAndCreate_Folder(gvDirectories.Common);
   FileUtils.CheckAndCreate_Folder(gvDirectories.Files);
   FileUtils.CheckAndCreate_Folder(gvDirectories.Temp);
   FileUtils.CheckAndCreate_Folder(gvDirectories.Imagens);
   FileUtils.CheckAndCreate_Folder(gvDirectories.HTML);
   FileUtils.CheckAndCreate_Folder(gvDirectories.Log);
   FileUtils.CheckAndCreate_Folder(gvDirectories.JSON);
   FileUtils.CheckAndCreate_Folder(gvDirectories.Download);
end;

procedure TControllerEngage.Engage_GlobalVariables;
begin
   gvDirectories := TApplicationDirectorys.Create;
   gvSettings := TFileSettings.Load;
   gvFiles := TApplicationFiles.Create;
end;

function TControllerEngage.Execute: Boolean;
begin
   Engage_GlobalVariables;
   Engage_Folders;

   if (not Engage_Connection) then
     Exit(False);

   Engage_DataBase;

   Result := True;
//   var
//   LCognito: TCognitoAuth;
//begin
//   LCognito := TCognitoAuth.Create(
//    'https://sa-east-106pmdusam.auth.sa-east-1.amazoncognito.com',
//    '12d99e9s4httrq293hvssmi9vo',
//    53682
//  );
//  LCognito.BeginLogin;

end;

procedure TControllerEngage.Finalize_GlobalVariables;
begin
   gvConnection.GetFDConnection.Close;
   FreeAndNil(gvConnection);
   gvDirectories.Destroy;
   gvSettings.Destroy;
   gvFiles.Destroy;
end;

function TControllerEngage.Get_Connection_Params(const ADataBaseName, AServer: UnicodeString): TConnectionParams;
begin
   Result := TConnectionParams.Create;
   Result.DriverName := 'PG';
   Result.LoginPrompt := False;
   Result.CharacterSet := 'UTF-8';
   Result.UserName := gvSettings.Connection.DataBaseUser;
   Result.PassWord := gvSettings.Connection.DataBasePassWord;
   Result.Port := gvSettings.Connection.DataBasePort;
   Result.Server := AServer;
   Result.DataBasePath := ADataBaseName;
end;

procedure TControllerEngage.Open_Engage_Form(out ADataBaseName, AServer, ADataBaseUser, ADataBasePassWord: UnicodeString; out APort: SmallInt; out ATypeConnection: TTypeConnection);
var
   LForm: TFrmSystemEngage;
begin
   LForm := TFrmSystemEngage.Create(nil);
   try
      LForm.ShowModal;

      if (LForm.TypeResultAction = traConfirmed) then
      begin
         ADataBaseName := LForm.DataBaseName;
         AServer := LForm.Server;
         ADataBaseUser := LForm.DataBaseUser;
         ADataBasePassWord := LForm.DataBasePassWord;
         APort := LForm.Port;
         ATypeConnection := LForm.TypeConnection;

         if (LForm.TypeConnection = tcLocal) then
         begin
            ADataBaseUser := 'postgres';
            ADataBasePassWord := 'postgres';
         end;

         // -> Escreve essas configurações no arquivo de settings
         gvSettings.Connection.DataBaseName := ADataBaseName;
         gvSettings.Connection.ServerPath := AServer;
         gvSettings.Connection.ConnectionType := Ord(gvTypeConnection);
         gvSettings.Connection.DataBaseUser := ADataBaseUser;
         gvSettings.Connection.DataBasePassWord := ADataBasePassWord;
         gvSettings.Connection.DataBasePort := APort;

         TFileSettings.Write(gvSettings);
      end;
   finally
      FreeAndNil(LForm);
   end;
end;

end.
