unit App.Objects.Entity.ApplicationData;

interface

uses
   App.Objects.Entity.Default, System.SysUtils, System.Classes, App.System.ORM.CustomAttributes, App.DataBase.Consts;

type

   [TTable(STable_Application_Data, STable_ApplicationData_Comment)]
   TApplicationData = class
   strict private
      FVersion: UnicodeString;
      FExpirationDate: TDate;
      FTokenAPIGoogle: UnicodeString;
      FLastUpdatedDate: TDate;
      FTokenAPIGoogle_ExpiresIn: TDateTime;
      FGoogleWorkSpace: Boolean;
      procedure SetGoogleWorkSpace(const Value: Boolean);
      procedure SetExpirationDate(const Value: TDate);
      procedure SetLastUpdatedDate(const Value: TDate);
      procedure SetTokenAPIGoogle(const Value: UnicodeString);
      procedure SetTokenAPIGoogle_ExpiresIn(const Value: TDateTime);
      procedure SetVersion(const Value: UnicodeString);
   public
      [TField(SField_Version)]
      [TFieldString(20)]
      property Version: UnicodeString read FVersion write SetVersion;

      [TField(SField_Last_Updated_Date)]
      [TFieldDate]
      property LastUpdatedDate: TDate read FLastUpdatedDate write SetLastUpdatedDate;

      [TField(SField_Expiration_Date)]
      [TFieldDate]
      property ExpirationDate: TDate read FExpirationDate write SetExpirationDate;

      [TField(SField_GoogleWorkSpace)]
      [TFieldBoolean]
      property GoogleWorkSpace: Boolean read FGoogleWorkSpace write SetGoogleWorkSpace;

      [TField(SField_Token_API_Google)]
      [TFieldString(1000)]
      [TFieldIndex]
      property TokenAPIGoogle: UnicodeString read FTokenAPIGoogle write SetTokenAPIGoogle;

      [TField(SField_Token_API_Google_ExpiresIn)]
      [TFieldDateTime]
      property TokenAPIGoogle_ExpiresIn: TDateTime read FTokenAPIGoogle_ExpiresIn write SetTokenAPIGoogle_ExpiresIn;
   end;

implementation

{ TApplicationData }

procedure TApplicationData.SetExpirationDate(const Value: TDate);
begin
   FExpirationDate := Value;
end;

procedure TApplicationData.SetGoogleWorkSpace(const Value: Boolean);
begin
   FGoogleWorkSpace := Value;
end;

procedure TApplicationData.SetLastUpdatedDate(const Value: TDate);
begin
   FLastUpdatedDate := Value;
end;

procedure TApplicationData.SetTokenAPIGoogle(const Value: UnicodeString);
begin
   FTokenAPIGoogle := Value;
end;

procedure TApplicationData.SetTokenAPIGoogle_ExpiresIn(const Value: TDateTime);
begin
   FTokenAPIGoogle_ExpiresIn := Value;
end;

procedure TApplicationData.SetVersion(const Value: UnicodeString);
begin
   FVersion := Value;
end;

initialization
   TRegisterClass.Register(TApplicationData);
end.
