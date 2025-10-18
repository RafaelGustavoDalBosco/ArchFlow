unit App.System.Engine.DataBase;

interface

uses

{$REGION '| USES |'}
   System.SysUtils,
   App.Common.Types,
   App.Common.Utils,
   App.System.Connection.Query,
   App.Objects.Entity.Empresa,
   App.Objects.Entity.Usuario,
   App.System.Connection.Transaction,
   App.System.ORM.CommandsText,
   App.DataBase.Objects,
   App.System.List,
   App.System.Types,
   App.System.Records,
   App.System.SQL.Pattern, App.System.ORM.Extract,
  App.Objects.Entity.ApplicationData, App.System.ORM.Utils;
{$ENDREGION}

type

   TSystemEngineDataBaseCommon = class
   private
      FCommandsText: TORMCommandsText;
      FQuery: TQuery;
      FTransaction: TConnectionTransaction;
      procedure SetCommandsText(const Value: TORMCommandsText);
      procedure SetQuery(const Value: TQuery);
      procedure SetTransaction(const Value: TConnectionTransaction);

      function GetQuery: TQuery;
      function GetTransaction: TConnectionTransaction;
      function GetCommandsText: TORMCommandsText;
   private
      /// <summary>
      ///    Execute<SQL>
      /// </summary>
      /// <param name="ASQL">
      ///    SQL a ser executada
      /// </param>
      procedure ExecuteSQL(const ASQL: UnicodeString);
   public
      /// <summary>
      ///    Execute
      /// </summary>
      procedure Execute; virtual; abstract;

      property Query: TQuery read GetQuery write SetQuery;
      property Transaction: TConnectionTransaction read GetTransaction write SetTransaction;
      property CommandsText: TORMCommandsText read getCommandsText write SetCommandsText;

      destructor Destroy; override;
   end;

   TSystemEngineDataBaseCreate = class(TSystemEngineDataBaseCommon)
   private
      /// <summary>
      ///    Verifica se existe uma empresa no banco de dados, caso não tenha, cria uma
      /// </summary>
      procedure New_Empresa;

      /// <summary>
      ///    Verifica se existe o usuário Admin no banco de dados, caso não tenha, adiciona
      /// </summary>
      procedure New_Usuario;

      /// <summary>
      ///    Insere a versão no banco de dados
      /// </summary>
      procedure New_ApplicationData;
   strict protected
      /// <summary>
      ///    Create.Relations
      /// </summary>
      procedure Create_Relations;

      /// <summary>
      ///    Create.FKs
      /// </summary>
      procedure Create_ForeignKeys;

      /// <summary>
      ///    Create.Functions
      /// </summary>
      procedure Create_Functions;

      /// <summary>
      ///    Create.Triggers
      /// </summary>
      procedure Create_Triggers;

      /// <summary>
      ///    Create.Fields
      /// </summary>
      procedure Create_Fields(const ADataBaseTable: TDataBaseTable);

      /// <summary>
      ///    Create.FK
      /// </summary>
      procedure Create_ForeignKeysFrom_Table(const ADataBaseTable: TDataBaseTable);

      /// <summary>
      ///    Create.Index
      /// </summary>
      procedure Create_Indexes(const ADataBaseTable: TDataBaseTable);
   public
      /// <summary>
      ///    DataBase.Create
      /// </summary>
      procedure Execute; override;
   end;

   TSystemEngineDataBaseUpdate = class(TSystemEngineDataBaseCommon)
   strict private
      /// <summary>
      ///    Execute<SQL>
      /// </summary>
      procedure ExecuteSQL(const ASQL: UnicodeString);

      /// <summary>
      ///    Get.Fields<DB, Table>
      /// </summary>
      function GetFieldsFrom_DataBase(const ATableName: UnicodeString): TSystemList;

      /// <summary>
      ///    Get.FK<DB, Table>
      /// </summary>
      function GetForeignKeysFrom_DataBase(const ATableName: UnicodeString): TSystemList;

      /// <summary>
      ///    Get.Index<DB, Table>
      /// </summary>
      function GetIndexesFrom_DataBase(const ATableName: UnicodeString): TSystemList;

      /// <summary>
      ///    Try.Get.FK<Field>
      /// </summary>
      function TryGetForeignKeyFrom_Field(const AList: TSystemList; const AFieldName: UnicodeString): TDataBaseForeignKey;
   strict protected
      /// <summary>
      ///    Atualiza o campo VERSION da tabela TAPPLICATIONDATA
      /// </summary>
      procedure Update_Application_Data;

      /// <summary>
      ///    Update.Relations
      /// </summary>
      procedure Update_Relations;

      /// <summary>
      ///    Update.Fields
      /// </summary>
      procedure Update_Fields(const ADataBaseTable: TDataBaseTable);

      /// <summary>
      ///    Update.FKs
      /// </summary>
      procedure Update_ForeignKeys(const ADataBaseTable: TDataBaseTable);

      /// <summary>
      ///    Update.Indexs
      /// </summary>
      procedure Update_Indexs(const ADataBaseTable: TDataBaseTable);

      /// <summary>
      ///    Search.Delete.Extra<Field>
      /// </summary>
      procedure SearchAndDeleteExtra_Field(const ADataBaseTable: TDataBaseTable; const AListObject, AListTable: TSystemList);

      /// <summary>
      ///    Search.Delete.Extra<FK>
      /// </summary>
      procedure SearchAndDeleteExtra_ForeignKey(const ADataBaseTable: TDataBaseTable; const AListObject, AListTable: TSystemList);

      /// <summary>
      ///    Search.Delete.Extra<Index>
      /// </summary>
      procedure SearchAndDeleteExtra_Index(const ADataBaseTable: TDataBaseTable; const AListObject, AListTable: TSystemList);

      /// <summary>
      ///    Update.NullFlag
      /// </summary>
      procedure UpdateNullFlag_Field(const AFlag: Boolean; const ATableName, AFieldName: UnicodeString);

      /// <summary>
      ///    Update.Length
      /// </summary>
      procedure UpdateLength_Field(const AFieldDataBase: TDataBaseField; const ATableName: UnicodeString);

      /// <summary>
      ///    Update.Decimals
      /// </summary>
      procedure UpdateDecimals_Field(const AFieldDataBase: TDataBaseField; const ATableName: UnicodeString);

      /// <summary>
      ///    Create.Field
      /// </summary>
      procedure Create_Field(const ATableName: UnicodeString; const ADataBaseField: TDataBaseField);

      /// <summary>
      ///    Drop.Field
      /// </summary>
      procedure Drop_Field(const ATableName, AFieldName: UnicodeString);

      /// <summary>
      ///    Create.Table
      /// </summary>
      procedure Create_Relation(const ADataBaseTable: TDataBaseTable);

      /// <summary>
      ///    Create.FK
      /// </summary>
      procedure Create_ForeignKey(const AForeignKey: TDataBaseForeignKey);

      /// <summary>
      ///    Drop.FK
      /// </summary>
      procedure Drop_ForeignKey(const AForeignKey: TDataBaseForeignKey);

      /// <summary>
      ///    Create.Index
      /// </summary>
      procedure Create_Index(const AIndex: TDataBaseIndex);

      /// <summary>
      ///    Drop.Index
      /// </summary>
      procedure Drop_Index(const AIndex: TDataBaseIndex);
   public
      /// <summary>
      ///    DataBase.Update
      /// </summary>
      procedure Execute; override;
   end;

   TSystemEngineDataBase = class
   strict private
      FVersionDataBase: UnicodeString;
      FVersionApplication: UnicodeString;
      FTypeOperation: TTypeOperationDataBase;
      procedure SetTypeOperation(const Value: TTypeOperationDataBase);
      procedure SetVersionApplication(const Value: UnicodeString);
      procedure SetVersionDataBase(const Value: UnicodeString);

      function GetTypeOperation: TTypeOperationDataBase;
      function GetVersionDataBase: UnicodeString;
   protected
      /// <summary>
      ///    Create.Structure
      /// </summary>
      procedure Create_Structure;

      /// <summary>
      ///    Update.Structure
      /// </summary>
      procedure Update_Structure;

      /// <summary>
      ///    Wrong.Structure
      /// </summary>
      procedure Wrong_Structure;
   private
      property VersionDataBase: UnicodeString read FVersionDataBase write SetVersionDataBase;
      property VersionApplication: UnicodeString read FVersionApplication write SetVersionApplication;
      property TypeOperation: TTypeOperationDataBase read GetTypeOperation write SetTypeOperation;
   public
      /// <summary>
      ///    Execute
      /// </summary>
      procedure Execute;
   end;

