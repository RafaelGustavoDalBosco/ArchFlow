unit App.DataBase.Utils;

interface

uses App.System.Connection.Query, App.System.SQL.Pattern, System.SysUtils,
  App.System.ORM.Persistent;

type

   TRelationUtils = class
   public
      /// <summary>
      ///    Verifica se determinada tabela existe no banco de dados e schema
      /// </summary>
      /// <param name="ATableName">
      ///    Nome da tabela
      /// </param>
      /// <param name="ASchema">
      ///   Nome do Schema
      /// </param>
      class function Table_InSchemaDB(const ATableName: UnicodeString; const ASchema: UnicodeString = 'public'): Boolean; static;
   end;

var
   RelationUtils: TRelationUtils;

implementation

{ TRelationUtils }

uses App.Common.Utils;

class function TRelationUtils.Table_InSchemaDB(const ATableName, ASchema: UnicodeString): Boolean;
var
   LQuery: TQuery;
begin
   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(AppSQLPatternDB.TableOnDataBase(ATableName, ASchema));

      Result := LQuery.GetData;

      if (not Result) then
         LogUtils.Write('Tabela não existe no banco de dados', 'Tabela: ' + ATableName + ' Schema: ' + ASchema);
   finally
      FreeAndNil(LQuery);
   end;
end;


end.
