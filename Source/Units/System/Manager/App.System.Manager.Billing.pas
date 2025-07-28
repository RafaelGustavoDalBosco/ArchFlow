unit App.System.Manager.Billing;

interface

uses

{$REGION '| USES |'}
   System.SysUtils, System.JSON, System.JSON.Types, App.Common.Utils,
   App.System.Controller.AmazonCloud,
   App.Common.Consts,
   System.Classes,
   System.JSON.Readers,
   App.Objects.Entity.Empresa,
   App.Objects.Entity.Default;
{$ENDREGION}

type

   TManagerBilling = class
   private
      FEmpresa: TEmpresa;
   strict protected
      /// <summary>
      ///    ProcessFileFromAWS<JSON>
      /// </summary>
      procedure ProcessFileFromAWS;

      /// <summary>
      ///    UpdateCompanyExpirationDate<Date>
      /// </summary>
      procedure UpdateExpirationDate(const ADate: TDate);

      /// <summary>
      ///    GetContentFromFile<JSON>
      /// </summary>
      function GetContentFileFromAWS: UnicodeString;

      /// <summary>
      ///    CheckAndRaiseIfExpired<Date>
      /// </summary>
      function CheckAndRaiseIfExpired(const ADate: TDate): Boolean;

      /// <summary>
      ///    CheckOnDataBase
      /// </summary>
      function CheckOnDataBase: Boolean;
   public
      /// <summary>
      ///    Execute
      /// </summary>
      function Execute: Boolean;

      constructor Create(const AIdEmpresa: Int64); overload;
      destructor Destroy; override;
   end;

implementation

{ TManagerBilling }

function TManagerBilling.CheckAndRaiseIfExpired(const ADate: TDate): Boolean;
begin
   if (ADate < Now) then
      raise Exception.CreateFmt('A licença venceu em %s!' + sLineBreak + 'Entre em contato com o financeiro! 45-99802-3547 Rafael Dal Bosco', [DateToStr(ADate)])
   else
      Result := True;
end;

function TManagerBilling.CheckOnDataBase: Boolean;
var
   LApplication: TApplicationInformation;
begin
   LApplication := AppPersistent.SelectAndCreateNewObject(TApplicationInformation, 1) as TApplicationInformation;

   if (LApplication <> nil) then
   begin
      Result := (LApplication.ExpirationDate >= Now);
      FreeAndNil(LApplication);
   end
   else
      Result := False;
end;

constructor TManagerBilling.Create(const AIdEmpresa: Int64);
begin
   FEmpresa := AppPersistent.SelectAndCreateNewObject(TEmpresa, AIdEmpresa) as TEmpresa;
   inherited Create;
end;

destructor TManagerBilling.Destroy;
begin
   AppObject.CheckAndFreeObject(FEmpresa);
   inherited Destroy;
end;

function TManagerBilling.Execute: Boolean;
begin
   Result := True;

   if (not CheckOnDataBase) then
      ProcessFileFromAWS;
end;

function TManagerBilling.GetContentFileFromAWS: UnicodeString;
var
   LController: TAmazonS3Controller;
begin
   AppWatcher.ShowAWS('Obtendo validação financeira na Nuvem {AWS}...');
   LController := TAmazonS3Controller.Create;
   try
      Result := LController.TryGetFileDataToString(SNameFileClientValidations, SNameBucketClientValidations);
   finally
      FreeAndNil(LController);
      AppWatcher.Close;
   end;
end;

procedure TManagerBilling.ProcessFileFromAWS;
var
   LContent: UnicodeString;
   LStringReader: TStringReader;
   LJSONReader: TJsonTextReader;
   LCpfCnpj: UnicodeString;
   LDataExpired: TDate;
   LFound: Boolean;
begin
   LContent := GetContentFileFromAWS;

   LStringReader := TStringReader.Create(LContent);
   LJSONReader := TJsonTextReader.Create(LStringReader);
   try
      LFound := False;

      while LJSONReader.Read do
      begin
         if (LJSONReader.TokenType = TJsonToken.PropertyName) then
         begin
            LCpfCnpj := AppJSON.TryGetValueStringFromPath(LJSONReader, 'cpfcnpj');

            if LCpfCnpj.Equals(FEmpresa.CpfCnpj) then
            begin
               LFound := True;

               LDataExpired := AppJSON.TryGetValueDateFromPath(LJSONReader, 'data');

               if CheckAndRaiseIfExpired(LDataExpired) then
                  UpdateExpirationDate(LDataExpired);
            end;
         end;
      end;

      if (not LFound) then
         raise Exception.Create('Não foi encontrado uma licença válida para o CNPJ!');
   finally
      FreeAndNil(LJSONReader);
      FreeAndNil(LStringReader);
   end;
end;

procedure TManagerBilling.UpdateExpirationDate(const ADate: TDate);
var
   LApplication: TApplicationInformation;
begin
   LApplication := AppPersistent.SelectAndCreateNewObject(TApplicationInformation, 1) as TApplicationInformation;

   if (LApplication <> nil) and (LApplication.ExpirationDate <> ADate) then
   begin
      LApplication.ExpirationDate := ADate;
      AppPersistent.Update(LApplication);
      FreeAndNil(LApplication);
   end;
end;

end.

