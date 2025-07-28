unit App.System.ORM.CustomAttributes;

interface

uses
   System.Classes, System.Math, App.System.Consts, App.Common.Types;

type

   TTable = class(TCustomAttribute)
   strict private
      FName: UnicodeString;
      FComment: UnicodeString;
      FSchema: UnicodeString;
      procedure SetComment(const Value: UnicodeString);
      procedure SetName(const Value: UnicodeString);
      procedure SetSchema(const Value: UnicodeString);
   public
      property Name: UnicodeString read FName write SetName;
      property Schema: UnicodeString read FSchema write SetSchema;
      property Comment: UnicodeString read FComment write SetComment;

      /// <param name="AName">
      ///    Nome da tabela
      /// </param>
      /// <param name="AComment">
      ///    Comentário descritivo sobre a tabela
      /// </param>
      /// <param name="ASchema">
      ///    Schema do PG, por padrão será o "public"
      /// </param>
      constructor Create(const AName: UnicodeString; const AComment: UnicodeString; const ASchema: UnicodeString = 'public');
   end;

   TField = class(TCustomAttribute)
   strict private
      FName: UnicodeString;
      FPrimaryKey: Boolean;
      FRequired: Boolean;
      procedure SetName(const Value: UnicodeString);
      procedure SetPrimaryKey(const Value: Boolean);
      procedure SetRequired(const Value: Boolean);
   public
      property Name: UnicodeString read FName write SetName;
      property Required: Boolean read FRequired write SetRequired;
      property PrimaryKey: Boolean read FPrimaryKey write SetPrimaryKey;

      /// <param name="AName">
      ///    Nome do campo no banco de dados
      /// </param>
      /// <param name="ARequired">
      ///    Define se o campo é de preenchimento obrigatório ou não
      /// </param>
      /// <param name="APrimaryKey">
      ///    Define se o campo será PK da tabela ou não
      /// </param>
      constructor Create(const AName: UnicodeString; const ARequired: Boolean = False; const APrimaryKey: Boolean = False);
   end;

   TFieldParam = class(TCustomAttribute)
   end;

   TFieldBound = class(TCustomAttribute)
   end;

   TObjectProperties = class(TCustomAttribute)
   strict private
      FAccessControl: Boolean;
      FOwnerType: TOwnerType;
      procedure SetAccessControl(const Value: Boolean);
      procedure SetOwnerType(const Value: TOwnerType);
   public
      property AccessControl: Boolean read FAccessControl write SetAccessControl;
      property OwnerType: TOwnerType read FOwnerType write SetOwnerType;

      /// <param name="AAcessControl">
      ///   Define se o objeto fará parte do controle de acesso
      /// </param>
      /// <param name="AOwnerType">
      ///    Caso este objeto, seja dono de objetos child/root, isto define qual é o tipo dele
      /// </param>
      constructor Create(const AAcessControl: Boolean; const AOwnerType: TOwnerType = totNone);
   end;

   TFieldObject = class(TCustomAttribute)
   strict private
      FClassOf: TClass;
      procedure SetClassOf(const Value: TClass);
   public
      property ClassOf: TClass read FClassOf write SetClassOf;

      /// <param name="AClassOf">
      ///    Classe do objeto que será vinculado
      /// </param>
      constructor Create(const AClassOf: TClass);
   end;

   TFieldString = class(TCustomAttribute)
   strict private
      FCrypt: Boolean;
      FSize: SmallInt;
      procedure SetCrypt(const Value: Boolean);
      procedure SetSize(const Value: SmallInt);
   public
      property Size: SmallInt read FSize write SetSize;
      property Crypt: Boolean read FCrypt write SetCrypt;

      /// <param name="ASize">
      ///    Tamanho do campo no banco de dados
      /// </param>
      /// <param name="ACrypt">
      ///    Define se este campo será criptografado ou não
      /// </param>
      constructor Create(const ASize: SmallInt; const ACrypt: Boolean = False);
   end;

   TFieldBoolean = class(TCustomAttribute)
   end;

   TFieldCurrency = class(TCustomAttribute)
   strict private
      FMinValue: Currency;
      FDecimals: ShortInt;
      FMaxValue: Currency;
      FSize: SmallInt;
      procedure SetDecimals(const Value: ShortInt);
      procedure SetMaxValue(const Value: Currency);
      procedure SetMinValue(const Value: Currency);
      procedure SetSize(const Value: SmallInt);
   public
      property Size: SmallInt read FSize write SetSize;
      property Decimals: ShortInt read FDecimals write SetDecimals;
      property MinValue: Currency read FMinValue write SetMinValue;
      property MaxValue: Currency read FMaxValue write SetMaxValue;

      /// <param name="ASize">
      ///    Tamanho do campo
      /// </param>
      /// <param name="ADecimals">
      ///    Quantidade de decimais
      /// </param>
      /// <param name="AMinValue">
      ///    Menor valor possível
      /// </param>
      /// <param name="AMaxValue">
      ///    Maior valor possível
      /// </param>
      constructor Create(const ASize: SmallInt; const ADecimals: ShortInt; const AMinValue: Currency = MinComp; const AMaxValue: Currency = MaxComp);
   end;

   TFieldInteger = class(TCustomAttribute)
   strict private
      FMinValue: Integer;
      FMaxValue: Integer;
      procedure SetMaxValue(const Value: Integer);
      procedure SetMinValue(const Value: Integer);
   public
      property MinValue: Integer read FMinValue write SetMinValue;
      property MaxValue: Integer read FMaxValue write SetMaxValue;

      /// <param name="AMinValue">
      ///    Menor valor possível
      /// </param>
      /// <param name="AMaxValue">
      ///    Maior valor possível
      /// </param>
      constructor Create(const AMinValue: Integer = Low(Integer); const AMaxValue: Integer = High(Integer));
   end;

   TFieldInt64 = class(TCustomAttribute)
   strict private
      FMinValue: Int64;
      FMaxValue: Int64;
      procedure SetMaxValue(const Value: Int64);
      procedure SetMinValue(const Value: Int64);
   public
      property MinValue: Int64 read FMinValue write SetMinValue;
      property MaxValue: Int64 read FMaxValue write SetMaxValue;

      /// <param name="AMinValue">
      ///    Menor valor possível
      /// </param>
      /// <param name="AMaxValue">
      ///    Maior valor possível
      /// </param>
      constructor Create(const AMinValue: Int64 = Low(Int64); const AMaxValue: Int64 = High(Int64));
   end;

   TFieldSmallInt = class(TCustomAttribute)
   strict private
      FMinValue: SmallInt;
      FMaxValue: SmallInt;
      procedure SetMaxValue(const Value: SmallInt);
      procedure SetMinValue(const Value: SmallInt);
   public
      property MinValue: SmallInt read FMinValue write SetMinValue;
      property MaxValue: SmallInt read FMaxValue write SetMaxValue;

      /// <param name="AMinValue">
      ///    Menor valor possível
      /// </param>
      /// <param name="AMaxValue">
      ///    Maior valor possível
      /// </param>
      constructor Create(const AMinValue: SmallInt = Low(SmallInt); const AMaxvalue: SmallInt = High(SmallInt));
   end;

   TFieldShortInt = class(TCustomAttribute)
  private
      FMinValue: ShortInt;
      FMaxValue: ShortInt;
      procedure SetMaxValue(const Value: ShortInt);
      procedure SetMinValue(const Value: ShortInt);
   public
      property MinValue: ShortInt read FMinValue write SetMinValue;
      property MaxValue: ShortInt read FMaxValue write SetMaxValue;

      /// <param name="AMinValue">
      ///    Menor valor possível
      /// </param>
      /// <param name="AMaxValue">
      ///    Maior valor possível
      /// </param>
      constructor Create(const AMinValue: ShortInt = Low(ShortInt); const AMaxValue: ShortInt = High(ShortInt));
   end;

   TFieldDate = class(TCustomAttribute)
   strict private
      FClearIfNull: Boolean;
      procedure SetClearIfNull(const Value: Boolean);
   public
      property ClearIfNull: Boolean read FClearIfNull write SetClearIfNull;

      /// <param name="AClearIfNull">
      ///    Se caso esteja nulo, vai limpar por regra
      /// </param>
      constructor Create(const AClearIfNull: Boolean = True);
   end;

   TFieldDateTime = class(TCustomAttribute)
   strict private
      FClearIfNull: Boolean;
      procedure SetClearIfNull(const Value: Boolean);
   public
      property ClearIfNull: Boolean read FClearIfNull write SetClearIfNull;

      /// <param name="AClearIfNull">
      ///    Se caso esteja nulo, vai limpar por regra
      /// </param>
      constructor Create(const AClearIfNull: Boolean = True);
   end;

   TFieldTime = class(TCustomAttribute)
   strict private
      FClearIfNull: Boolean;
      procedure SetClearIfNull(const Value: Boolean);
   public
      property ClearIfNull: Boolean read FClearIfNull write SetClearIfNull;

      /// <param name="AClearIfNull">
      ///    Se caso esteja nulo, vai limpar por regra
      /// </param>
      constructor Create(const AClearIfNull: Boolean = True);
   end;

   TFieldIndex = class(TCustomAttribute)
   end;

   TFieldBytea = class(TCustomAttribute)
   end;

   TFieldList = class(TCustomAttribute)
   strict private
      FClassOf: TClass;
      procedure SetClassOf(const Value: TClass);
   public
      property ClassOf: TClass read FClassOf write SetClassOf;

      /// <param name="AClassOf">
      ///    Define a Classe que será a Lista de Objetos TObjectList<TObject>
      /// </param>
      constructor Create(const AClassOf: TClass);
   end;

   TFieldForeignKey = class(TCustomAttribute)
   strict private
      FTableName: UnicodeString;
      FFieldName: UnicodeString;
      procedure SetFieldName(const Value: UnicodeString);
      procedure SetTableName(const Value: UnicodeString);
   public
      property FieldName: UnicodeString read FFieldName write SetFieldName;
      property TableName: UnicodeString read FTableName write SetTableName;

      constructor Create(const AFieldName, ATableName: UnicodeString);
   end;

