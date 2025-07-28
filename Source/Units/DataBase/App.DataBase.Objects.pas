unit App.DataBase.Objects;

interface

uses
   System.SysUtils, System.Rtti, App.Common.Types, App.System.List;

type

   TDataBaseField = class
   strict private
      FLength: Integer;
      FName: UnicodeString;
      FPrimaryKey: Boolean;
      FNotNull: Boolean;
      FTypeText: UnicodeString;
      FDecimals: ShortInt;
      procedure SetDecimals(const Value: ShortInt);
      procedure SetLength(const Value: Integer);
      procedure SetName(const Value: UnicodeString);
      procedure SetNotNull(const Value: Boolean);
      procedure SetPrimaryKey(const Value: Boolean);
      procedure SetTypeText(const Value: UnicodeString);
   public
      property Name: UnicodeString read FName write SetName;
      property TypeText: UnicodeString read FTypeText write SetTypeText;
      property Length: Integer read FLength write SetLength;
      property Decimals: ShortInt read FDecimals write SetDecimals;
      property PrimaryKey: Boolean read FPrimaryKey write SetPrimaryKey;
      property NotNull: Boolean read FNotNull write SetNotNull;
   end;

   TDataBaseForeignKey = class
   strict private
      FTableName: UnicodeString;
      FFieldNameReference: UnicodeString;
      FFieldName: UnicodeString;
      FTableNameReference: UnicodeString;
      procedure SetFieldName(const Value: UnicodeString);
      procedure SetFieldNameReference(const Value: UnicodeString);
      procedure SetTableName(const Value: UnicodeString);
      procedure SetTableNameReference(const Value: UnicodeString);
   public
      property FieldName: UnicodeString read FFieldName write SetFieldName;
      property TableName: UnicodeString read FTableName write SetTableName;
      property FieldNameReference: UnicodeString read FFieldNameReference write SetFieldNameReference;
      property TableNameReference: UnicodeString read FTableNameReference write SetTableNameReference;
   end;

   TDataBaseIndex = class
   strict private
      FTableName: UnicodeString;
      FFieldName: UnicodeString;
      procedure SetFieldName(const Value: UnicodeString);
      procedure SetTableName(const Value: UnicodeString);
   public
      property FieldName: UnicodeString read FFieldName write SetFieldName;
      property TableName: UnicodeString read FTableName write SetTableName;
   end;

   TDataBaseTable = class
   strict private
      FName: UnicodeString;
      FFields: TSystemList;
      FComment: UnicodeString;
      FIndexs: TSystemList;
      FForeignKeys: TSystemList;
      procedure SetComment(const Value: UnicodeString);
      procedure SetFields(const Value: TSystemList);
      procedure SetForeignKeys(const Value: TSystemList);
      procedure SetIndexs(const Value: TSystemList);
      procedure SetName(const Value: UnicodeString);
   public
      property Name: UnicodeString read FName write SetName;
      property Comment: UnicodeString read FComment write SetComment;
      property Fields: TSystemList read FFields write SetFields;
      property Indexs: TSystemList read FIndexs write SetIndexs;
      property ForeignKeys: TSystemList read FForeignKeys write SetForeignKeys;

      destructor Destroy; override;
   end;

   TDataBaseRecordItem = class
   strict private
      FName: UnicodeString;
      FPrimaryKey: Boolean;
      FIsList: Boolean;
      FIsObject: Boolean;
      FValue: TValue;
      FCanSaveHistoric: Boolean;
      FIsDateTime: Boolean;
      FIsParam: Boolean;
      procedure SetIsParam(const Value: Boolean);
      procedure SetIsDateTime(const Value: Boolean);
      procedure SetCanSaveHistoric(const Value: Boolean);
      procedure SetIsObject(const Value: Boolean);
      procedure SetIsList(const Value: Boolean);
      procedure SetName(const Value: UnicodeString);
      procedure SetPrimaryKey(const Value: Boolean);
      procedure SetValue(const Value: TValue);
   public
      property Name: UnicodeString read FName write SetName;
      property PrimaryKey: Boolean read FPrimaryKey write SetPrimaryKey;
      property IsList: Boolean read FIsList write SetIsList;
      property IsObject: Boolean read FIsObject write SetIsObject;
      property Value: TValue read FValue write SetValue;
      property CanSaveHistoric: Boolean read FCanSaveHistoric write SetCanSaveHistoric;
      property IsDateTime: Boolean read FIsDateTime write SetIsDateTime;
      property IsParam: Boolean read FIsParam write SetIsParam;
   end;

   TDataBaseRecord = class
   strict private
      FTableName: UnicodeString;
      FRecords: TSystemList;
      FHasList: Boolean;
      FHasObject: Boolean;
      FOwnerType: TOwnerType;
      FAccessControl: Boolean;
      procedure SetAccessControl(const Value: Boolean);
      procedure SetOwnerType(const Value: TOwnerType);
      procedure SetHasObject(const Value: Boolean);
      procedure SetHasList(const Value: Boolean);
      procedure SetRecords(const Value: TSystemList);
      procedure SetTableName(const Value: UnicodeString);
   public
      property TableName: UnicodeString read FTableName write SetTableName;
      property Records: TSystemList read FRecords write SetRecords;
      property HasList: Boolean read FHasList write SetHasList;
      property HasObject: Boolean read FHasObject write SetHasObject;
      property OwnerType: TOwnerType read FOwnerType write SetOwnerType;
      property AccessControl: Boolean read FAccessControl write SetAccessControl;

      destructor Destroy; override;
   end;