implementation

{ TSystemEngineDataBase }

uses App.Objects.Entity.Default, App.DataBase.Utils, App.DataBase.Consts;

procedure TSystemEngineDataBase.Create_Structure;
var
   LCreateDataBase: TSystemEngineDataBaseCreate;
begin
   LCreateDataBase := TSystemEngineDataBaseCreate.Create;
   try
      LCreateDataBase.Execute;
   finally
      FreeAndNil(LCreateDataBase);
   end;
end;

procedure TSystemEngineDataBase.Execute;
begin
   case TypeOperation of
      todNew: Create_Structure;
      todUpdate: Update_Structure;
      todWrongVersion: Wrong_Structure;
   end;
end;

function TSystemEngineDataBase.GetTypeOperation: TTypeOperationDataBase;
var
   LVersionDB, LVersionApp: TVersionInformation;
   LValueDB, LValueApp: Int64;
begin
   if (not RelationUtils.Table_InSchemaDB(STable_Application_Data)) then
   begin
      FTypeOperation := todNew;
      Exit(FTypeOperation);
   end;

   VersionDataBase := GetVersionDataBase;
   VersionApplication := VersionUtils.GetApplication_Version;

   // -> Decode.DBVersion
   VersionUtils.Decode(LVersionDB.Major, LVersionDB.Minor, LVersionDB.Release, LVersionDB.Build, VersionDataBase);

   // -> Decode.AppVersion
   VersionUtils.Decode(LVersionApp.Major, LVersionApp.Minor, LVersionApp.Release, LVersionApp.Build, VersionApplication);

   LValueDB := LVersionDB.ToInt64;
   LValueApp := LVersionApp.ToInt64;

   if (LValueApp > LValueDB) then
      FTypeOperation := todUpdate
   else
   if (LValueApp < LValueDB) then
      FTypeOperation := todWrongVersion
   else
   if (LValueDB = 0) then
      FTypeOperation := todNew
   else
      FTypeOperation := todNone;

   Result := FTypeOperation;
