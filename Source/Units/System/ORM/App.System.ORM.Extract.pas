unit App.System.ORM.Extract;

interface

uses

{$REGION '| USES |'}
   System.SysUtils,
   System.Classes,
   System.Rtti,
   System.Math,
   Data.DB,

   App.System.Connection.Query,
   App.System.ORM.InspectAttributes,
   App.System.ORM.CustomAttributes,
   App.DataBase.Objects,
   App.System.List,
   App.Common.Types,
   App.System.Types,
   App.Objects.Entity.Default;
{$ENDREGION}

type

   TExtractCommon = class
   protected
      FInspect: TInspectAttributes;
      FProperty: TRttiProperty;
      FObject: TObject;
      FFieldName: UnicodeString;
      FQuery: TQuery;
   private
      /// <summary>
      ///    Raises Exception = [avisa o usuário sober o menor/maior valor da property]
      /// </summary>
      /// <param name="AMinValue">
      ///    Valor Mínimo para checagem
      /// </param>
      /// <param name="AMaxValue">
      ///    Valor Máximo para checagem
      /// </param>
      /// <param name="AActualValue">
      ///    Valor atual
      /// </param>
      /// <param name="APropertyName">
      ///    Nome da Property
      /// </param>
      procedure ExceptionRangeValueProperty(const AMinValue, AMaxValue, AActualValue, APropertyName: UnicodeString);
   public
      /// <summary>
      ///    Extract
      /// </summary>
      procedure Extract; virtual; abstract;

      /// <param name="AObject">
      ///    Objeto que terá as informações assistidas
      /// </param>
      /// <param name="ARttiProperty">
      ///    RttiProperty que terá as informações extraídas
      /// </param>
      /// <param name="AFieldName">
      ///    Nome do campo no banco de dados
      /// </param>
      /// <param name="AQuery">
      ///    TQuery<System.Query> que está cuidando da conexão
      /// </param>
      constructor Create(const AObject: TObject; const ARttiProperty: TRttiProperty; const AFieldName: UnicodeString; const AQuery: TQuery); overload;
   end;

   TExtractParamToQuery = class(TExtractCommon)
   strict private
      /// <summary>
      ///    Extract Param To Query [Int64]
      /// </summary>
      procedure ExtractParam_Int64;

      /// <summary>
      ///    Extract Param To Query [Integer]
      /// </summary>
      procedure ExtractParam_Integer;

      /// <summary>
      ///    Extract param To Query [SmallInt]
      /// </summary>
      procedure ExtractParam_SmallInt;

      /// <summary>
      ///    Extract Param To Query [ShortInt]
      /// </summary>
      procedure ExtractParam_ShotInt;

      /// <summary>
      ///    Extract Param To Query [Currency]
      /// </summary>
      procedure ExtractParam_Currency;

      /// <summary>
      ///    Extract Param to Query [String]
      /// </summary>
      procedure ExtractParam_String;

      /// <summary>
      ///    Extract Param To Query [Date]
      /// </summary>
      procedure ExtractParam_Date;

      /// <summary>
      ///    Extract Param To Query [DateTime]
      /// </summary>
      procedure ExtractParam_DateTime;

      /// <summary>
      ///    Extract Param To Query [Time]
      /// </summary>
      procedure ExtractParam_Time;

      /// <summary>
      ///    Extract Param To Query [Boolean]
      /// </summary>
      procedure ExtractParam_Boolean;

      /// <summary>
      ///    Extract Param To Bytea [Bytea]
      /// </summary>
      procedure ExtractParam_Bytea;
   public
      /// <summary>
      ///    Extract
      /// </summary>
      procedure Extract; override;
   end;

   TExtractFieldToQuery = class(TExtractCommon)
   strict private
      /// <summary>
      ///    Extract Field To Query [Int64]
      /// </summary>
      procedure ExtractField_Int64;

      /// <summary>
      ///    Extract Field To Query [Integer]
      /// </summary>
      procedure ExtractField_Integer;

      /// <summary>
      ///    Extract Field To Query [SmallInt]
      /// </summary>
      procedure ExtractField_SmallInt;

      /// <summary>
      ///    Extract Field To Query [ShortInt]
      /// </summary>
      procedure ExtractField_ShortInt;

      /// <summary>
      ///    Extract Field To Query [Currency]
      /// </summary>
      procedure ExtractField_Currency;

      /// <summary>
      ///    Extract Field To Query [String]
      /// </summary>
      procedure ExtractField_String;

      /// <summary>
      ///    Extract Field To Query [Date]
      /// </summary>
      procedure ExtractField_Date;

      /// <summary>
      ///    Extract Field To Query [DateTime]
      /// </summary>
      procedure ExtractField_DateTime;

      /// <summary>
      ///    Extract Field To Query [Time]
      /// </summary>
      procedure ExtractField_Time;

      /// <summary>
      ///    Extract Field To Query [Boolean]
      /// </summary>
      procedure ExtractField_Boolean;

      /// <summary>
      ///    Extract Field to Bytea [Bytea]
      /// </summary>
      procedure ExtractField_Bytea;
   public
      /// <summary>
      ///    Extract
      /// </summary>
      procedure Extract; override;
   end;


   TExtractDataBaseField = class
   protected
      FInspect: TInspectAttributes;
      FDataBaseField: TDataBaseField;
      FProperty: TRttiProperty;
   strict private
      /// <summary>
      ///    Extract.Property.Currency
      /// </summary>
      procedure FieldPropertyCurrency;

      /// <summary>
      ///    Extract.Property.String
      /// </summary>
      procedure FieldPropertyString;

      /// <summary>
      ///    Extract.Property.Integer
      /// </summary>
      procedure FieldPropertyInteger;

      /// <summary>
      ///    Extract.Property.Int64
      /// </summary>
      procedure FieldPropertyInt64;

      /// <summary>
      ///    Extract.Property.SmallInt
      /// </summary>
      procedure FieldPropertySmallInt;

      /// <summary>
      ///    Extract.Property.ShortInt
      /// </summary>
      procedure FieldPropertyShortInt;

      /// <summary>
      ///    Extract.Property.Bytea
      /// </summary>
      procedure FieldPropertyBytea;

      /// <summary>
      ///    Extract.Property.Date
      /// </summary>
      procedure FieldPropertyDate;

      /// <summary>
      ///    Extract.Property.DateTime
      /// </summary>
      procedure FieldPropertyDateTime;

      /// <summary>
      ///    Extract.Property.Time
      /// </summary>
      procedure FieldPropertyTime;

      /// <summary>
      ///    Extract.Property.Boolean
      /// </summary>
      procedure FieldPropertyBoolean;
   public
      /// <summary>
      ///    Extract.Property = [TDataBaseField]
      /// </summary>
      procedure Extract;

      /// <param name="AProperty">
      ///    Propriedade do Objeto que terá os dados extraídos para a classe TDataBaseField
      /// </param>
      /// <param name="ADataBaseField">
      ///    Objeto que terá as informações vinculadas
      /// </param>
      constructor Create(const AProperty: TRttiProperty; const ADataBaseField: TDataBaseField); overload;
      destructor Destroy; override;
   end;

   TExtract = class
   strict private
      FObject: TObject;
      FContext: TRttiContext;
      FRttiType: TRttiType;
      FInspect: TInspectAttributes;
   private
      FTableAttribute: TTable;
      procedure SetTableAttribute(const Value: TTable);

      /// <summary>
      ///    Obtém o Custom Attributes = [TTable]
      /// </summary>
       function GetTableAttribute: TTable;
   protected
      /// <summary>
      ///    Extract Param Type To [Query]
      /// </summary>
      /// <param name="ARttiProperty">
      ///    Property do Objeto que será localizada pela Query
      /// </param>
      /// <param name="AFieldName">
      ///    Nome do campo no banco de dados
      /// </param>
      /// <param name="AQuery">
      ///    Query que está realizando a operação
      /// </param>
      procedure ExtractParamTypeTo_Query(const ARttiProperty: TRttiProperty; const AFieldName: UnicodeString; const AQuery: TQuery);

      /// <summary>
      ///    Extract Field Type To [Query]
      /// </summary>
      /// <param name="ARttiProperty">
      ///    Property do Objeto que será localizada pela Query
      /// </param>
      /// <param name="AFieldName">
      ///    Nome do campo no banco de dados
      /// </param>
      /// <param name="AQuery">
      ///    Query que está realizando a operação
      /// </param>
      procedure ExtractFieldTypeTo_Query(const ARttiProperty: TRttiProperty; const AFieldName: UnicodeString; const AQuery: TQuery);

      /// <summary>
      ///    Property TTable
      /// </summary>
      property TableAttribute: TTable read GetTableAttribute write SetTableAttribute;
   public
      /// <summary>
      ///    Extract [TDataBaseTable]
      /// </summary>
      function ExtractDataBase_Table: TDataBaseTable;

      /// <summary>
      ///    Extract [TDataBaseRecordItems]
      /// </summary>
      function ExtractDataBase_RecordItems: TSystemList;

      /// <summary>
      ///   Extract [TDataBaseFields]
      /// </summary>
      function ExtractBaseBase_Fields: TSystemList;

      /// <summary>
      ///    Extract [TDataBaseForeignKey]
      /// </summary>
      function ExtractDataBase_ForeignKeys: TSystemList;

      /// <summary>
      ///    Extract [TDataBaseIndex]
      /// </summary>
      function ExtractDataBase_Indexs: TSystemList;

      /// <summary>
      ///    Extract [Has List]
      /// </summary>
      function Extract_HasList: Boolean;

      /// <summary>
      ///    Extract [Has Object]
      /// </summary>
      function Extract_HasObject: Boolean;

      /// <summary>
      ///    Extract [OwnerType]
      /// </summary>
      function Extract_OwnerType: TOwnerType;

      /// <summary>
      ///    Extract [AccessControl]
      /// </summary>
      function Extract_AcessControl: Boolean;

      /// <summary>
      ///    Extract [DataBaseRecord]
      /// </summary>
      function ExtractDataBaseRecord: TDataBaseRecord;

      /// <summary>
      ///    ExtractAndSet [TFieldBound]
      /// </summary>
      /// <param name="AObject">
      ///    Define o objeto que será obtido o TFieldBound
      /// </param>
      /// <param name="AOwnerId">
      ///    Owner Id do registro Bound
      /// </param>
      procedure ExtractAndSetField_Bound(const AObject: TObject; const AOwnerId: Int64);

      /// <summary>
      ///    Extrai os campos da TQuery e vincula ao Objeto
      /// </summary>
      /// <param name="AQuery">
      ///    Objeto TQuery resposnável pela operação
      /// </param>
      procedure ExtractFieldFromQueryTo_Object(const AQuery: TQuery);

      /// <summary>
      ///    Extrai os campos da TQuery e vincula a List
      /// </summary>
      /// <param name="AQuery">
      ///    Objeto TQuery resposnável pela operação
      /// </param>
      /// <param name="AList">
      ///    TSystemList responsável pelo carregamento dos registros
      /// </param>
      procedure ExtractFieldFromQueryTo_List(const AQuery: TQuery; const AList: TSystemList);

      /// <summary>
      ///    Extrai os parâmetros do Objeto e vincula a TQuery
      /// </summary>
     /// <param name="AQuery">
      ///    Objeto TQuery resposnável pela operação
      /// </param>
      /// <param name="ATypeOperation">
      ///    Tipo da operação na extração
      /// </param>
      procedure ExtractParamFromObjectTo_Query(const AQuery: TQuery; const ATypeOperation: TTypeOperation);

      /// <summary>
      ///    Extrai as properties de um objeto, e vincula ao novo objeto
      /// </summary>
      /// <param name="AObject">
      ///    Objeto que será extraido os dados para o NOVO objeto
      /// </param>
      /// <param name="AOwnerId">
      ///    ID do "dono" do registro
      /// </param>
      /// <param name="AOwnerType">
      ///    Type do Owner do registro [TOwnerType]
      /// </param>
      procedure ExtractFieldObjectTo_Object(const AObject: TObject; const AOwnerId: Int64; const AOwnerType: TOwnerType);

      /// <summary>
      ///    Extrai as properties de uma Lista, e vincula ao novo objeto
      /// </summary>
      /// <param name="AObject">
      ///    Objeto que será extraido os dados para o NOVO objeto
      /// </param>
      /// <param name="AIdOwner">
      ///    ID do "dono" do registro
      /// </param>
      /// <param name="AOwnerType">
      ///    Type do Owner do registro [TOwnerType]
      /// </param>
      procedure ExtractFieldListTo_Object(const AObject: TObject; const AOwnerId: Int64; const AOwnerType: TOwnerType);

      /// <param name="AObject">
      ///    Define o Objeto que terá os dados extraídos
      /// </param>
      constructor Create(const AObject: TObject); overload;
   end;