implementation

{ TTable }

constructor TTable.Create(const AName, AComment, ASchema: UnicodeString);
begin
   SetName(AName);
   SetComment(AComment);
   SetSchema(ASchema);
   inherited Create;
end;

procedure TTable.SetComment(const Value: UnicodeString);
begin
   FComment := Value;
end;

procedure TTable.SetName(const Value: UnicodeString);
begin
   FName := Value;
end;

procedure TTable.SetSchema(const Value: UnicodeString);
begin
   FSchema := Value;
end;

{ TField }

constructor TField.Create(const AName: UnicodeString; const ARequired, APrimaryKey: Boolean);
begin
   SetName(AName);
   SetRequired(ARequired);
   SetPrimaryKey(APrimaryKey);
   inherited Create;
end;

procedure TField.SetName(const Value: UnicodeString);
begin
   FName := Value;
end;

procedure TField.SetPrimaryKey(const Value: Boolean);
begin
   FPrimaryKey := Value;
end;

procedure TField.SetRequired(const Value: Boolean);
begin
   FRequired := Value;
end;

{ TFieldString }

constructor TFieldString.Create(const ASize: SmallInt; const ACrypt: Boolean);
begin
   SetSize(ASize);
   SetCrypt(ACrypt);
   inherited Create;
end;

