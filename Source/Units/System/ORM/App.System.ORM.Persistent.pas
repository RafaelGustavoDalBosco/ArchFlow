unit App.System.ORM.Persistent;

interface

uses

{$REGION '| USES |'}
   System.SysUtils,
   App.System.Connection.Transaction,
   App.System.ORM.Extract,
   App.DataBase.Objects,
   App.System.Types,
   App.System.ORM.CommandsText,
   App.System.Connection.Query,
   App.DataBase.Consts,
   App.Objects.Entity.Default,
   App.System.List;
{$ENDREGION}

type

   TORMPersistent = class sealed (TObject)
   protected
      FObject: TObject;
      FExtract: TExtract;
      FDataBaseRecord: TDataBaseRecord;
      FTransaction: TConnectionTransaction;
      FIsTransactionOut: Boolean;
   strict private
      /// <summary>
      ///    Inicia a transação
      /// </summary>
      procedure Start_Transaction;

      /// <summary>
      ///    Commita a transação
      /// </summary>
      procedure Commit_Transaction;
   strict protected
      /// <summary>
      ///    Gera a SQL de acordo com o tipo
      /// </summary>
      /// <param name="AType">
      ///    Define o tipo da operação
      /// </param>
      function GenerateCommandTextFrom_Type(const AType: TTypeOperation): UnicodeString;

      /// <summary>
      ///    Método responsável por executar APÓS o Result[True] do Select
      /// </summary>
      /// <param name="AQuery">
      ///    Objeto TQuery responsável pela ação
      /// </param>
      procedure ExecuterAfter_Select(const AQuery: TQuery);

      /// <summary>
      ///    Método responsável por executar APÓS o Result[True] do Insert
      /// </summary>
      /// <param name="AQuery">
      ///    Objeto TQuery responsável pela ação
      /// </param>
      procedure ExecuterAfter_Insert(const AQuery: TQuery);

      /// <summary>
      ///     Método responsável por executar APÓS o Result[True] do Update
      /// </summary>
      /// <param name="AQuery">
      ///    Objeto TQuery responsável pela ação
      /// </param>
      procedure ExecuteAfter_Update(const AQuery: TQuery);

      /// <summary>
      ///     Método responsável por executar APÓS o Result[True] do Update
      /// </summary>
      procedure ExecuteAfter_Delete(const AQuery: TQuery);
   strict protected
      /// <summary>
      ///    Abre uma nova instância da persistência, para persistir apenas um objeto
      /// </summary>
      /// <param name="AObject">
      ///    Objeto a ser persistência individualmente
      /// </param>
      function PersistSingleObject(const AObject: TObject): Boolean;

      /// <summary>
      ///    Percorre as propriedades do objeto, e verifica os List e Object para persistir
      /// </summary>
      /// <param name="AID">
      ///    Usa o ID do objeto recém criado/editado
      /// </param>
      function PersistObjects(const AId: Int64): Boolean;
   public
      /// <summary>
      ///    Insere um registro no banco de dados
      /// </summary>
      function Insert: Boolean;

      /// <summary>
      ///    Atualiza um registro no banco de dados
      /// </summary>
      function Update: Boolean;

      /// <summary>
      ///    Remove um registro do banco de dados
      /// </summary>
      function Delete: Boolean;

      /// <summary>
      ///    Busca um registro no banco de dados
      /// </summary>
      /// <param name="ACustomSQL">
      ///    Caso tenha uma SQL personalizada, será executada ela
      /// </param>
      function Select(const ACustomSQL: UnicodeString = ''): Boolean;

      /// <summary>
      ///    Cria a lista padrão de um objeto (se não passar a SQL, será coletado tudo baseado no TFieldParam)
      /// </summary>
      /// <param name="ACustomSQL">
      ///    Caso tenha uma SQL personalizada, será executada ela
      /// </param>
      function List(const ACustomSQL: UnicodeString = ''): TSystemList;

      /// <summary>
      ///    Persiste o objeto baseado no seu TTypeOperation
      /// </summary>
      function PersistFrom_Type: Boolean;

      /// <param name="AObject">
      ///    Define um objeto padrão para usar todos os métodos simultaneamente
      /// </param>
      /// <param name="ATransaction">
      ///    Define a transação da persistência, por padrão é NIL
      /// </param>
      constructor Create(const AObject: TObject; const ATransaction: TConnectionTransaction = nil); overload;
      destructor Destroy; override;
   end;