end;

function TSystemEngineDataBase.GetVersionDataBase: UnicodeString;
var
   LApplicationData: TApplicationData;
begin
   LApplicationData := TApplicationData.Create;
   try
      LApplicationData.Id := 1;

      if ORMUtils.Select_Record(LApplicationData) then
         Result := LApplicationData.Version
      else
         Result := '0.0.0.0';
   finally
      FreeAndNil(LApplicationData);
   end;
end;

procedure TSystemEngineDataBase.SetTypeOperation(const Value: TTypeOperationDataBase);
begin
   FTypeOperation := Value;
end;

procedure TSystemEngineDataBase.SetVersionApplication(const Value: UnicodeString);
begin
   FVersionApplication := Value;
end;

procedure TSystemEngineDataBase.SetVersionDataBase(const Value: UnicodeString);
begin
   FVersionDataBase := Value;
end;

procedure TSystemEngineDataBase.Update_Structure;
var
   LUpdateDataBase: TSystemEngineDataBaseUpdate;
begin
   LUpdateDataBase := TSystemEngineDataBaseUpdate.Create;
   try
      LUpdateDataBase.Execute;
   finally
      FreeAndNil(LUpdateDataBase);
   end;
end;

procedure TSystemEngineDataBase.Wrong_Structure;
begin
   raise Exception.CreateFmt('A versão da aplicação %s está diferente da versão do banco de dados %s', [FVersionApplication, FVersionDataBase]);
end;

{ TSystemEngineDataBaseUpdate }

procedure TSystemEngineDataBaseUpdate.Create_Field(const ATableName: UnicodeString; const ADataBaseField: TDataBaseField);
begin
   ExecuteSQL(AppSQLPatternDB.CreateField(ATableName, ADataBaseField.Name, ADataBaseField.TypeText));
end;

procedure TSystemEngineDataBaseUpdate.Create_ForeignKey(const AForeignKey: TDataBaseForeignKey);
begin
   ExecuteSQL(AppSQLPatternDB.CreateForeignKey(AForeignKey.TableName,
                                               AForeignKey.FieldName,
                                               AForeignKey.TableNameReference,
                                               AForeignKey.FieldNameReference));
end;

procedure TSystemEngineDataBaseUpdate.Create_Index(const AIndex: TDataBaseIndex);
begin
   ExecuteSQL(AppSQLPatternDB.CreateIndex(AIndex.TableName, AIndex.FieldName));
end;

procedure TSystemEngineDataBaseUpdate.Create_Relation(const ADataBaseTable: TDataBaseTable);
begin
  if (RelationUtils.Table_InSchemaDB(ADataBaseTable.Name)) then
      Exit;

   ExecuteSQL(CommandsText.CreateRelationDataBase(ADataBaseTable));