implementation

{ TExtract }

uses App.Common.Utils, App.System.Consts, App.System.ORM.Persistent;

constructor TExtract.Create(const AObject: TObject);
begin
   FObject := AObject;
   FContext := TRttiContext.Create;
   FRttiType := FContext.GetType(AObject.ClassType);
   inherited Create;
end;

function TExtract.Extract_AcessControl: Boolean;
var
   LProperties: TObjectProperties;
begin
   FInspect := TInspectAttributes.Create(FObject.ClassType);
   try
      LProperties := FInspect.GetAttribute_Properties;

      if (LProperties <> nil) then
         Result := LProperties.AccessControl
      else
         Result := False;
   finally
      FreeAndNil(FInspect);
   end;
end;

function TExtract.ExtractDataBase_Table: TDataBaseTable;
begin
   Result := nil;

   if (TableAttribute <> nil) then
   begin
      Result := TDataBaseTable.Create;
      Result.Name := TableAttribute.Name;
      Result.Comment := TableAttribute.Comment;
      Result.Fields := ExtractBaseBase_Fields;
      Result.Indexs := ExtractDataBase_Indexs;
      Result.ForeignKeys := ExtractDataBase_ForeignKeys;
   end;
end;

procedure TExtract.ExtractAndSetField_Bound(const AObject: TObject; const AOwnerId: Int64);
var
   LInspect: TInspectAttributes;
   LFieldBound: TFieldBound;
   LProperty: TRttiProperty;
   LRttiType: TRttiType;