implementation

{ TORMPersistent }

uses App.Common.Utils;

procedure TORMPersistent.Commit_Transaction;
begin
   if (not FIsTransactionOut) then
      FTransaction.Commit;
end;

constructor TORMPersistent.Create(const AObject: TObject; const ATransaction: TConnectionTransaction);
begin
   FObject := AObject;
   FExtract := TExtract.Create(AObject);
   FDataBaseRecord := FExtract.ExtractDataBaseRecord;
   FTransaction := ATransaction;

   if (ATransaction <> nil) then
   begin
      FTransaction := ATransaction;
      FIsTransactionOut := True;
   end
   else
   begin
      FTransaction := TConnectionTransaction.Create;
      FIsTransactionOut := False;
   end;

   Start_Transaction;
   inherited Create;
end;

function TORMPersistent.Delete: Boolean;
var
   LQuery: TQuery;
begin
   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(GenerateCommandTextFrom_Type(toDelete));
      FExtract.ExtractParamFromObjectTo_Query(LQuery, toDelete);

      Result := LQuery.Execute;

      if (Result) then
         ExecuteAfter_Delete(LQuery);
   finally
      FreeAndNil(LQuery);
   end;
end;

destructor TORMPersistent.Destroy;
begin
   FreeAndNil(FExtract);
   ObjUtils.Release_(FDataBaseRecord);

   if (not FIsTransactionOut) then
      ObjUtils.Release_(FTransaction);

   inherited Destroy;
end;

procedure TORMPersistent.ExecuteAfter_Delete(const AQuery: TQuery);
begin
   if (FDataBaseRecord.HasList) then
      PersistObjects(TEntity(FObject).Id);

   Commit_Transaction;
end;

procedure TORMPersistent.ExecuteAfter_Update(const AQuery: TQuery);
begin
   if (FDataBaseRecord.HasList or FDataBaseRecord.HasObject) then
      PersistObjects(TEntity(FObject).Id);

   Commit_Transaction;
end;

procedure TORMPersistent.ExecuterAfter_Insert(const AQuery: TQuery);
var
   LId: Int64;
begin
   LId := AQuery.FieldToInt64(SField_Id);  // -> Always a PK
   TEntity(FObject).Id := LId;

   PersistObjects(LId);
   Commit_Transaction;
end;

procedure TORMPersistent.ExecuterAfter_Select(const AQuery: TQuery);
begin
   TEntity(FObject).TypeOperation := toNone;

   FExtract.ExtractFieldFromQueryTo_Object(AQuery);

   if (FDataBaseRecord.HasList) then
      FExtract.ExtractFieldListTo_Object(FObject, TEntity(FObject).Id, FDataBaseRecord.OwnerType);

   if (FDataBaseRecord.HasObject) then
      FExtract.ExtractFieldObjectTo_Object(FObject, TEntity(FObject).Id, FDataBaseRecord.OwnerType);
end;

function TORMPersistent.GenerateCommandTextFrom_Type(const AType: TTypeOperation): UnicodeString;
var
   LCommand: TORMCommandsText;
begin
   LCommand := TORMCommandsText.Create;
   try
      case AType of
         toNew: Result := LCommand.InsertRecord(FDataBaseRecord);
         toEdit: Result := LCommand.UpdateRecord(FDataBaseRecord);
         toDelete: Result := LCommand.DeleteRecord(FDataBaseRecord);
         toSelect: Result := LCommand.SelectRecord(FDataBaseRecord);
         toList: Result := LCommand.ListRecord(FDataBaseRecord);
         toNone: raise Exception.Create('Tipo não definido no método [TORMPersistent.GenerateCommandTextFromType]');
      end;
   finally
      FreeAndNil(LCommand);
   end;
end;

function TORMPersistent.Insert: Boolean;
var
   LQuery: TQuery;