end;

procedure TSystemEngineDataBaseUpdate.Drop_Field(const ATableName, AFieldName: UnicodeString);
begin
   ExecuteSQL(AppSQLPatternDB.DropField(ATableName, AFieldName));
end;

procedure TSystemEngineDataBaseUpdate.Drop_ForeignKey(const AForeignKey: TDataBaseForeignKey);
var
   LForeignKeyName: UnicodeString;
begin
   LForeignKeyName := 'fk_' + AForeignKey.TableName + '_' + AForeignKey.FieldName;
   ExecuteSQL(AppSQLPatternDB.DropForeignKey(AForeignKey.TableName, LForeignKeyName));
end;

procedure TSystemEngineDataBaseUpdate.Drop_Index(const AIndex: TDataBaseIndex);
begin
   ExecuteSQL(AppSQLPatternDB.DropIndex('idx_' + AIndex.FieldName + '_' + AIndex.TableName));
end;

procedure TSystemEngineDataBaseUpdate.Execute;
begin
   Transaction.Start;
   try
      Update_Relations;

      // -> Atualiza a versão no banco de dados
//      AppVersion.UpdateApplicationVersion;
   finally
      Transaction.Commit;
   end;
end;

procedure TSystemEngineDataBaseUpdate.ExecuteSQL(const ASQL: UnicodeString);
begin
   Query.AddSQL(ASQL);
   Query.ExecuteWithTransaction;
end;

function TSystemEngineDataBaseUpdate.GetFieldsFrom_DataBase(const ATableName: UnicodeString): TSystemList;
var
   LQuery: TQuery;
   LDataBaseField: TDataBaseField;
begin
   Result := TSystemList.Create;

   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(AppSQLPatternDB.GetFieldsFromTable(ATableName));

      if LQuery.GetData then
      begin
         repeat
            LDataBaseField := TDataBaseField.Create;
            LDataBaseField.Name := LQuery.FieldToString(SField_FieldName);
            LDataBaseField.TypeText := LQuery.FieldToString(SField_FieldType);
            LDataBaseField.Length := LQuery.FieldToInteger(SField_FieldLength);

            if (LDataBaseField.TypeText = 'numeric') then
               LDataBaseField.Length := LQuery.FieldToInteger(SField_Numeric_Precision);

            LDataBaseField.Decimals := LQuery.FieldToInteger(SField_Scale);
            LDataBaseField.PrimaryKey := LDataBaseField.Name.Equals(SField_Id);
            LDataBaseField.NotNull := (not LQuery.FieldToBool(SField_Is_Null));

            Result.Add(LDataBaseField);

            LQuery.Next;
         until LQuery.EndOfData;
      end;
   finally
      FreeAndNil(LQuery);
   end;
end;

function TSystemEngineDataBaseUpdate.GetForeignKeysFrom_DataBase(const ATableName: UnicodeString): TSystemList;
var
   LQuery: TQuery;
   LForeignKey: TDataBaseForeignKey;
begin
   Result := TSystemList.Create;

   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(AppSQLPatternDB.GetForeignKeysFromTable(ATableName));

      if LQuery.GetData then
      begin
         repeat
            LForeignKey := TDataBaseForeignKey.Create;
            LForeignKey.FieldName := LQuery.FieldToString(SField_FieldName);
            LForeignKey.TableName := ATableName;
            LForeignKey.FieldNameReference := LQuery.FieldToString(SField_FKField);
            LForeignKey.TableNameReference := LQuery.FieldToString(SField_Reference_Table);
            Result.Add(LForeignKey);

            LQuery.Next;
         until LQuery.EndOfData;
      end;
   finally
      FreeAndNil(LQuery);
   end;
end;

function TSystemEngineDataBaseUpdate.GetIndexesFrom_DataBase(const ATableName: UnicodeString): TSystemList;
var
   LQuery: TQuery;
   LDataBaseIndex: TDataBaseIndex;
begin
   Result := TSystemList.Create;

   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(AppSQLPatternDB.GetIndexsFromTable(ATableName));

      if LQuery.GetData then
      begin
         repeat
            LDataBaseIndex := TDataBaseIndex.Create;
            LDataBaseIndex.FieldName := StrUtils.GetContentBetweenChars(LQuery.FieldToString('indexdef'), '(', ')');
            LDataBaseIndex.TableName := ATableName;

            Result.Add(LDataBaseIndex);
            LQuery.Next;
         until (LQuery.EndOfData);
      end;
   finally
      FreeAndNil(LQuery);
   end;