begin
   LRttiType := FContext.GetType(AObject.ClassType);

   for LProperty in LRttiType.GetProperties do
   begin
      LInspect := TInspectAttributes.Create(LProperty);
      try
         LFieldBound := LInspect.GetAttribute_FieldBound;

         if (LFieldBound <> nil) then
            LProperty.SetValue(FObject, AOwnerId);
      finally
         FreeAndNil(LInspect);
      end;
   end;
end;

function TExtract.ExtractBaseBase_Fields: TSystemList;
var
   LProperty: TRttiProperty;
   LField: TField;
   LInstance: TDataBaseField;
   LExtract: TExtractDataBaseField;
begin
   Result := TSystemList.Create;

   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LField := FInspect.GetAttribute_Field;

         if (LField <> nil) then
         begin
            LInstance := TDataBaseField.Create;
            LInstance.Name := LField.Name;
            LInstance.PrimaryKey := LField.PrimaryKey;
            LInstance.NotNull := LField.Required;

            LExtract := TExtractDataBaseField.Create(LProperty, LInstance);
            try
               LExtract.Extract;
            finally
               FreeAndNil(LExtract);
            end;

            Result.Add(LInstance);
         end;
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

function TExtract.ExtractDataBase_RecordItems: TSystemList;
var
   LProperty: TRttiProperty;
   LField: TField;
   LInstance: TDataBaseRecordItem;
