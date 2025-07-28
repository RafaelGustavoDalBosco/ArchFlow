unit App.Objects.Entity.Usuario.Acccess;

interface

uses
   App.Objects.Entity.Default, App.System.ORM.CustomAttributes, App.DataBase.Consts;

type

   [TTable(STable_Usuario_Access, STable_Usuario_Access_Comment)]
   [TObjectProperties(True)]
   TUsuarioAccess = class(TEntityCommon)
   strict private
      FDescricao: UnicodeString;
      FIdUsuario: Int64;
      FCanAccess: Boolean;
      FCanDelete: Boolean;
      FCanUpdate: Boolean;
      FFormClass: UnicodeString;
      FCanInsert: Boolean;
      procedure SetCanAccess(const Value: Boolean);
      procedure SetCanDelete(const Value: Boolean);
      procedure SetCanInsert(const Value: Boolean);
      procedure SetCanUpdate(const Value: Boolean);
      procedure SetDescricao(const Value: UnicodeString);
      procedure SetFormClass(const Value: UnicodeString);
      procedure SetIdUsuario(const Value: Int64);
   public
      [TField(SField_Id_Usuario, True)]
      [TFieldInt64]
      [TFieldForeignKey(SField_Id, STable_Usuario)]
      property IdUsuario: Int64 read FIdUsuario write SetIdUsuario;

      [TField(SField_Form_Class, True)]
      [TFieldString(50)]
      property FormClass: UnicodeString read FFormClass write SetFormClass;

      [TField(SField_Descricao, True)]
      [TFieldString(50)]
      property Descricao: UnicodeString read FDescricao write SetDescricao;

      [TField(SField_Can_Access, True)]
      [TFieldBoolean]
      property CanAccess: Boolean read FCanAccess write SetCanAccess;

      [TField(SField_Can_Insert, True)]
      [TFieldBoolean]
      property CanInsert: Boolean read FCanInsert write SetCanInsert;

      [TField(SField_Can_Update, True)]
      [TFieldBoolean]
      property CanUpdate: Boolean read FCanUpdate write SetCanUpdate;

      [TField(SField_Can_Delete, True)]
      [TFieldBoolean]
      property CanDelete: Boolean read FCanDelete write SetCanDelete;
   end;

implementation

{ TUsuarioAccess }

procedure TUsuarioAccess.SetCanAccess(const Value: Boolean);
begin
   FCanAccess := Value;
end;

procedure TUsuarioAccess.SetCanDelete(const Value: Boolean);
begin
   FCanDelete := Value;
end;

procedure TUsuarioAccess.SetCanInsert(const Value: Boolean);
begin
   FCanInsert := Value;
end;

procedure TUsuarioAccess.SetCanUpdate(const Value: Boolean);
begin
   FCanUpdate := Value;
end;

procedure TUsuarioAccess.SetDescricao(const Value: UnicodeString);
begin
   FDescricao := Value;
end;

procedure TUsuarioAccess.SetFormClass(const Value: UnicodeString);
begin
   FFormClass := Value;
end;

procedure TUsuarioAccess.SetIdUsuario(const Value: Int64);
begin
   FIdUsuario := Value;
end;

end.
