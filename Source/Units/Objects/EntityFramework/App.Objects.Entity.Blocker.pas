unit App.Objects.Entity.Blocker;

interface

uses
   App.Objects.Entity.Default, System.SysUtils, System.Classes, App.System.ORM.CustomAttributes, App.DataBase.Consts;

type

   [TTable(STable_Common_Blocker, STable_Common_Blocker_Comment)]
   TEntityCommonBlocker = class(TEntity)
   strict private
      FIdEmpresa: Int64;
      FIdRecord: Int64;
      FIdUsuario: Int64;
      FClassParentName: UnicodeString;
      FUserName: Unicodestring;
      procedure SetClassParentName(const Value: UnicodeString);
      procedure SetIdEmpresa(const Value: Int64);
      procedure SetIdRecord(const Value: Int64);
      procedure SetIdUsuario(const Value: Int64);
      procedure SetUserName(const Value: Unicodestring);
   public
      [TField(SField_Id_Empresa, True)]
      [TFieldInt64]
      [TFieldForeignKey(SField_Id, STable_Empresa)]
      [TFieldParam]
      property IdEmpresa: Int64 read FIdEmpresa write SetIdEmpresa;

      [TField(SField_Id_Record, True)]
      [TFieldInt64]
      [TFieldParam]
      property IdRecord: Int64 read FIdRecord write SetIdRecord;

      [TField(SField_Id_Usuario, True)]
      [TFieldInt64]
      [TFieldForeignKey(SField_Id, STable_Usuario)]
      property IdUsuario: Int64 read FIdUsuario write SetIdUsuario;

      [TField(SField_Class_Parent_Name, True)]
      [TFieldString(60)]
      [TFieldIndex]
      property ClassParentName: UnicodeString read FClassParentName write SetClassParentName;

      [TField(SField_UserName)]
      [TFieldString(120)]
      [TFieldIndex]
      property UserName: Unicodestring read FUserName write SetUserName;
   end;

implementation

{ TEntityCommonBlocker }

procedure TEntityCommonBlocker.SetClassParentName(const Value: UnicodeString);
begin
   FClassParentName := Value;
end;

procedure TEntityCommonBlocker.SetIdEmpresa(const Value: Int64);
begin
   FIdEmpresa := Value;
end;

procedure TEntityCommonBlocker.SetIdRecord(const Value: Int64);
begin
   FIdRecord := Value;
end;

procedure TEntityCommonBlocker.SetIdUsuario(const Value: Int64);
begin
   FIdUsuario := Value;
end;

procedure TEntityCommonBlocker.SetUserName(const Value: Unicodestring);
begin
   FUserName := Value;
end;

initialization
   TRegisterClass.Register(TEntityCommonBlocker);
end.