begin
   Result := TSystemList.Create;

   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LInstance := TDataBaseRecordItem.Create;

         LField := FInspect.GetAttribute_Field;

         if (LField <> nil) then
         begin
            LInstance.Name := LField.Name;
            LInstance.PrimaryKey := LField.PrimaryKey;
         end;

         LInstance.IsList := (FInspect.GetAttribute_List <> nil);
         LInstance.IsObject := (FInspect.GetAttribute_Object <> nil);
         LInstance.IsDateTime := (FInspect.GetAttribute_Date <> nil) or (FInspect.GetAttribute_DateTime <> nil);
         LInstance.IsParam := (FInspect.GetAttribute_FieldParam <> nil);

         if (Pointer(FObject) <> nil) then
            LInstance.Value := LProperty.GetValue(Pointer(FObject));

         LInstance.CanSaveHistoric := (FInspect.GetAttribute_Bytea = nil) and (not LInstance.IsList) and (not LInstance.IsObject);

         Result.Add(LInstance);
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

procedure TExtract.ExtractFieldFromQueryTo_List(const AQuery: TQuery; const AList: TSystemList);
var
   LNewObject: TObject;
   LNewExtract: TExtract;
   LOwnerId: Int64;
   LOwnerType: TOwnerType;
begin
   repeat
      LNewObject := FObject.NewInstance;
      AList.Add(LNewObject);

      LNewExtract := TExtract.Create(LNewObject);
      try
         // -> Fields
         LNewExtract.ExtractFieldFromQueryTo_Object(AQuery);

         // -> Owner
         LOwnerId := TEntity(LNewObject).Id;

         // -> Owner Type
         LOwnerType := LNewExtract.Extract_OwnerType;

         // -> Collections
         LNewExtract.ExtractFieldListTo_Object(LNewObject, LOwnerId, LOwnerType);

         // -> Objects
         LNewExtract.ExtractFieldObjectTo_Object(LNewObject, LOwnerId, LOwnerType);
      finally
         FreeAndNil(LNewExtract);
      end;

      AQuery.Next;
   until AQuery.EndOfData;
end;

procedure TExtract.ExtractFieldFromQueryTo_Object(const AQuery: TQuery);
var
   LField: Data.DB.TField;
   LProperty: TRttiProperty;
   LExtract: TExtractFieldToQuery;
begin
   for LField in AQuery.GetFields do
   begin
      for LProperty in FRttiType.GetProperties do
      begin
         LExtract := TExtractFieldToQuery.Create(FObject, LProperty, LField.Name, AQuery);
         try
            LExtract.Extract;
         finally
            FreeAndNil(LExtract);
         end;
      end;
   end;
end;

procedure TExtract.ExtractFieldListTo_Object(const AObject: TObject; const AOwnerId: Int64; const AOwnerType: TOwnerType);
var
   LProperty: TRttiProperty;
   LFieldList: TFieldList;
   LPersistent: TORMPersistent;
begin
   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LFieldList := FInspect.GetAttribute_List;

         if (LFieldList <> nil) then
         begin
            if (AObject is TEntityRoot) then
            begin
               TEntityRoot(AObject).OwnerId := AOwnerId;
               TEntityRoot(AObject).OwnerType := Ord(AOwnerType);
               TEntityRoot(AObject).IdEmpresa := 1;
            end
            else
               ExtractAndSetField_Bound(AObject, AOwnerId);

            LPersistent := TORMPersistent.Create(AObject);
            try
               LProperty.SetValue(AObject, LPersistent.List);
            finally
               FreeAndNil(LPersistent);
            end;
         end;
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

procedure TExtract.ExtractFieldObjectTo_Object(const AObject: TObject; const AOwnerId: Int64; const AOwnerType: TOwnerType);
var
   LProperty: TRttiProperty;
   LFieldObject: TFieldObject;
   LNewObject: TObject;
begin
   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LFieldObject := FInspect.GetAttribute_Object;

         if (LFieldObject <> nil) then
         begin
            LNewObject := LFieldObject.ClassOf.NewInstance;

            if (LNewObject is TEntityRoot) then
            begin
               TEntityRoot(LNewObject).OwnerId := AOwnerId;
               TEntityRoot(LNewObject).OwnerType := Ord(AOwnerType);
               TEntityRoot(LNewObject).IdEmpresa := 1;
            end
            else
               ExtractAndSetField_Bound(LNewObject, AOwnerId);
         end;
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

procedure TExtract.ExtractFieldTypeTo_Query(const ARttiProperty: TRttiProperty; const AFieldName: UnicodeString; const AQuery: TQuery);
var
   LExtractField: TExtractFieldToQuery;
begin
   LExtractField := TExtractFieldToQuery.Create(FObject, ARttiProperty, AFieldName, AQuery);
   try
      LExtractField.Extract;
   finally
      FreeAndNil(LExtractField);
   end;