end;

procedure TSystemEngineDataBaseUpdate.SearchAndDeleteExtra_Field(const ADataBaseTable: TDataBaseTable; const AListObject, AListTable: TSystemList);
var
   LLoopTable, LLoopObject: TObject;
   LFieldTable, LFieldObject: TDataBaseField;
   LFound: Boolean;
begin
   for LLoopTable in AListTable do
   begin
      LFieldTable := LLoopTable as TDataBaseField;
      LFound := False;

      for LLoopObject in AListObject do
      begin
         LFieldObject := LLoopObject as TDataBaseField;

         if LFieldObject.Name.Equals(LFieldTable.Name) then
         begin
            LFound := True;
            Break;
         end;
      end;

      if (not LFound) then
         Drop_Field(ADataBaseTable.Name, LFieldTable.Name);
   end;
end;

procedure TSystemEngineDataBaseUpdate.SearchAndDeleteExtra_ForeignKey(const ADataBaseTable: TDataBaseTable; const AListObject, AListTable: TSystemList);
var
   LLoopTable, LLoopObject: TObject;
   LFKTable, LFKObject: TDataBaseForeignKey;
   LFound: Boolean;
begin
   for LLoopTable in AListTable do
   begin
      LFKTable := LLoopTable as TDataBaseForeignKey;
      LFound := False;

      for LLoopObject in AListObject do
      begin
         LFKObject := LLoopObject as TDataBaseForeignKey;

         if LFKObject.FieldName.Equals(LFKTable.FieldName) and LFKObject.TableName.Equals(LFKTable.TableName) then
         begin
            LFound := True;
            Break;
         end;
      end;

      if (not LFound) then
         Drop_ForeignKey(LFKTable);
   end;
end;

procedure TSystemEngineDataBaseUpdate.SearchAndDeleteExtra_Index(const ADataBaseTable: TDataBaseTable; const AListObject, AListTable: TSystemList);
var
   LLoopTable, LLoopObject: TObject;
   LIndexTable, LIndexObject: TDataBaseIndex;
   LFound: Boolean;
begin
   for LLoopTable in AListTable do
   begin
      LIndexTable := LLoopTable as TDataBaseIndex;
      LFound := False;

      for LLoopObject in AListObject do
      begin
         LIndexObject := LLoopObject as TDataBaseIndex;

         if (LIndexTable.FieldName = LIndexObject.FieldName) then
         begin
            LFound := True;
            Break;
         end;
      end;

      if (not LFound) then
         Drop_Index(LIndexTable);
   end;
end;

function TSystemEngineDataBaseUpdate.TryGetForeignKeyFrom_Field(const AList: TSystemList; const AFieldName: UnicodeString): TDataBaseForeignKey;
var
   LLoop: TObject;
   LDataBaseForeignKey: TDataBaseForeignKey;
begin
   Result := nil;

   for LLoop in AList do
   begin
      LDataBaseForeignKey := LLoop as TDataBaseForeignKey;

      if LDataBaseForeignKey.FieldName.Equals(AFieldName) then
         Exit(LDataBaseForeignKey);
   end;
end;

procedure TSystemEngineDataBaseUpdate.UpdateDecimals_Field(const AFieldDataBase: TDataBaseField; const ATableName: UnicodeString);
begin
   ExecuteSQL(AppSQLPatternDB.UpdateDecimalsField(AFieldDataBase.Name, ATableName, AFieldDataBase.Length, AFieldDataBase.Decimals));
end;

procedure TSystemEngineDataBaseUpdate.Update_Application_Data;
var
   LApplication: TApplicationData;
begin
   LApplication := TApplicationData.Create;
   try
      LApplication.Id := 1;
      LApplication.Version := VersionUtils.GetApplication_Version;
      LApplication.LastUpdatedDate := Now;
      ORMUtils.Edit_Record(LApplication);
   finally
      FreeAndNil(LApplication);
   end;
end;

procedure TSystemEngineDataBaseUpdate.Update_Fields(const ADataBaseTable: TDataBaseTable);
var
   LListTable, LListObject, LListFK: TSystemList;
   LLoopTable, LLoopObject: TObject;
   LFieldTable, LFieldObject: TDataBaseField;
   LFound: Boolean;
   LForeignKey: TDataBaseForeignKey;