implementation

uses
   App.Common.Utils;

{ TDataBaseField }

procedure TDataBaseField.SetDecimals(const Value: ShortInt);
begin
   FDecimals := Value;
end;

procedure TDataBaseField.SetLength(const Value: Integer);
begin
   FLength := Value;
end;

procedure TDataBaseField.SetName(const Value: UnicodeString);
begin
   FName := Value;
end;

procedure TDataBaseField.SetNotNull(const Value: Boolean);
begin
   FNotNull := Value;
end;

procedure TDataBaseField.SetPrimaryKey(const Value: Boolean);
begin
   FPrimaryKey := Value;
end;

procedure TDataBaseField.SetTypeText(const Value: UnicodeString);
begin
   FTypeText := Value;
end;

{ TDataBaseForeignKey }

procedure TDataBaseForeignKey.SetFieldName(const Value: UnicodeString);
begin
   FFieldName := Value;
end;

procedure TDataBaseForeignKey.SetFieldNameReference(const Value: UnicodeString);
begin
   FFieldNameReference := Value;
end;

procedure TDataBaseForeignKey.SetTableName(const Value: UnicodeString);
begin
   FTableName := Value;
end;

procedure TDataBaseForeignKey.SetTableNameReference(const Value: UnicodeString);
begin
   FTableNameReference := Value;
end;

{ TDataBaseIndex }

procedure TDataBaseIndex.SetFieldName(const Value: UnicodeString);
begin
   FFieldName := Value;
end;

procedure TDataBaseIndex.SetTableName(const Value: UnicodeString);
begin
   FTableName := Value;
end;

{ TDataBaseTable }

destructor TDataBaseTable.Destroy;
begin
   ObjUtils.Release_(FFields);
   ObjUtils.Release_(FForeignKeys);
   ObjUtils.Release_(FIndexs);
   inherited Destroy;
end;

procedure TDataBaseTable.SetComment(const Value: UnicodeString);
begin
   FComment := Value;
end;

procedure TDataBaseTable.SetFields(const Value: TSystemList);
begin
   FFields := Value;
end;

procedure TDataBaseTable.SetForeignKeys(const Value: TSystemList);
begin
   FForeignKeys := Value;
end;

procedure TDataBaseTable.SetIndexs(const Value: TSystemList);
begin
   FIndexs := Value;
end;

procedure TDataBaseTable.SetName(const Value: UnicodeString);
begin
   FName := Value;
end;

{ TDataBaseRecord }

destructor TDataBaseRecord.Destroy;
begin
   ObjUtils.Release_(FRecords);
   inherited;
end;

procedure TDataBaseRecord.SetAccessControl(const Value: Boolean);
begin
   FAccessControl := Value;
end;

procedure TDataBaseRecord.SetHasList(const Value: Boolean);
begin
   FHasList := Value;
end;

procedure TDataBaseRecord.SetHasObject(const Value: Boolean);
begin
   FHasObject := Value;
end;

procedure TDataBaseRecord.SetOwnerType(const Value: TOwnerType);
begin
   FOwnerType := Value;
end;

procedure TDataBaseRecord.SetRecords(const Value: TSystemList);
begin
   FRecords := Value;
end;

procedure TDataBaseRecord.SetTableName(const Value: UnicodeString);
begin
   FTableName := Value;
end;

{ TDataBaseRecordItem }


procedure TDataBaseRecordItem.SetCanSaveHistoric(const Value: Boolean);
begin
   FCanSaveHistoric := Value;
end;

procedure TDataBaseRecordItem.SetIsList(const Value: Boolean);
begin
   FIsList := Value;
end;

procedure TDataBaseRecordItem.SetIsDateTime(const Value: Boolean);
begin
   FIsDateTime := Value;
end;

procedure TDataBaseRecordItem.SetIsObject(const Value: Boolean);
begin
   FIsObject := Value;
end;

procedure TDataBaseRecordItem.SetIsParam(const Value: Boolean);
begin
   FIsParam := Value;
end;

procedure TDataBaseRecordItem.SetName(const Value: UnicodeString);
begin
   FName := Value;
end;

procedure TDataBaseRecordItem.SetPrimaryKey(const Value: Boolean);
begin
   FPrimaryKey := Value;
end;

procedure TDataBaseRecordItem.SetValue(const Value: TValue);
begin
   FValue := Value;
end;

end.