end;

function TExtract.Extract_HasList: Boolean;
var
   LProperty: TRttiProperty;
   LList: TFieldList;
begin
   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LList := FInspect.GetAttribute_List;

         if (LList <> nil) then
            Exit(True);
      finally
         FreeAndNil(FInspect);
      end;
   end;

   Result := False;
end;

function TExtract.Extract_HasObject: Boolean;
var
   LProperty: TRttiProperty;
   LObject: TFieldObject;
begin
   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LObject := FInspect.GetAttribute_Object;

         if (LObject <> nil) then
            Exit(True);
      finally
         FreeAndNil(FInspect);
      end;
   end;

   Result := False;
end;

function TExtract.Extract_OwnerType: TOwnerType;
var
   LProperties: TObjectProperties;
begin
   FInspect := TInspectAttributes.Create(FObject.ClassType);
   try
      LProperties := FInspect.GetAttribute_Properties;

      if (LProperties <> nil) then
         Result := LProperties.OwnerType
      else
         Result := totNone;
   finally
      FreeAndNil(FInspect);
   end;
end;

procedure TExtract.ExtractParamFromObjectTo_Query(const AQuery: TQuery; const ATypeOperation: TTypeOperation);
var
   LProperty: TRttiProperty;
   LField: TField;
   LFieldParam: TFieldParam;
begin
   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LField := FInspect.GetAttribute_Field;

         if (LField <> nil) then
         begin
            LFieldParam := FInspect.GetAttribute_FieldParam;

            case ATypeOperation of
               toNew:      if (LField.PrimaryKey) and (LProperty.GetValue(FObject).AsInt64 > 0) or (not LField.PrimaryKey) then
                              ExtractParamTypeTo_Query(LProperty, LField.Name, AQuery);

               toEdit:     ExtractParamTypeTo_Query(LProperty, LField.Name, AQuery);

               toDelete,
               toSelect:   if (LField.PrimaryKey) or (LFieldParam <> nil) then
                              ExtractParamTypeTo_Query(LProperty, LField.Name, AQuery);

               toList:     if (LFieldParam <> nil) then
                              ExtractParamTypeTo_Query(LProperty, LField.Name, AQuery);
            end;
         end;
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

procedure TExtract.ExtractParamTypeTo_Query(const ARttiProperty: TRttiProperty; const AFieldName: UnicodeString; const AQuery: TQuery);
var
   LExtractParam: TExtractParamToQuery;
begin
   LExtractParam := TExtractParamToQuery.Create(FObject, ARttiProperty, AFieldName, AQuery);
   try
      LExtractParam.Extract;
   finally
      FreeAndNil(LExtractParam);
   end;
end;

function TExtract.ExtractDataBase_ForeignKeys: TSystemList;
var
   LProperty: TRttiProperty;
   LField: TField;
   LForeignKey: TFieldForeignKey;
   LInstance: TDataBaseForeignKey;
begin
   Result := TSystemList.Create;

   if (TableAttribute = nil) then
      Exit(Result);

   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LField := FInspect.GetAttribute_Field;

         if (LField <> nil) then
         begin
            LForeignKey := FInspect.GetAttribute_ForeignKey;

            if (LForeignKey <> nil) then
            begin
               LInstance := TDataBaseForeignKey.Create;
               LInstance.FieldName := LField.Name;
               LInstance.TableName := TableAttribute.Name;
               LInstance.FieldNameReference := LForeignKey.FieldName;
               LInstance.TableNameReference := LForeignKey.TableName;

               Result.Add(LInstance);
            end;
         end;
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

function TExtract.ExtractDataBase_Indexs: TSystemList;
var
   LProperty: TRttiProperty;
   LField: TField;
   LIndex: TFieldIndex;
   LInstance: TDataBaseIndex;
begin
   Result := TSystemList.Create;

   if (TableAttribute = nil) then
      Exit(Result);

   for LProperty in FRttiType.GetProperties do
   begin
      FInspect := TInspectAttributes.Create(LProperty);
      try
         LField := FInspect.GetAttribute_Field;

         if (LField <> nil) then
         begin
            LIndex := FInspect.GetAttribute_Index;

            if (LIndex <> nil) then
            begin
               LInstance := TDataBaseIndex.Create;
               LInstance.FieldName := LField.Name;
               LInstance.TableName := TableAttribute.Name;

               Result.Add(LInstance);
            end;
         end;
      finally
         FreeAndNil(FInspect);
      end;
   end;
end;

function TExtract.ExtractDataBaseRecord: TDataBaseRecord;
begin
   Result := nil;

   if (TableAttribute <> nil) then
   begin
      Result := TDataBaseRecord.Create;
      Result.TableName := TableAttribute.Name;
      Result.Records := ExtractDataBase_RecordItems;
      Result.HasList := Extract_HasList;
      Result.HasObject := Extract_HasObject;
      Result.OwnerType := Extract_OwnerType;
      Result.AccessControl := Extract_AcessControl;
   end;
end;

function TExtract.GetTableAttribute: TTable;
var
   LInspect: TInspectAttributes;