begin
   LListTable := GetFieldsFrom_DataBase(ADataBaseTable.Name);
   LListObject := ADataBaseTable.Fields;
   LListFK := GetForeignKeysFrom_DataBase(ADataBaseTable.Name);
   try
      for LLoopObject in LListObject do
      begin
         LFieldObject := LLoopObject as TDataBaseField;
         LFound := False;

         for LLoopTable in LListTable do
         begin
            LFieldTable := LLoopTable as TDataBaseField;

            if LFieldObject.Name.Equals(LFieldTable.Name) then
            begin
               LFound := True;

               LForeignKey := TryGetForeignKeyFrom_Field(LListFK, LFieldObject.Name);

               if (LForeignKey <> nil) then
                  Drop_ForeignKey(LForeignKey);

               if (LFieldObject.TypeText <> LFieldTable.TypeText) or (LFieldObject.PrimaryKey <> LFieldTable.PrimaryKey) then
               begin
                  Drop_Field(ADataBaseTable.Name, LFieldObject.Name);
                  Create_Field(ADataBaseTable.Name, LFieldObject);
               end;

               if (LFieldObject.NotNull <> LFieldTable.NotNull) then
                  UpdateNullFlag_Field(LFieldObject.NotNull, ADataBaseTable.Name, LFieldObject.Name);

               if (LFieldObject.Length <> LFieldTable.Length) then
                  UpdateLength_Field(LFieldObject, ADataBaseTable.Name);

               if (LFieldObject.Decimals <> LFieldTable.Decimals) then
                  UpdateDecimals_Field(LFieldObject, ADataBaseTable.Name);
            end;
         end;

         if (not LFound) then
            Create_Field(ADataBaseTable.Name, LFieldObject);
      end;

      // -> Se existe o campo no banco de dados, mas não no objeto, então exclui do banco de dados
      SearchAndDeleteExtra_Field(ADataBaseTable, LListObject, LListTable);
   finally
      FreeAndNil(LListTable);
      FreeAndNil(LListFK);
   end;
end;

procedure TSystemEngineDataBaseUpdate.Update_ForeignKeys(const ADataBaseTable: TDataBaseTable);
var
   LListTable, LListObject: TSystemList;
   LLoopTable, LLoopObject: TObject;
   LFKTable, LFKObject: TDataBaseForeignKey;
   LFound: Boolean;
begin
   LListTable := GetForeignKeysFrom_DataBase(ADataBaseTable.Name);
   LListObject := ADataBaseTable.ForeignKeys;

   for LLoopObject in LListObject do
   begin
      LFKObject := LLoopObject as TDataBaseForeignKey;
      LFound := False;

      for LLoopTable in LListTable do
      begin
         LFKTable := LLoopTable as TDataBaseForeignKey;

         if (LFKTable.FieldName = LFKObject.FieldName) then
         begin
            LFound := True;

            if (LFKObject.TableName <> LFKTable.TableName) or (LFKObject.FieldNameReference <> LFKTable.FieldNameReference) or
            (LFKObject.TableNameReference <> LFKTable.TableNameReference) then
            begin
               Drop_ForeignKey(LFKTable);
               Create_ForeignKey(LFKObject);
            end;

            Break;
         end;
      end;

      if (not LFound) then
         Create_ForeignKey(LFKObject);
   end;

    // -> Se existe a FK no banco de dados, mas não no objeto, então exclui do banco de dados
   SearchAndDeleteExtra_ForeignKey(ADataBaseTable, LListTable, LListObject);
   FreeAndNil(LListTable);
end;

procedure TSystemEngineDataBaseUpdate.Update_Indexs(const ADataBaseTable: TDataBaseTable);
var
   LListTable, LListObject: TSystemList;
   LLoopTable, LLoopObject: TObject;
   LIndexTable, LIndexObject: TDataBaseIndex;
   LFound: Boolean;
begin
   LListObject := ADataBaseTable.Indexs;
   LListTable := GetIndexesFrom_DataBase(ADataBaseTable.Name);

   for LLoopObject in LListObject do
   begin
      LIndexObject := LLoopObject as TDataBaseIndex;
      LFound := False;

      for LLoopTable in LListTable do
      begin
         LIndexTable := LLoopTable as TDataBaseIndex;

         if (LIndexTable.FieldName = LIndexObject.FieldName) then
         begin
            LFound := True;
            Break;
         end;
      end;

      if (not LFound) then
         Create_Index(LIndexObject);
   end;

    // -> Se existe o INDEX no banco de dados, mas não no objeto, então exclui do banco de dados
   SearchAndDeleteExtra_Index(ADataBaseTable, LListObject, LListTable);
   FreeAndNil(LListTable);
