unit App.System.SQL.Pattern;

interface

uses
   System.SysUtils;

type

   TSystemSQLPatternDB = class
   public
      /// <summary>
      ///    SQL que cria um determinado Index em uma tabela
      /// </summary>
      class function CreateIndex(const ATableName, AFieldName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que cria uma determinada sequ�ncia/generator em uma tabela
      /// </summary>
      class function CreateSequence(const ASequenceName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que cria uma FK em uma tabela
      /// </summary>
      class function CreateForeignKey(const ATableName, AFieldName, ARefTable, ARefField: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que cria uma PK em uma tabela
      /// </summary>
      class function CreatePrimaryKey(const ATableName, AFieldName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que cria um determinado Field em uma tabela
      /// </summary>
      class function CreateField(const ATableName, AFieldName, ATypeText: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que cria um banco de dados
      /// </summary>
      class function CreateDataBase(const ADataBaseName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que dropa um campo no banco de dados
      /// </summary>
      class function DropField(const ATableName, AFieldName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que dropa uma FK de uma tabela
      /// </summary>
      class function DropForeignKey(const ATableName, AForeignKeyName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que dropa um Index de uma tabela
      /// </summary>
      class function DropIndex(const AIndexName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que dropa uma Sequence
      /// </summary>
      class function DropSequence(const ASequenceName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que seta a flag NULL
      /// </summary>
      class function UpdateNullFlagField(const AFieldName, ATableName: UnicodeString; const AValue: Boolean): UnicodeString; static;

      /// <summary>
      ///    SQL que altera o tamanho de um campo
      /// </summary>
      class function UpdateLengthField(const AFieldName, ATableName: UnicodeString; const ALength: Integer): UnicodeString; static;

      /// <summary>
      ///    SQL que altera os decimais de um campo
      /// </summary>
      class function UpdateDecimalsField(const AFieldName, ATableName: UnicodeString; const ALength, ADecimals: Integer): UnicodeString; static;

      /// <summary>
      ///    SQL que obt�m todos os FIELDS de uma tabela
      /// </summary>
      class function GetFieldsFromTable(const ATableName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que obt�m a contagem de FIELDS em uma tabela
      /// </summary>
      class function GetFieldsCountFromTable(const ATableName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que obt�m todos os INDEXS de uma tabela
      /// </summary>
      class function GetIndexsFromTable(const ATableName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que obt�m todas as FKs de uma tabela
      /// </summary>
      class function GetForeignKeysFromTable(const ATableName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que obt�m o valor atual de uma SEQUENCE
      /// </summary>
      class function GetCurrentValueSequence(const ASequenceName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que obt�m o pr�ximo valor de uma SEQUENCE
      /// </summary>
      class function GetNextValueSequence(const ASequenceName: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que verifica se determinada tabela existe no banco de dados
      /// </summary>
      class function TableOnDataBase(const ATableName, ASchema: UnicodeString): UnicodeString; static;

      /// <summary>
      ///    SQL que verifica se um banco de dados existe no PostGres
      /// </summary>
      class function DataBaseOnSchemaPostGres: UnicodeString; static;
   end;

var
   AppSQLPatternDB: TSystemSQLPatternDB;

implementation

{ TSystemSQLPatternDB }

uses App.DataBase.Consts;

class function TSystemSQLPatternDB.CreateDataBase(const ADataBaseName: UnicodeString): UnicodeString;
begin
   Result := Format('CREATE DATABASE %s WITH OWNER = %s' + sLineBreak +
                    '  ENCODING = ' + QuotedStr('UTF8') + sLineBreak +
                    '  TABLESPACE = pg_default ' + sLineBreak +
                    '  LC_COLLATE = ' + QuotedStr('pt_BR.UTF-8') + sLineBreak +
                    '  LC_CTYPE = ' + QuotedStr('pt_BR.UTF-8') + sLineBreak +
                    '  TEMPLATE = template0' + sLineBreak +
                    '  CONNECTION LIMIT -1', [ADataBaseName, 'postgres']);
end;

class function TSystemSQLPatternDB.CreateField(const ATableName, AFieldName, ATypeText: UnicodeString): UnicodeString;
begin
   Result := Format('ALTER TABLE public.%s ADD COLUMN %s %s %s %s', [ATableName, AFieldName, ATypeText, '', '']);
end;

class function TSystemSQLPatternDB.CreateForeignKey(const ATableName, AFieldName, ARefTable, ARefField: UnicodeString): UnicodeString;
begin
   Result := 'ALTER TABLE ' + ATableName + ' ADD CONSTRAINT FK_' + ATableName + '_' + AFieldName + ' FOREIGN KEY (' + AFieldName + ')' + sLineBreak +
             'REFERENCES ' + ARefTable + '(' + ARefField + ') ON DELETE CASCADE';
end;

class function TSystemSQLPatternDB.CreateIndex(const ATableName, AFieldName: UnicodeString): UnicodeString;
begin
   Result := 'CREATE INDEX idx_' + AFieldName + '_' + ATableName + ' ON ' + ATableName + '(' + AFieldName + ')';
end;

class function TSystemSQLPatternDB.CreatePrimaryKey(const ATableName, AFieldName: UnicodeString): UnicodeString;
begin
  Result := Format('ALTER TABLE %s ADD CONSTRAINT PK_%s PRIMARY KEY (%s)', [ATableName, ATableName, AFieldName]);
end;

class function TSystemSQLPatternDB.CreateSequence(const ASequenceName: UnicodeString): UnicodeString;
begin
  Result := Format('CREATE SEQUENCE %s', [LowerCase(ASequenceName)]);
end;

class function TSystemSQLPatternDB.DataBaseOnSchemaPostGres: UnicodeString;
begin
   Result := 'SELECT PD.DATNAME, PU.USENAME' + sLineBreak +
             '  FROM PG_DATABASE PD, PG_USER PU' + sLineBreak +
             'WHERE PU.USESYSID = PD.DATDBA' + sLineBreak;
//             '  AND PU.USENAME = ' + QuotedStr(cPGUserName) + sLineBreak +
//             '  AND PD.DATNAME = ' + QuotedStr(gvSettingsFile.Connection.DataBaseName) + ';';
end;

class function TSystemSQLPatternDB.DropField(const ATableName, AFieldName: UnicodeString): UnicodeString;
begin
   Result := Format('ALTER TABLE public.%s DROP COLUMN %s', [ATableName, AFieldName]);
end;

class function TSystemSQLPatternDB.DropForeignKey(const ATableName, AForeignKeyName: UnicodeString): UnicodeString;
begin
   Result := Format('ALTER TABLE public.%s DROP CONSTRAINT %s', [ATableName, AForeignKeyName]);
end;

class function TSystemSQLPatternDB.DropIndex(const AIndexName: UnicodeString): UnicodeString;
begin
   Result := Format('DROP INDEX %s', [AIndexName]);
end;

class function TSystemSQLPatternDB.DropSequence(const ASequenceName: UnicodeString): UnicodeString;
begin
   Result := Format('DROP SEQUENCE %s', [ASequenceName]);
end;

class function TSystemSQLPatternDB.GetCurrentValueSequence(const ASequenceName: UnicodeString): UnicodeString;
begin
   Result := Format('SELECT last_value FROM %s where is_called = True', [ASequenceName]);
end;

class function TSystemSQLPatternDB.GetFieldsCountFromTable(const ATableName: UnicodeString): UnicodeString;
begin
   Result := Format('SELECT count (*) FROM information_schema.columns WHERE table_schema = ' + QuotedStr('public') + ' AND table_name = ' +  QuotedStr('%s'), [ATableName]);
end;

class function TSystemSQLPatternDB.GetFieldsFromTable(const ATableName: UnicodeString): UnicodeString;
begin
   Result := Format('SELECT column_name as field_name, is_nullable as is_null, data_type as field_type, character_maximum_length as field_length, numeric_precision, numeric_scale as scale FROM' + sLineBreak +
                   'information_schema.columns WHERE table_schema = ' + QuotedStr('public') + ' AND table_name = ' + QuotedStr('%s'), [ATableName]);
end;

class function TSystemSQLPatternDB.GetForeignKeysFromTable(const ATableName: UnicodeString): UnicodeString;
begin
   Result := Format('SELECT a.table_name, b.column_name as field_name, c.table_name AS reference_table, c.column_name AS fk_field' + sLineBreak +
                    'FROM information_schema.table_constraints AS A JOIN information_schema.key_column_usage AS B ON A.constraint_name = B.constraint_name' + sLineBreak +
                    'JOIN information_schema.constraint_column_usage AS C ON C.constraint_name = A.constraint_name' + sLineBreak +
                    'WHERE constraint_type = ''FOREIGN KEY'' and A.table_name = ' + QuotedStr('%s'), [ATableName]);
end;

class function TSystemSQLPatternDB.GetIndexsFromTable(const ATableName: UnicodeString): UnicodeString;
begin
   Result := 'SELECT * FROM pg_indexes WHERE tablename = ' +  QuotedStr(ATableName) + 'and indexname like ''%idx%''';
end;

class function TSystemSQLPatternDB.GetNextValueSequence(const ASequenceName: UnicodeString): UnicodeString;
begin
   Result := Format('SELECT nextval (''%s'')', [ASequenceName]);
end;

class function TSystemSQLPatternDB.TableOnDataBase(const ATableName, ASchema: UnicodeString): UnicodeString;
begin
   Result := Format('SELECT tablename FROM PG_TABLES WHERE SCHEMANAME = ' + QuotedStr(ASchema) + ' AND TABLENAME = ''%s''', [ATableName]);
end;

class function TSystemSQLPatternDB.UpdateDecimalsField(const AFieldName, ATableName: UnicodeString; const ALength, ADecimals: Integer): UnicodeString;
begin
   Result := Format('ALTER TABLE %s ALTER COLUMN %s TYPE NUMERIC (%d, %d)', [ATableName, AFieldName, ALength, ADecimals]);
end;

class function TSystemSQLPatternDB.UpdateLengthField(const AFieldName, ATableName: UnicodeString; const ALength: Integer): UnicodeString;
begin
   Result := Format('ALTER TABLE %s ALTER COLUMN %s TYPE varchar(%d)', [ATableName, AFieldNAme, ALength]);
end;

class function TSystemSQLPatternDB.UpdateNullFlagField(const AFieldName, ATableName: UnicodeString; const AValue: Boolean): UnicodeString;
var
   LCommand: UnicodeString;
begin
   if (AValue) then
      LCommand := ' SET NOT NULL'
   else
      LCommand := ' DROP NOT NULL';

   Result := Format('ALTER TABLE %s ALTER COLUMN %s' + LCommand, [ATableName, AFieldName]);
end;

end.