begin
   if (not Assigned(FTableAttribute)) then
   begin
      LInspect := TInspectAttributes.Create(FObject.ClassType);
      try
         FTableAttribute := LInspect.GetAttribute_Table;
      finally
         FreeAndNil(LInspect);
      end;
   end;

   Result := FTableAttribute;
end;

procedure TExtract.SetTableAttribute(const Value: TTable);
begin
   FTableAttribute := Value;
end;

{ TExtractDataBaseField }

constructor TExtractDataBaseField.Create(const AProperty: TRttiProperty; const ADataBaseField: TDataBaseField);
begin
   FProperty := AProperty;
   FDataBaseField := ADataBaseField;
   FInspect := TInspectAttributes.Create(AProperty);
   inherited Create;
end;

destructor TExtractDataBaseField.Destroy;
begin
   FreeAndNil(FInspect);
   inherited Destroy;
end;

procedure TExtractDataBaseField.Extract;
begin
   FieldPropertyCurrency;
   FieldPropertyString;
   FieldPropertyInteger;
   FieldPropertyInt64;
   FieldPropertySmallInt;
   FieldPropertyShortInt;
   FieldPropertyBytea;
   FieldPropertyDate;
   FieldPropertyDateTime;
   FieldPropertyTime;
   FieldPropertyBoolean;
end;

procedure TExtractDataBaseField.FieldPropertyBoolean;
var
   LAttribute: TFieldBoolean;
begin
   LAttribute := FInspect.GetAttribute_Boolean;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'boolean';
end;

procedure TExtractDataBaseField.FieldPropertyBytea;
var
   LAttribute: TFieldBytea;
begin
   LAttribute := FInspect.GetAttribute_Bytea;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'bytea';
end;

procedure TExtractDataBaseField.FieldPropertyCurrency;
var
   LAttribute: TFieldCurrency;
begin
   LAttribute := FInspect.GetAttribute_Currency;

   if (LAttribute <> nil) then
   begin
      FDataBaseField.Length := LAttribute.Size;
      FDataBaseField.Decimals := LAttribute.Decimals;
      FDataBaseField.TypeText := 'numeric';
   end;
end;

procedure TExtractDataBaseField.FieldPropertyDate;
var
   LAttribute: TFieldDate;
begin
   LAttribute := FInspect.GetAttribute_Date;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'date';
end;

procedure TExtractDataBaseField.FieldPropertyDateTime;
var
   LAttribute: TFieldDateTime;
begin
   LAttribute := FInspect.GetAttribute_DateTime;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'timestamp without time zone';
end;

procedure TExtractDataBaseField.FieldPropertyInt64;
var
   LAttribute: TFieldInt64;
begin
   LAttribute := FInspect.GetAttribute_Int64;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'bigint';
end;

procedure TExtractDataBaseField.FieldPropertyInteger;
var
   LAttribute: TFieldInteger;
begin
   LAttribute := FInspect.GetAttribute_Integer;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'integer';
end;

procedure TExtractDataBaseField.FieldPropertyShortInt;
var
   LAttribute: TFieldShortInt;
begin
   LAttribute := FInspect.GetAttribute_ShortInt;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'smallint';
end;

procedure TExtractDataBaseField.FieldPropertySmallInt;
var
   LAttribute: TFieldSmallInt;
begin
   LAttribute := FInspect.GetAttribute_SmallInt;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'smallint';
end;

procedure TExtractDataBaseField.FieldPropertyString;
var
   LAttribute: TFieldString;
begin
   LAttribute := FInspect.GetAttribute_String;

   if (LAttribute <> nil) then
   begin
      FDataBaseField.Length := LAttribute.Size;
      FDataBaseField.TypeText := 'character varying';
   end;
end;

procedure TExtractDataBaseField.FieldPropertyTime;
var
   LAttribute: TFieldTime;
begin
   LAttribute := FInspect.GetAttribute_Time;

   if (LAttribute <> nil) then
      FDataBaseField.TypeText := 'time';
end;

{ TExtractFieldToQuery }

procedure TExtractFieldToQuery.Extract;
begin
   ExtractField_Int64;
   ExtractField_Integer;
   ExtractField_SmallInt;
   ExtractField_ShortInt;
   ExtractField_Currency;
   ExtractField_String;
   ExtractField_Date;
   ExtractField_DateTime;
   ExtractField_Time;
   ExtractField_Boolean;
   ExtractField_Bytea;
end;

procedure TExtractFieldToQuery.ExtractField_Boolean;
var
   LAttribute: TFieldBoolean;
begin
   LAttribute := FInspect.GetAttribute_Boolean;

   if (LAttribute <> nil) then
      FProperty.SetValue(FObject, Fquery.FieldToBool(FFieldName));
end;

procedure TExtractFieldToQuery.ExtractField_Bytea;
var
   LAttribute: TFieldBytea;
   LValue: TBlobField;
   LMemoryStream: TMemoryStream;
begin
   LAttribute := FInspect.GetAttribute_Bytea;

   if (LAttribute <> nil) then
   begin
      LValue := FQuery.FieldToBlob(FFieldName);

      if (LValue <> nil) and (LValue.BlobSize > 0) then
      begin
         LMemoryStream := TMemoryStream.Create;
         FQuery.FieldToBlob(FFieldName).SaveToStream(LMemoryStream);
         FProperty.SetValue(FObject, LMemoryStream);
      end;
   end;