procedure TFieldString.SetCrypt(const Value: Boolean);
begin
   FCrypt := Value;
end;

procedure TFieldString.SetSize(const Value: SmallInt);
begin
   FSize := Value;
end;

{ TFieldCurrency }

constructor TFieldCurrency.Create(const ASize: SmallInt; const ADecimals: ShortInt; const AMinValue, AMaxValue: Currency);
begin
   SetSize(ASize);
   SetDecimals(ADecimals);
   SetMinValue(AMinValue);
   SetMaxValue(AMaxValue);
   inherited Create;
end;

procedure TFieldCurrency.SetDecimals(const Value: ShortInt);
begin
   FDecimals := Value;
end;

procedure TFieldCurrency.SetMaxValue(const Value: Currency);
begin
   FMaxValue := Value;
end;

procedure TFieldCurrency.SetMinValue(const Value: Currency);
begin
   FMinValue := Value;
end;

procedure TFieldCurrency.SetSize(const Value: SmallInt);
begin
   FSize := Value;
end;

{ TFieldInteger }

constructor TFieldInteger.Create(const AMinValue, AMaxValue: Integer);
begin
   SetMinValue(AMinValue);
   SetMaxValue(AMaxValue);
   inherited Create;
end;

procedure TFieldInteger.SetMaxValue(const Value: Integer);
begin
   FMaxValue := Value;