begin
   LQuery := TQuery.Create;
   try
      if (not FIsTransactionOut) then
         FTransaction.Start;

      LQuery.AddSQL(GenerateCommandTextFrom_Type(toNew));
      FExtract.ExtractParamFromObjectTo_Query(LQuery, toNew);

      Result := LQuery.GetData;

      if (Result) then
        ExecuterAfter_Insert(LQuery);
   finally
      FreeAndNil(LQuery);
   end;
end;

function TORMPersistent.List(const ACustomSQL: UnicodeString = ''): TSystemList;
var
   LQuery: TQuery;
   LCommandText: UnicodeString;
begin
   Result := TSystemList.Create;

   LQuery := TQuery.Create;
   try
      if (ACustomSQL.IsEmpty) then
         LCommandText := GenerateCommandTextFrom_Type(toList)
      else
         LCommandText := ACustomSQL;

      LQuery.AddSQL(LCommandText);

      if (ACustomSQL.IsEmpty) then
         FExtract.ExtractParamFromObjectTo_Query(LQuery, toList);

      if (LQuery.GetData) then
         FExtract.ExtractFieldFromQueryTo_List(LQuery, Result);
   finally
      FreeAndNil(LQuery);
   end;
end;

function TORMPersistent.PersistFrom_Type: Boolean;
var
   LEntity: TEntity;
begin
   LEntity := TEntity(FObject);

   case LEntity.TypeOperation of
      toNew: Result := Insert;
      toEdit: Result := Update;
      toSelect: Result := Select;
      toDelete: Result := Delete;
      toList: raise Exception.Create('Tipo de operação, não permitida no método [PersistFrom_Type]');
   else
      Result := False;
   end;
end;

function TORMPersistent.PersistObjects(const AId: Int64): Boolean;
var
   LRecordItem: TDataBaseRecordItem;
   LList: TSystemList;
   LLoop, LObject: TObject;
   LRoot: TEntityRoot;
begin
   for LLoop in FDataBaseRecord.Records do
   begin
      LRecordItem := LLoop as TDataBaseRecordItem;

      if (LRecordItem.IsList) then
      begin
         LList := LRecordItem.Value.AsObject as TSystemList;

         if (LList <> nil) then
         begin
            for LObject in LList do
            begin
               if (LObject is TEntityRoot) then
               begin
                  LRoot := TEntityRoot(LObject);
                  LRoot.OwnerType := Ord(FDataBaseRecord.OwnerType);
                  LRoot.OwnerId := AId;
                  LRoot.IdEmpresa := 1;
                  LRoot.Id := TEntity(LObject).Id;
               end;

               PersistSingleObject(LObject);
            end;
         end;
      end;

      if (LRecordItem.IsObject) then
         PersistSingleObject(LRecordItem.Value.AsObject);
   end;

   Result := True;
end;

function TORMPersistent.PersistSingleObject(const AObject: TObject): Boolean;
var
   LPersistent: TORMPersistent;
begin
   LPersistent := TORMPersistent.Create(AObject, FTransaction);
   try
      Result := LPersistent.PersistFrom_Type;
   finally
      FreeAndNil(LPersistent);
   end;
end;

function TORMPersistent.Select(const ACustomSQL: UnicodeString): Boolean;
var
   LSQL: UnicodeString;
   LQuery: TQuery;
begin
   if (ACustomSQL.IsEmpty) then
      LSQL := GenerateCommandTextFrom_Type(toSelect)
   else
      LSQL := ACustomSQL;

   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(LSQL);

      if (ACustomSQL.IsEmpty) then
         FExtract.ExtractParamFromObjectTo_Query(LQuery, toSelect);

      Result := LQuery.GetData;

      if (Result) then
         ExecuterAfter_Select(LQuery);
   finally
      FreeAndNil(LQuery);
   end;
end;

procedure TORMPersistent.Start_Transaction;
begin
   if (not FIsTransactionOut) then
      FTransaction.Start;
end;

function TORMPersistent.Update: Boolean;
var
   LQuery: TQuery;
begin
   LQuery := TQuery.Create;
   try
      LQuery.AddSQL(GenerateCommandTextFrom_Type(toEdit));
      FExtract.ExtractParamFromObjectTo_Query(LQuery, toEdit);

      Result := LQuery.Execute;

      if (Result) then
         ExecuteAfter_Update(LQuery);
   finally
      FreeAndNil(LQuery);
   end;
end;

end.