end;

procedure TExtractFieldToQuery.ExtractField_Currency;
var
   LAttribute: TFieldCurrency;
begin
   LAttribute := FInspect.GetAttribute_Currency;

   if (LAttribute <> nil) then
      FProperty.SetValue(FObject, FQuery.FieldToCurr(FFieldName));
end;

procedure TExtractFieldToQuery.ExtractField_Date;
var
   LAttribute: TFieldDate;
begin
   LAttribute := FInspect.GetAttribute_Date;

   if (LAttribute <> nil) then
      FProperty.SetValue(FObject, FQuery.FieldToDate(FFieldName));
end;

procedure TExtractFieldToQuery.ExtractField_DateTime;
var
   LAttribute: TFieldDateTime;
begin
   LAttribute := FInspect.GetAttribute_DateTime;

   if (LAttribute <> nil) then
      FProperty.SetValue(FObject, FQuery.FieldToDateTime(FFieldName));
end;

procedure TExtractFieldToQuery.ExtractField_Int64;
var
   LAttribute: TFieldInt64;
   LValue: Int64;
begin
   LAttribute := FInspect.GetAttribute_Int64;

   if (LAttribute <> nil) then
   begin
      if FQuery.FieldFrom(FFieldName).IsNull then
         LValue := Low(Int64)
      else
         LValue := FQuery.FieldToInt64(FFieldName);

      FProperty.SetValue(FObject, LValue);
   end;
end;

procedure TExtractFieldToQuery.ExtractField_Integer;
var
   LAttribute: TFieldInteger;
   LValue: Integer;
begin
   LAttribute := FInspect.GetAttribute_Integer;

   if (LAttribute <> nil) then
   begin
      if FQuery.FieldFrom(FFieldName).IsNull then
         LValue := Low(Integer)
      else
         LValue := FQuery.FieldToInteger(FFieldName);

      FProperty.SetValue(FObject, LValue);
   end;
end;

procedure TExtractFieldToQuery.ExtractField_ShortInt;
var
   LAttribute: TFieldShortInt;
   LValue: ShortInt;
begin
   LAttribute := FInspect.GetAttribute_ShortInt;

   if (LAttribute <> nil) then
   begin
      if FQuery.FieldFrom(FFieldName).IsNull then
         LValue := Low(ShortInt)
      else
         LValue := FQuery.FieldToInteger(FFieldName);

      FProperty.SetValue(FObject, LValue);
   end;
end;

procedure TExtractFieldToQuery.ExtractField_SmallInt;
var
   LAttribute: TFieldSmallInt;
   LValue: SmallInt;
begin
   LAttribute := FInspect.GetAttribute_SmallInt;

   if (LAttribute <> nil) then
   begin
      if FQuery.FieldFrom(FFieldName).IsNull then
         LValue := Low(SmallInt)
      else
         LValue := FQuery.FieldToInteger(FFieldName);

      FProperty.SetValue(FObject, LValue);
   end;
end;

procedure TExtractFieldToQuery.ExtractField_String;
var
   LAttribute: TFieldString;
   LValue: UnicodeString;
begin
   LAttribute := FInspect.GetAttribute_String;

   if (LAttribute <> nil) then
   begin
      if LAttribute.Crypt then
         LValue := StrUtils.DeCryptString(FQuery.FieldToString(FFieldName), SKeyCryptString)
      else
         LValue := FQuery.FieldToString(FFieldName);

      FProperty.SetValue(FObject, LValue);
   end;
end;

procedure TExtractFieldToQuery.ExtractField_Time;
var
   LAttribute: TFieldTime;
begin
   LAttribute := FInspect.GetAttribute_Time;

   if (LAttribute <> nil) then
      FProperty.SetValue(FObject, FQuery.FieldToTime(FFieldName));
end;

{ TExtractParamToQuery }

procedure TExtractParamToQuery.Extract;
begin
   ExtractParam_Int64;
   ExtractParam_Integer;
   ExtractParam_SmallInt;
   ExtractParam_ShotInt;
   ExtractParam_Currency;
   ExtractParam_String;
   ExtractParam_Date;
   ExtractParam_DateTime;
   ExtractParam_Time;
   ExtractParam_Boolean;
   ExtractParam_Bytea;
end;

procedure TExtractParamToQuery.ExtractParam_Boolean;
var
   LAttribute: TFieldBoolean;
   LValue: Boolean;
begin
   LAttribute := FInspect.GetAttribute_Boolean;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsBoolean;
      FQuery.ParamValue(FFieldName, LValue);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_Bytea;
var
   LAttribute: TFieldBytea;
   LValue: TMemoryStream;
begin
   LAttribute := FInspect.GetAttribute_Bytea;

   if (LAttribute <> nil) then
   begin
      LValue := TMemoryStream(FProperty.GetValue(FObject).AsObject);

      if (LValue = nil) then
      begin
         FQuery.ParamClear(FFieldName, ftBlob);
         Exit;
      end;

      FQuery.ParamFrom(FFieldName).DataType := ftStream;
      FQuery.ParamFrom(FFieldName).LoadFromStream(LValue, ftGraphic);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_Currency;
