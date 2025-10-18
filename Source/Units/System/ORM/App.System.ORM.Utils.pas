unit App.System.ORM.Utils;

interface

uses
   System.SysUtils, App.System.ORM.Persistent, App.System.List;

type

   TORMUtils = class
   public
      /// <summary>
      ///    Insere um novo registro no banco de dados do objeto estipulado
      /// </summary>
      /// <param name="AObject">
      ///    Objeto a ser persistido
      /// </param>
      class function New_Record(const AObject: TObject): Boolean; static;

      /// <summary>
      ///    Edita um registro no banco de dados do objeto estipulado
      /// </summary>
      /// <param name="AObject">
      ///    Objeto a ser persistido
      /// </param>
      class function Edit_Record(const AObject: TObject): Boolean; static;

      /// <summary>
      ///    Exclui o registro do banco de dados
      /// </summary>
      /// <param name="AObject">
      ///    Objeto a ser persistido
      /// </param>
      class function Delete_Record(const AObject: TObject): Boolean; static;

      /// <summary>
      ///    Seleciona um registro no banco de dados através do seu ID
      /// </summary>
      /// <param name="AObject">
      ///    Objeto a ser persistido
      /// </param>
      class function Select_Record(const AObject: TObject): Boolean; static;

      /// <summary>
      ///    Carrega uma lista de registros baseado em um objeto e/ou SQL
      /// </summary>
      /// <param name="AObject">
      ///    Objeto que será usado para gerar a lista, caso seja um EntityCommon, então, será obtido
      ///   todos os registros da tabela, filtrando pelo CustomAttribute [TFieldParam]
      /// </param>
      /// <param name="ASQL">
      ///    Parâmetro não obrigatório. Caso seja definido uma SQL padrão para carregamento da lista.
      /// </param>
      class function List_Record(const AObject: TObject; const ASQL: UnicodeString = ''): TSystemList; static;
   end;

var
   ORMUtils: TORMUtils;

implementation

{ TORMUtils }

class function TORMUtils.Delete_Record(const AObject: TObject): Boolean;
var
   LPersistent: TORMPersistent;
begin
   LPersistent := TORMPersistent.Create(AObject);
   try
      Result := LPersistent.Delete;
   finally
      FreeAndNil(LPersistent);
   end;
end;

class function TORMUtils.Edit_Record(const AObject: TObject): Boolean;
var
   LPersistent: TORMPersistent;
begin
   LPersistent := TORMPersistent.Create(AObject);
   try
      Result := LPersistent.Update;
   finally
      FreeAndNil(LPersistent);
   end;
end;

class function TORMUtils.List_Record(const AObject: TObject; const ASQL: UnicodeString): TSystemList;
var
   LPersistent: TORMPersistent;
begin
   LPersistent := TORMPersistent.Create(AObject);
   try
      Result := LPersistent.List(ASQL);
   finally
      FreeAndNil(LPersistent);
   end;
end;

class function TORMUtils.New_Record(const AObject: TObject): Boolean;
var
   LPersistent: TORMPersistent;
begin
   LPersistent := TORMPersistent.Create(AObject);
   try
      Result := LPersistent.Insert;
   finally
      FreeAndNil(LPersistent);
   end;
end;

class function TORMUtils.Select_Record(const AObject: TObject): Boolean;
var
   LPersistent: TORMPersistent;
begin
   LPersistent := TORMPersistent.Create(AObject);
   try
      Result := LPersistent.Select;
   finally
      FreeAndNil(LPersistent);
   end;
end;

end.
