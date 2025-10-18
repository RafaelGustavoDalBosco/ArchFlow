unit App.System.Manager.Company.Cloud;

interface

uses

{$REGION '| USES |'}
   System.JSON.Types,
   System.Classes,
   System.JSON.Readers,
   System.JSON,
   System.SysUtils,
   App.Objects.Common,
   App.Controller.AmazonCloud.S3,
   App.System.Consts;
{$ENDREGION}

type

   TManagerCompanyCloud = class
   private
      FCNPJ: UnicodeString;
   strict protected
      /// <summary>
      ///   Obtém o contéudo do arquivo da empresa na AWS
      /// </summary>
      function GetContent_File_From_AWS: UnicodeString;
   public
      /// <summary>
      ///  Obtém o objeto TCompanyCloud com as properties de conexão na AWS S3
      /// </summary>
      function Get_Company_Cloud: TCompanyCloud;

      /// <param name="ACNPJ">
      ///    CNPJ que será obtido as informações da AWS S3
      /// </param>
      constructor Create(const ACNPJ: UnicodeString);
   end;

implementation

uses
   App.Common.Utils;

{ TManagerCompanyCloud }

constructor TManagerCompanyCloud.Create(const ACNPJ: UnicodeString);
begin
   FCNPJ := ACNPJ;
   inherited Create;
end;

function TManagerCompanyCloud.GetContent_File_From_AWS: UnicodeString;
var
   LController: TAmazonS3Controller;
begin
   LController := TAmazonS3Controller.Create;
   try
      Result := LController.TryGetFileDataToString(Format(SName_File_Company_Cloud, [FCNPJ]), SName_Bucket_Company_Cloud);
   finally
      FreeAndNil(LController);
   end;
end;

function TManagerCompanyCloud.Get_Company_Cloud: TCompanyCloud;
var
   LContent: UnicodeString;
   LStringReader: TStringReader;
   LJSONReader: TJsonTextReader;
begin
   LContent := GetContent_File_From_AWS;

   if (LContent.IsEmpty) then
      Exit(nil);

   LStringReader := TStringReader.Create(LContent);
   LJSONReader := TJsonTextReader.Create(LStringReader);
   try
      Result := TCompanyCloud.Create;

      while LJSONReader.Read do
      begin
         if (LJSONReader.TokenType = TJsonToken.PropertyName) then
         begin
            Result.DataBase_Name := JSONUtils.TryGetValueStringFromPath(LJSONReader, 'database_name');
            Result.Server := JSONUtils.TryGetValueStringFromPath(LJSONReader, 'server');
            Result.Port := JSONUtils.TryGetValueIntegerFromPath(LJSONReader, 'port');
            Result.DataBase_User := JSONUtils.TryGetValueStringFromPath(LJSONReader, 'database_user');
            Result.DataBase_PassWord := JSONUtils.TryGetValueStringFromPath(LJSONReader, 'database_password');
            Result.Expiration_Date := JSONUtils.TryGetValueDateFromPath(LJSONReader, 'data_expiration');
            Result.RazaoSocial := JSONUtils.TryGetValueStringFromPath(LJSONReader, 'razao_social');
         end;
      end;
   finally
      FreeAndNil(LJSONReader);
      FreeAndNil(LStringReader);
   end;
end;

end.