end;

procedure TSystemEngineDataBaseUpdate.UpdateLength_Field(const AFieldDataBase: TDataBaseField; const ATableName: UnicodeString);
begin
   ExecuteSQL(AppSQLPatternDB.UpdateLengthField(AFieldDataBase.Name, ATableName, AFieldDataBase.Length));
end;

procedure TSystemEngineDataBaseUpdate.UpdateNullFlag_Field(const AFlag: Boolean; const ATableName, AFieldName: UnicodeString);
begin
   ExecuteSQL(AppSQLPatternDB.UpdateNullFlagField(AFieldName, ATableName, AFlag));
end;

procedure TSystemEngineDataBaseUpdate.Update_Relations;
var
   LEntity: TObject;
   LExtract: TExtract;
   LDataBaseTable: TDataBaseTable;
begin
  // AppWatcher.Show('Atualizando a estrutura das tabelas', gvEntitys.Count);
   try
      for LEntity in gvRegistry do
      begin
         LExtract := TExtract.Create(LEntity);
         try
            LDataBaseTable := LExtract.ExtractDataBase_Table;

            if (LDataBaseTable = nil) then
            begin
//               AppWatcher.IncProgress;
               FreeAndNil(LExtract);
               Continue;
            end;

            // -> Relation
            Create_Relation(LDataBaseTable);

            // -> Fields
            Update_Fields(LDataBaseTable);

            // -> ForeignKeys
            Update_ForeignKeys(LDataBaseTable);

            // -> Indexs
            Update_Indexs(LDataBaseTable);

            FreeAndNil(LDataBaseTable);
         finally
            FreeAndNil(LExtract);
         end;

//         AppWatcher.IncProgress;
      end;
   finally
//      AppWatcher.Close;
   end;
end;

{ TSystemEngineDataBaseCreate }

procedure TSystemEngineDataBaseCreate.Create_Fields(const ADataBaseTable: TDataBaseTable);
begin
   if (RelationUtils.Table_InSchemaDB(ADataBaseTable.Name)) then
      Exit;

   ExecuteSQL(CommandsText.CreateRelationDataBase(ADataBaseTable));
end;

procedure TSystemEngineDataBaseCreate.Create_ForeignKeys;
var
   LEntity: TObject;
   LExtract: TExtract;
   LDataBaseTable: TDataBaseTable;
begin
   //AppWatcher.Show('Criando chaves estrangeiras', gvEntitys.Count);
   try
      for LEntity in gvRegistry do
      begin
         LExtract := TExtract.Create(LEntity);
         try
            LDataBaseTable := LExtract.ExtractDataBase_Table;

            if (LDataBaseTable = nil) then
            begin
              // AppWatcher.IncProgress;
               Continue;
            end;

            // -> FKs
            Create_ForeignKeysFrom_Table(LDataBaseTable);

            FreeAndNil(LDataBaseTable);
         finally
            FreeAndNil(LExtract);
         end;

       //  AppWatcher.IncProgress;
      end;
   finally
      //AppWatcher.Close;
   end;
end;

procedure TSystemEngineDataBaseCreate.Create_ForeignKeysFrom_Table(const ADataBaseTable: TDataBaseTable);
begin
   ExecuteSQL(CommandsText.CreateForeignKeyDataBase(ADataBaseTable));
end;

procedure TSystemEngineDataBaseCreate.Create_Functions;
begin

end;

procedure TSystemEngineDataBaseCreate.Create_Indexes(const ADataBaseTable: TDataBaseTable);
begin
   ExecuteSQL(CommandsText.CreateIndexDataBase(ADataBaseTable));
end;

procedure TSystemEngineDataBaseCreate.Create_Relations;
var
   LEntity: TObject;
   LExtract: TExtract;
   LDataBaseTable: TDataBaseTable;
