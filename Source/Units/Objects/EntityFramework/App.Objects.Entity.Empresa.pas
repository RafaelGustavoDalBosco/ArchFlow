unit App.Objects.Entity.Empresa;

interface

uses
   App.Objects.Entity.Default, System.SysUtils, System.Classes, App.System.ORM.CustomAttributes,
   App.DataBase.Consts;

type

   [TTable(STable_Empresa, STable_Empresa_Comment)]
   [TObjectProperties(True)]
   TEmpresa = class(TEntity)
   strict private
      FTipoPessoa: ShortInt;
      FCpfCnpj: UnicodeString;
      FRazaoSocial: UnicodeString;
      FLogo: TMemoryStream;
      FActive: Boolean;
      FNomeFantasia: UnicodeString;
      procedure SetActive(const Value: Boolean);
      procedure SetCpfCnpj(const Value: UnicodeString);
      procedure SetLogo(const Value: TMemoryStream);
      procedure SetNomeFantasia(const Value: UnicodeString);
      procedure SetRazaoSocial(const Value: UnicodeString);
      procedure SetTipoPessoa(const Value: ShortInt);
   public
      [TField(SField_RazaoSocial, True)]
      [TFieldString(60)]
      property RazaoSocial: UnicodeString read FRazaoSocial write SetRazaoSocial;

      [TField(SField_Nome_Fantasia)]
      [TFieldString(60)]
      property NomeFantasia: UnicodeString read FNomeFantasia write SetNomeFantasia;

      [TField(SField_CpfCnpj)]
      [TFieldString(14)]
      property CpfCnpj: UnicodeString read FCpfCnpj write SetCpfCnpj;

      [TField(SField_Tipo_Pessoa, True)]
      [TFieldShortInt(1, 2)]
      property TipoPessoa: ShortInt read FTipoPessoa write SetTipoPessoa;

      [TField(SField_Active, True)]
      [TFieldBoolean]
      property Active: Boolean read FActive write SetActive;

      [TField(SField_Logo)]
      [TFieldBytea]
      property Logo: TMemoryStream read FLogo write SetLogo;
   end;

implementation

{ TEmpresa }

procedure TEmpresa.SetActive(const Value: Boolean);
begin
   FActive := Value;
end;

procedure TEmpresa.SetCpfCnpj(const Value: UnicodeString);
begin
   FCpfCnpj := Value;
end;

procedure TEmpresa.SetLogo(const Value: TMemoryStream);
begin
   FLogo := Value;
end;

procedure TEmpresa.SetNomeFantasia(const Value: UnicodeString);
begin
   FNomeFantasia := Value;
end;

procedure TEmpresa.SetRazaoSocial(const Value: UnicodeString);
begin
   FRazaoSocial := Value;
end;

procedure TEmpresa.SetTipoPessoa(const Value: ShortInt);
begin
   FTipoPessoa := Value;
end;

initialization
   TRegisterClass.Register(TEmpresa);
end.
