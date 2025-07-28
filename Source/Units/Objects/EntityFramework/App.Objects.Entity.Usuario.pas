unit App.Objects.Entity.Usuario;

interface

uses
   App.Objects.Entity.Default, System.SysUtils, System.Classes, App.System.ORM.CustomAttributes, App.DataBase.Consts, App.Common.Types;

type

   [TTable(STable_Usuario, STable_Usuario_Comment)]
   [TObjectProperties(True, totUsuario)]
   TUsuario = class(TEntityCommon)
   strict private
      FTipoColaborador: ShortInt;
      FRemuneracao: Currency;
      FTipoUsuario: ShortInt;
      FPassWord: UnicodeString;
      FNome: UnicodeString;
      FUserName: UnicodeString;
      FDataFimContrato: TDate;
      FIdImediato: Int64;
      procedure SetDataFimContrato(const Value: TDate);
      procedure SetIdImediato(const Value: Int64);
      procedure SetNome(const Value: UnicodeString);
      procedure SetPassWord(const Value: UnicodeString);
      procedure SetRemuneracao(const Value: Currency);
      procedure SetTipoColaborador(const Value: ShortInt);
      procedure SetTipoUsuario(const Value: ShortInt);
      procedure SetUserName(const Value: UnicodeString);
   public
      [TField(SField_Nome, True)]
      [TFieldString(60)]
      property Nome: UnicodeString read FNome write SetNome;

      [TField(SField_UserName, True)]
      [TFieldString(20)]
      property UserName: UnicodeString read FUserName write SetUserName;

      [TField(SField_PassWord, True)]
      [TFieldString(20, True)]
      property PassWord: UnicodeString read FPassWord write SetPassWord;

      [TField(SField_Tipo_Usuario, True)]
      [TFieldShortInt(1, 3)]
      property TipoUsuario: ShortInt read FTipoUsuario write SetTipoUsuario;

      [TField(SField_Tipo_Colaborador, True)]
      [TFieldShortInt(1, 4)]
      property TipoColaborador: ShortInt read FTipoColaborador write SetTipoColaborador;

      [TField(SField_Id_Imediato)]
      [TFieldInt64]
      [TFieldForeignKey(SField_Id, STable_Usuario)]
      property IdImediato: Int64 read FIdImediato write SetIdImediato;

      [TField(SField_Remuneracao)]
      [TFieldCurrency(15, 2, 0)]
      property Remuneracao: Currency read FRemuneracao write SetRemuneracao;

      [TField(SField_Data_Fim_Contrato)]
      [TFieldDate]
      property DataFimContrato: TDate read FDataFimContrato write SetDataFimContrato;
   end;

implementation

{ TUsuario }

procedure TUsuario.SetDataFimContrato(const Value: TDate);
begin
   FDataFimContrato := Value;
end;

procedure TUsuario.SetIdImediato(const Value: Int64);
begin
   FIdImediato := Value;
end;

procedure TUsuario.SetNome(const Value: UnicodeString);
begin
   FNome := Value;
end;

procedure TUsuario.SetPassWord(const Value: UnicodeString);
begin
   FPassWord := Value;
end;

procedure TUsuario.SetRemuneracao(const Value: Currency);
begin
   FRemuneracao := Value;
end;

procedure TUsuario.SetTipoColaborador(const Value: ShortInt);
begin
   FTipoColaborador := Value;
end;

procedure TUsuario.SetTipoUsuario(const Value: ShortInt);
begin
   FTipoUsuario := Value;
end;

procedure TUsuario.SetUserName(const Value: UnicodeString);
begin
   FUserName := Value;
end;

initialization
   TRegisterClass.Register(TUsuario);
end.