end;

procedure TFieldInteger.SetMinValue(const Value: Integer);
begin
   FMinValue := Value;
end;

{ TFieldInt64 }

constructor TFieldInt64.Create(const AMinValue, AMaxValue: Int64);
begin
   SetMinValue(AMinValue);
   SetMaxValue(AMaxValue);
   inherited Create;
end;

procedure TFieldInt64.SetMaxValue(const Value: Int64);
begin
   FMaxValue := Value;
end;

procedure TFieldInt64.SetMinValue(const Value: Int64);
begin
   FMinValue := Value;
end;

{ TFieldSmallInt }

constructor TFieldSmallInt.Create(const AMinValue, AMaxvalue: SmallInt);
begin
   SetMinValue(AMinValue);
   SetMaxValue(AMaxvalue);
   inherited Create;
end;

procedure TFieldSmallInt.SetMaxValue(const Value: SmallInt);
begin
   FMaxValue := Value;
end;

procedure TFieldSmallInt.SetMinValue(const Value: SmallInt);
begin
   FMinValue := Value;
end;

{ TFieldTime }

constructor TFieldTime.Create(const AClearIfNull: Boolean);
begin
   SetClearIfNull(AClearIfNull);
   inherited Create;
end;

procedure TFieldTime.SetClearIfNull(const Value: Boolean);
begin
   FClearIfNull := Value;
end;

{ TFieldDateTime }

constructor TFieldDateTime.Create(const AClearIfNull: Boolean);
begin
   SetClearIfNull(AClearIfNull);
   inherited Create;
end;

procedure TFieldDateTime.SetClearIfNull(const Value: Boolean);
begin
   FClearIfNull := Value;
end;

{ TFieldDate }

constructor TFieldDate.Create(const AClearIfNull: Boolean);
begin
   SetClearIfNull(AClearIfNull);
   inherited Create;
end;

procedure TFieldDate.SetClearIfNull(const Value: Boolean);
begin
   FClearIfNull := Value;
end;

{ TFieldList }

constructor TFieldList.Create(const AClassOf: TClass);
begin
   SetClassOf(AClassOf);
   inherited Create;
end;

procedure TFieldList.SetClassOf(const Value: TClass);
begin
   FClassOf := Value;
end;

{ TFieldForeignKey }

constructor TFieldForeignKey.Create(const AFieldName, ATableName: UnicodeString);
begin
   SetFieldName(AFieldName);
   SetTableName(ATableName);
   inherited Create;
end;

procedure TFieldForeignKey.SetFieldName(const Value: UnicodeString);
begin
   FFieldName := Value;
end;

procedure TFieldForeignKey.SetTableName(const Value: UnicodeString);
begin
   FTableName := Value;
end;

{ TFieldShortInt }

constructor TFieldShortInt.Create(const AMinValue, AMaxValue: ShortInt);
begin
   SetMinValue(AMinValue);
   SetMaxValue(AMaxValue);
   inherited Create;
end;

procedure TFieldShortInt.SetMaxValue(const Value: ShortInt);
begin
   FMaxValue := Value;
end;

procedure TFieldShortInt.SetMinValue(const Value: ShortInt);
begin
   FMinValue := Value;
end;

{ TFieldObject }

constructor TFieldObject.Create(const AClassOf: TClass);
begin
   SetClassOf(AClassOf);
   inherited Create;
end;

procedure TFieldObject.SetClassOf(const Value: TClass);
begin
   FClassOf := Value;
end;

{ TObjectProperties }

constructor TObjectProperties.Create(const AAcessControl: Boolean; const AOwnerType: TOwnerType);
begin
   SetAccessControl(AccessControl);
   SetOwnerType(AOwnerType);
   inherited Create;
end;

procedure TObjectProperties.SetAccessControl(const Value: Boolean);
begin
   FAccessControl := Value;
end;

procedure TObjectProperties.SetOwnerType(const Value: TOwnerType);
begin
   FOwnerType := Value;
end;

end.
