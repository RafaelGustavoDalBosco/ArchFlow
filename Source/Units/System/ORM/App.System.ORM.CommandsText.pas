unit App.System.ORM.CommandsText;

interface

uses
   System.SysUtils, System.Generics.Collections, App.DataBase.Objects, System.Classes, App.System.SQL.Pattern;

type

   TORMCommandsText = class
   protected
      /// <summary>
      ///    Obt�m os parametros de WHERE
      /// </summary>
      function GetParamsWhere(const ADataBaseRecord: TDataBaseRecord): UnicodeString;

      /// <summary>
      ///    Obt�m os parametros de WHERE com FORMAT
      /// </summary>
      function GetParamsWhereWithFormat(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
   public
      /// <summary>
      ///    Gera a SQL de criação de tabelas
      /// </summary>
      function CreateRelationDataBase(const ADataBaseTable: TDataBaseTable): UnicodeString;

      /// <summary>
      ///    Gera a SQL de criação de FKs
      /// </summary>
      function CreateForeignKeyDataBase(const ADataBaseTable: TDataBaseTable): UnicodeString;

      /// <summary>
      ///    Gera a SQL de criaãoo de INDEX
      /// </summary>
      function CreateIndexDataBase(const ADataBaseTable: TDataBaseTable): UnicodeString;

      /// <summary>
      ///    Gera a SQL de inserção de um novo registro
      /// </summary>
      function InsertRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;

      /// <summary>
      ///    Gera a SQL de update de um registro
      /// </summary>
      function UpdateRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;

      /// <summary>
      ///    Gera a SQL de delete de um registro
      /// </summary>
      function DeleteRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;

      /// <summary>
      ///    Gera a SQL de select de um registro
      /// </summary>
      function SelectRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;

      /// <summary>
      ///    Gera a SQL de select [LIST] <PK off>
      /// </summary>
      function ListRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;

      /// <summary>
      ///    Gera a SQL de select [LIST | ROOT]
      /// </summary>
      function ListRecordRoot(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
   end;

implementation


{ TORMCommandsText }

function TORMCommandsText.CreateForeignKeyDataBase(const ADataBaseTable: TDataBaseTable): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LLoop: Integer;
   LForeignKey: TDataBaseForeignKey;
begin
   if (ADataBaseTable = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      for LLoop := 0 to ADataBaseTable.ForeignKeys.Count - 1 do
      begin
         LForeignKey := TDataBaseForeignKey(ADataBaseTable.ForeignKeys.Items[LLoop]);

         LStringBuilder.Append(
                         AppSQLPatternDB.CreateForeignKey
                                    (LForeignKey.TableName,
                                     LForeignKey.FieldName,
                                     LForeignKey.TableNameReference,
                                     LForeignKey.FieldNameReference
                                    ) + ';').AppendLine;
      end;

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.CreateIndexDataBase(const ADataBaseTable: TDataBaseTable): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LLoop: Integer;
   LIndex: TDataBaseIndex;
begin
   if (ADataBaseTable = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      for LLoop := 0 to ADataBaseTable.Indexs.Count - 1 do
      begin
         LIndex := TDataBaseIndex(ADataBaseTable.Indexs.Items[LLoop]);

         LStringBuilder.Append(AppSQLPatternDB.CreateIndex(LIndex.TableName, LIndex.FieldName)+ ';').AppendLine;
      end;

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.CreateRelationDataBase(const ADataBaseTable: TDataBaseTable): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LLoop: Integer;
   LField: TDataBaseField;
begin
   if (ADataBaseTable = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      LStringBuilder.Append('CREATE TABLE ' + ADataBaseTable.Name + '(').AppendLine;

      for LLoop := 0 to ADataBaseTable.Fields.Count - 1 do
      begin
         LField := TDataBaseField(ADataBaseTable.Fields.Items[LLoop]);

         if (LField.PrimaryKey) then
            LStringBuilder.Append(LField.Name + ' bigserial primary key').AppendLine
         else
            LStringBuilder.Append(LField.Name + ' ' + LField.TypeText).AppendLine;

         if (LField.Length > 0) then
         begin
            if (LField.Decimals > 0) then
               LStringBuilder.Append(' (' + LField.Length.ToString + ', ' + LField.Decimals.ToString + ')').AppendLine
            else
               LStringBuilder.Append(' (' + LField.Length.ToString + ')').AppendLine;
         end;

         if (LField.NotNull) then
            LStringBuilder.Append(' NOT NULL ');

         if (LLoop <> ADataBaseTable.Fields.Count -1) then
            LStringBuilder.Append(', ').AppendLine
         else
            LStringBuilder.Append(');').AppendLine;
      end;

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.DeleteRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
begin
   if (ADataBaseRecord = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      LStringBuilder.Append('DELETE FROM ' + ADataBaseRecord.TableName + ' WHERE ').AppendLine;

      LStringBuilder.Append(GetParamsWhere(ADataBaseRecord));

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.GetParamsWhere(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LRecordItem: TDataBaseRecordItem;
   LLoop: Integer;
begin
   LStringBuilder := TStringBuilder.Create;
   try
      for LLoop := 0 to ADataBaseRecord.Records.Count - 1 do
      begin
         LRecordItem := TDataBaseRecordItem(ADataBaseRecord.Records.Items[LLoop]);

         if (LRecordItem.PrimaryKey) or (LRecordItem.IsParam) then
         begin
            if LStringBuilder.ToString.Contains(' = :') then
               LStringBuilder.Append(' AND ');

            LStringBuilder.Append(LRecordItem.Name + ' = :' + LRecordItem.Name).AppendLine;
         end;
      end;

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.GetParamsWhereWithFormat(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LRecordItem: TDataBaseRecordItem;
   LLoop: Integer;
begin
   LStringBuilder := TStringBuilder.Create;
   try
      for LLoop := 0 to ADataBaseRecord.Records.Count - 1 do
      begin
         LRecordItem := TDataBaseRecordItem(ADataBaseRecord.Records.Items[LLoop]);

         if (LRecordItem.IsParam) then
         begin
            if LStringBuilder.ToString.Contains(' = :') then
               LStringBuilder.Append(' AND ');

            LStringBuilder.Append(LRecordItem.Name + ' = %s').AppendLine;
         end;
      end;

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.InsertRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LLoop: Integer;
   LRecordItem: TDataBaseRecordItem;
   LListFields, LListParams: TList<String>;
begin
   if (ADataBaseRecord = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   LListFields := TList<String>.Create;
   LListParams := TList<String>.Create;
   try
      LStringBuilder.Append('INSERT INTO ' + ADataBaseRecord.TableName + '(');

      for LLoop := 0 to ADataBaseRecord.Records.Count - 1 do
      begin
         LRecordItem := TDataBaseRecordItem(ADataBaseRecord.Records.Items[LLoop]);

         if (LRecordItem.IsObject) or (LRecordItem.IsList) then
            Continue;

         if (not LRecordItem.Name.IsEmpty) then
            LListFields.Add(LRecordItem.Name + ',  ');

         if LRecordItem.PrimaryKey and (LRecordItem.Value.AsInt64 <= 0) then
            LListParams.Add('default, ')
         else
         if (not LRecordItem.Name.IsEmpty) then
            LListParams.Add(':' + LRecordItem.Name + ', ');
      end;

      if LListFields.Last.Contains(', ') then
         LListFields.Items[LListFields.Count - 1] := LListFields.Last.Replace(', ', ')');

      if LListParams.Last.Contains(',') and (not LListParams.Last.Contains('),')) then
         LListParams.Items[LListParams.Count -1] := LListParams.Last.Replace(',', ')')
      else
      if LListParams.Last.Contains('),') then
         LListParams.Items[LListParams.Count - 1] := LListParams.Last.Replace('),', ')');

      for LLoop := 0 to LListFields.Count - 1 do
         LStringBuilder.Append(LListFields[LLoop]);

      LStringBuilder.Append(' VALUES (').AppendLine;

      for LLoop := 0 to LListParams.Count - 1 do
         LStringBuilder.Append(LListParams[LLoop]);

      LStringBuilder.Append(' RETURNING id;');

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
      FreeAndNil(LListFields);
      FreeAndNil(LListParams);
   end;
end;

function TORMCommandsText.ListRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LLoop: Integer;
   LRecordItem: TDataBaseRecordItem;
begin
   if (ADataBaseRecord = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      LStringBuilder.Append('SELECT * FROM ' + ADataBaseRecord.TableName).AppendLine;

      if (ADataBaseRecord.Records.Count = 0) then
         Exit(LStringBuilder.ToString);

      for LLoop := 0 to ADataBaseRecord.Records.Count - 1 do
      begin
         LRecordItem := TDataBaseRecordItem(ADataBaseRecord.Records.Items[LLoop]);

         if (LRecordItem.IsParam) then
         begin
            if (not LStringBuilder.ToString.Contains(' WHERE ')) then
               LStringBuilder.Append(' WHERE ').AppendLine
            else
               LStringBuilder.Append(' AND ').AppendLine;

            LStringBuilder.Append(LRecordItem.Name + ' = :' + LRecordItem.Name);
         end;
      end;

      Result := LStringBuilder.ToString + ' ORDER BY id DESC';
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.ListRecordRoot(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
begin
   if (ADataBaseRecord = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      LStringBuilder.Append('SELECT * FROM ' + ADataBaseRecord.TableName + ' WHERE ').AppendLine;

      LStringBuilder.Append(GetParamsWhereWithFormat(ADataBaseRecord));

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.SelectRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
begin
   if (ADataBaseRecord = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   try
      LStringBuilder.Append('SELECT * FROM ' + ADataBaseRecord.TableName + ' WHERE ').AppendLine;

      LStringBuilder.Append(GetParamsWhere(ADataBaseRecord));

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
   end;
end;

function TORMCommandsText.UpdateRecord(const ADataBaseRecord: TDataBaseRecord): UnicodeString;
var
   LStringBuilder: TStringBuilder;
   LLoop: Integer;
   LRecordItem: TDataBaseRecordItem;
   LListFields, LListParams: TList<String>;
   LMatchSpace: UnicodeString;
begin
   if (ADataBaseRecord = nil) then
      Exit(EmptyStr);

   LStringBuilder := TStringBuilder.Create;
   LListFields := TList<String>.Create;
   LListParams := TList<String>.Create;
   try
      LStringBuilder.Append('UPDATE ' + ADataBaseRecord.TableName + ' SET ');

      for LLoop := 0 to ADataBaseRecord.Records.Count - 1 do
      begin
         LRecordItem := TDataBaseRecordItem(ADataBaseRecord.Records.Items[LLoop]);

          if (LRecordItem.Name.IsEmpty) then
            Continue;

         if (LRecordItem.PrimaryKey) or (LRecordItem.IsParam) then
            LListParams.Add(LRecordItem.Name)
         else
            LListFields.Add(LRecordItem.Name);
      end;

      for LLoop := 0 to LListFields.Count - 1 do
      begin
         if (LLoop <> LListFields.Count - 1) then
            LMatchSpace := LListFields[LLoop] + ', '
         else
            LMatchSpace := LListFields[LLoop];

         LStringBuilder.Append(LListFields[LLoop] + ' = :' + LMatchSpace).AppendLine;
      end;

      LStringBuilder.Append(' WHERE ').AppendLine;

      for LLoop := 0 to LListParams.Count - 1 do
      begin
         if (LLoop <> 0) then
            LStringBuilder.Append(' AND ');

         LStringBuilder.Append(LListParams[LLoop] +  ' = :' + LListParams[LLoop]).AppendLine;
      end;

      Result := LStringBuilder.ToString;
   finally
      FreeAndNil(LStringBuilder);
      FreeAndNil(LListFields);
      FreeAndNil(LListParams);
   end;
end;

end.