begin
   WatcherUtils.Show_Watcher('Criando estrutura de tabelas', tswNormal, gvRegistry.Count);
   try
      for LEntity in gvRegistry do
      begin
         LExtract := TExtract.Create(LEntity);
         try
            LDataBaseTable := LExtract.ExtractDataBase_Table;

            if (LDataBaseTable = nil) then
            begin
               WatcherUtils.Inc_Progress;
               Continue;
            end;

            // -> Fields
            Create_Fields(LDataBaseTable);

            // -> Index
            Create_Indexes(LDataBaseTable);

            FreeAndNil(LDataBaseTable);
         finally
            FreeAndNil(LExtract);
         end;

         WatcherUtils.Inc_Progress;
      end;
   finally
      WatcherUtils.Close;
   end;
end;

procedure TSystemEngineDataBaseCreate.Create_Triggers;
begin

end;

procedure TSystemEngineDataBaseCreate.Execute;
begin
   Transaction.Start;
   Create_Relations;
   Create_ForeignKeys;
   Create_Functions;
   Create_Triggers;
   Transaction.Commit;

   New_ApplicationData;
   New_Empresa;
   New_Usuario;
end;

procedure TSystemEngineDataBaseCreate.New_ApplicationData;
var
   LApplication: TApplicationData;
begin
   LApplication := TApplicationData.Create;
   try
      LApplication.Version := VersionUtils.GetApplication_Version;
      LApplication.LastUpdatedDate := Now;
      LApplication.ExpirationDate := StrToDate('31/12/2099');
      LApplication.GoogleWorkSpace := False;

      ORMUtils.New_Record(LApplication);
   finally
      FreeAndNil(LApplication);
   end;
end;

procedure TSystemEngineDataBaseCreate.New_Empresa;
var
   LEmpresa: TEmpresa;
begin
   LEmpresa := TEmpresa.Create;
   try
      LEmpresa.RazaoSocial := 'ArchFlow';
      LEmpresa.Active := True;
      LEmpresa.CpfCnpj := '00000000000000';
      LEmpresa.TipoPessoa := 1;

      TORMUtils.New_Record(LEmpresa);
   finally
      FreeAndNil(LEmpresa);
   end;
end;

procedure TSystemEngineDataBaseCreate.New_Usuario;
var
   LUsuario: TUsuario;
//   LManager: TManagerAccess;
begin
   LUsuario := TUsuario.Create;
   try
      LUsuario.Nome := 'admin';
//      LUsuario.CPF := '00000000000';
//      LUsuario.UserName := 'admin';
//      LUsuario.PassWord := 'admin';
//      LUsuario.Tipo := 0;
//      LUsuario.TypeWorker := 0;
//      LUsuario.IdEmpresa := 1;
//      LUsuario.ID := 999;
//      LUsuario.Active := True;
//
//      AppPersistent.Insert(LUsuario);
//
//      LManager := TManagerAccess.Create;
//      try
//         LManager.InsertUsuarioAccess(999, 1, 'admin', True);
//         LManager.InsertUsuarioOnline(999, 1);
//      finally
//         FreeAndNil(LManager);
//      end;
   finally
      FreeAndNil(LUsuario);
   end;
end;

{ TSystemEngineDataBaseCommon }

destructor TSystemEngineDataBaseCommon.Destroy;
begin
   ObjUtils.Release_(FQuery);
   ObjUtils.Release_(FTransaction);
   ObjUtils.Release_(FCommandsText);
   inherited Destroy;
end;

procedure TSystemEngineDataBaseCommon.ExecuteSQL(const ASQL: UnicodeString);
begin
   Query.AddSQL(ASQL);
   Query.ExecuteWithTransaction;
end;

function TSystemEngineDataBaseCommon.GetCommandsText: TORMCommandsText;
begin
   if (not Assigned(FCommandsText)) then
      FCommandsText := TORMCommandsText.Create;

   Result := FCommandsText;
end;

function TSystemEngineDataBaseCommon.GetQuery: TQuery;
begin
   if (not Assigned(FQuery)) then
      FQuery := TQuery.Create(Transaction);

   Result := FQuery;
end;

function TSystemEngineDataBaseCommon.GetTransaction: TConnectionTransaction;
begin
   if (not Assigned(FTransaction)) then
      FTransaction := TConnectionTransaction.Create;

   Result := FTransaction;
end;

procedure TSystemEngineDataBaseCommon.SetCommandsText(const Value: TORMCommandsText);
begin
   FCommandsText := Value;
end;

procedure TSystemEngineDataBaseCommon.SetQuery(const Value: TQuery);
begin
   FQuery := Value;
end;

procedure TSystemEngineDataBaseCommon.SetTransaction(const Value: TConnectionTransaction);
begin
   FTransaction := Value;
end;

end.

