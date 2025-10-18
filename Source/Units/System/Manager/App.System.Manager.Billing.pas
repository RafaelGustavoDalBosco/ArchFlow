unit App.System.Manager.Billing;

interface

uses

{$REGION '| USES |'}
   System.SysUtils, System.JSON, System.JSON.Types, App.Common.Utils,
   App.Common.Consts,
   System.Classes,
   System.JSON.Readers,
   App.Objects.Entity.Empresa,
   App.Objects.Entity.Default, App.Controller.AmazonCloud.S3,
   App.Objects.Entity.ApplicationData, App.System.ORM.Utils, App.System.Consts,
  App.Objects.Common;
{$ENDREGION}

type

   TManagerBilling = class
   private
      FCNPJ: UnicodeString;
   strict protected
      /// <summary>
      ///   Atualiza a data de expiração na tabela TAPPLICATION_DATA
      /// </summary>
      /// <param name="ADate">
      ///    Data que será atualizada
      /// </param>
      procedure UpdateExpirationDate(const ADate: TDate);
      /// <summary>
      ///    Se a data de expiração é menor que a atual, então raise exception
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

      /// <param name="ACNPJ">
      ///    Executa o manager de acordo com a empresa [CNPJ]
      /// </param>
      constructor Create(const ACNPJ: UnicodeString); overload;
      destructor Destroy; override;
   end;

implementation

uses
    App.System.Manager.Company.Cloud;

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
   LApplication: TApplicationData;
begin
   LApplication := TApplicationData.Create;
   try
      LApplication.Id := 1; // always 1

      if ORMUtils.Select_Record(LApplication) then
         Exit(LApplication.ExpirationDate >= Now)
      else
         Result := False;
   finally
      FreeAndNil(LApplication);
   end;
end;

constructor TManagerBilling.Create(const ACNPJ: UnicodeString);
begin
   FCNPJ := ACNPJ;
   inherited Create;
end;

destructor TManagerBilling.Destroy;
begin
   inherited Destroy;
end;

function TManagerBilling.Execute: Boolean;
var
   LCompanyCloud: TCompanyCloud;
   LManager: TManagerCompanyCloud;
begin
   Result := True;

   if (not CheckOnDataBase) then
   begin
      LManager := TManagerCompanyCloud.Create(FCNPJ);
      try
         LCompanyCloud := LManager.Get_Company_Cloud;

         if (LCompanyCloud <> nil) then
         begin
            if CheckAndRaiseIfExpired(LCompanyCloud.Expiration_Date) then
               UpdateExpirationDate(LCompanyCloud.Expiration_Date);
         end;
      finally
         FreeAndNil(LManager);
      end;
   end;
end;

procedure TManagerBilling.UpdateExpirationDate(const ADate: TDate);
var
   LApplication: TApplicationData;
begin
   LApplication := TApplicationData.Create;
   try
      LApplication.Id := 1; // always 1

      if ORMUtils.Select_Record(LApplication) then
      begin
         if (LApplication.ExpirationDate <> ADate) then
         begin
            LApplication.ExpirationDate := ADate;
            ORMUtils.Edit_Record(LApplication);
         end;
      end;
   finally
      FreeAndNil(LApplication);
   end;
end;

end.