var
   LAttribute: TFieldCurrency;
   LValue: Currency;
begin
   LAttribute := FInspect.GetAttribute_Currency;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsCurrency;

      if InRange(LValue, LAttribute.MinValue, LAttribute.MaxValue) then
         FQuery.ParamValue(FFieldName, LValue)
      else
         ExceptionRangeValueProperty(LAttribute.MinValue.ToString, LAttribute.MaxValue.ToString, CurrToStr(LValue), FProperty.Name);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_Date;
var
   LAttribute: TFieldDate;
   LValue: TDate;
begin
   LAttribute := FInspect.GetAttribute_Date;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsExtended;
      FQuery.ParamValue(FFieldName, LValue);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_DateTime;
var
   LAttribute: TFieldDateTime;
   LValue: TDateTime;
begin
   LAttribute := FInspect.GetAttribute_DateTime;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsExtended;
      FQuery.ParamValue(FFieldName, LValue);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_Int64;
var
   LAttribute: TFieldInt64;
   LValue: Int64;
begin
   LAttribute := FInspect.GetAttribute_Int64;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsInt64;

      if InRange(LValue, LAttribute.MinValue, LAttribute.MaxValue) then
         FQuery.ParamValue(FFieldName, LValue)
      else
      if LValue = Low(Int64) then
         FQuery.ParamClear(FFieldName, ftLargeint)
      else
         ExceptionRangeValueProperty(LAttribute.MinValue.ToString, LAttribute.MaxValue.ToString, LValue.ToString, FFieldName);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_Integer;
var
   LAttribute: TFieldInteger;
   LValue: Integer;
begin
   LAttribute := FInspect.GetAttribute_Integer;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsInteger;

      if InRange(LValue, LAttribute.MinValue, LAttribute.MaxValue) then
         FQuery.ParamValue(FFieldName, LValue)
      else
      if LValue = Low(Integer) then
         FQuery.ParamClear(FFieldName, ftInteger)
      else
         ExceptionRangeValueProperty(LAttribute.MinValue.ToString, LAttribute.MaxValue.ToString, LValue.ToString, FFieldName);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_ShotInt;
var
   LAttribute: TFieldShortInt;
   LValue: ShortInt;
begin
   LAttribute := FInspect.GetAttribute_ShortInt;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsInteger;

      if InRange(LValue, LAttribute.MinValue, LAttribute.MaxValue) then
         FQuery.ParamValue(FFieldName, LValue)
      else
      if LValue = Low(ShortInt) then
         FQuery.ParamClear(FFieldName, ftShortint)
      else
         ExceptionRangeValueProperty(LAttribute.MinValue.ToString, LAttribute.MaxValue.ToString, LValue.ToString, FFieldName);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_SmallInt;
var
   LAttribute: TFieldSmallInt;
   LValue: SmallInt;
begin
   LAttribute := FInspect.GetAttribute_SmallInt;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsInteger;

      if InRange(LValue, LAttribute.MinValue, LAttribute.MaxValue) then
         FQuery.ParamValue(FFieldName, LValue)
      else
      if LValue = Low(SmallInt) then
         FQuery.ParamClear(FFieldName, ftSmallInt)
      else
         ExceptionRangeValueProperty(LAttribute.MinValue.ToString, LAttribute.MaxValue.ToString, LValue.ToString, FFieldName);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_String;
var
   LAttribute: TFieldString;
   LValue: UnicodeString;
begin
   LAttribute := FInspect.GetAttribute_String;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsString;

      if LAttribute.Crypt then
         LValue := StrUtils.EnCryptString(LValue, SKeyCryptString);

      if InRange(LValue.Length, 0, LAttribute.Size) then
         FQuery.ParamValue(FFieldName, LValue)
      else
         ExceptionRangeValueProperty('0', LAttribute.Size.ToString, LValue.Length.ToString, FFieldName);
   end;
end;

procedure TExtractParamToQuery.ExtractParam_Time;
var
   LAttribute: TFieldTime;
   LValue: TTime;
begin
   LAttribute := FInspect.GetAttribute_Time;

   if (LAttribute <> nil) then
   begin
      LValue := FProperty.GetValue(FObject).AsExtended;

      FQuery.ParamValue(FFieldName, LValue);
   end;
end;

{ TExtractCommon }

constructor TExtractCommon.Create(const AObject: TObject; const ARttiProperty: TRttiProperty; const AFieldName: UnicodeString; const AQuery: TQuery);
begin
   FObject := AObject;
   FProperty := ARttiProperty;
   FFieldName := AFieldName;
   FQuery := AQuery;
   FInspect := TInspectAttributes.Create(FProperty);
   inherited Create;
end;

procedure TExtractCommon.ExceptionRangeValueProperty(const AMinValue, AMaxValue, AActualValue, APropertyName: UnicodeString);
begin
   raise Exception.CreateFmt('Valor da propriedade %s inválido! Valores aceitos: %s até %s' + sLineBreak + 'Valor atual: %s', [APropertyName, AMinValue, AActualValue, AMaxValue]);
end;

end.
