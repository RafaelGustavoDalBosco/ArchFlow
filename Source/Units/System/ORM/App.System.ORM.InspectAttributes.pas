{********************************************************}
{ © Dal Bosco Systems Ltda. Todos os direitos reservados.}
{********************************************************}
unit App.System.ORM.InspectAttributes;

interface

uses
   RTTI, App.System.ORM.CustomAttributes, System.Generics.Collections, System.SysUtils;

type

   TInspectAttributes = class
   strict protected
      FProperty: TRTTIProperty;
      FClass: TClass;
   strict private
      /// <summary>
      ///    Obtém o atributo específico da property
      /// </summary>
      /// <param name="AClass">
      ///    Classe do TCustomAttribute
      /// </param>
      function GetPropertyAttribute(const AClass: TClass): TCustomAttribute;

      /// <summary>
      ///    Obtém o atributo especifico da classe
      /// </summary>
      /// <param name="AClass">
      ///    Classe do TCustomAttribute
      /// </param>
      function GetClassAttribute(const AClass: TClass): TCustomAttribute;
   public
      /// <summary>
      ///    Return CustomAttribute = [TField]
      /// </summary>
      function GetAttribute_Field: TField;

      /// <summary>
      ///    Return CustomAttribute = [TFieldParam]
      /// </summary>
      function GetAttribute_FieldParam: TFieldParam;

      /// <summary>
      ///    Return CustomAttribute = [TFieldBound]
      /// </summary>
      function GetAttribute_FieldBound: TFieldBound;

      /// <summary>
      ///    Return CustomAttribute = [TFieldInteger]
      /// </summary>
      function GetAttribute_Integer: TFieldInteger;

      /// <summary>
      ///    Return CustomAttribute = [TFieldInt64]
      /// </summary>
      function GetAttribute_Int64: TFieldInt64;

      /// <summary>
      ///    Return CustomAttribute = [TFieldString]
      /// </summary>
      function GetAttribute_String: TFieldString;

      /// <summary>
      ///    Return CustomAttribute = [TFieldSmallInt]
      /// </summary>
      function GetAttribute_SmallInt: TFieldSmallInt;

      /// <summary>
      ///    Return CustomAttribute = [TFieldShortInt]
      /// </summary>
      function GetAttribute_ShortInt: TFieldShortInt;

      /// <summary>
      ///    Return CustomAttribute = [TFieldDate]
      /// </summary>
      function GetAttribute_Date: TFieldDate;

      /// <summary>
      ///    Return CustomAttribute = [TFieldDateTime]
      /// </summary>
      function GetAttribute_DateTime: TFieldDateTime;

      /// <summary>
      ///    Return CustomAttribute = [TFieldTime]
      /// </summary>
      function GetAttribute_Time: TFieldTime;

      /// <summary>
      ///    Return CustomAttribute = [TFieldCurrency]
      /// </summary>
      function GetAttribute_Currency: TFieldCurrency;

      /// <summary>
      ///    Return CustomAttribute = [TFieldList]
      /// </summary>
      function GetAttribute_List: TFieldList;

      /// <summary>
      ///    Return CustomAttribute = [TFieldBytea]
      /// </summary>
      function GetAttribute_Bytea: TFieldBytea;

      /// <summary>
      ///    Return CustomAttribute = [TFieldBoolean]
      /// </summary>
      function GetAttribute_Boolean: TFieldBoolean;

      /// <summary>
      ///    Return CustomAttribute = [TFieldObject]
      /// </summary>
      function GetAttribute_Object: TFieldObject;

      /// <summary>
      ///    Return CustomAttribute = [TFieldForeignKey]
      /// </summary>
      function GetAttribute_ForeignKey: TFieldForeignKey;

      /// <summary>
      ///    Return CustomAttribute = [TFieldIndex]
      /// </summary>
      function GetAttribute_Index: TFieldIndex;

      /// <summary>
      ///    Return CustomAttribute = [TTable]
      /// </summary>
      function GetAttribute_Table: TTable;

      /// <summary>
      ///    Return CustomAttribute = [TObjectProperties]
      /// </summary>
      function GetAttribute_Properties: TObjectProperties;

      /// <param name="AProperty">
      ///   Define a Property que será inspecionada
      /// </param>
      constructor Create(const AProperty: TRTTIProperty); overload;

      /// <param name="AClass">
      ///    Define a propriedade da Classe que será inspecionada
      /// </param>
      constructor Create(const AClass: TClass); overload;
   end;

implementation

{ TInspectAttributes }

constructor TInspectAttributes.Create(const AProperty: TRTTIProperty);
begin
   FProperty := AProperty;
   inherited Create;
end;

constructor TInspectAttributes.Create(const AClass: TClass);
begin
   FClass := AClass;
   inherited Create;
end;

function TInspectAttributes.GetAttribute_Boolean: TFieldBoolean;
begin
   Result := GetPropertyAttribute(TFieldBoolean) as TFieldBoolean;
end;

function TInspectAttributes.GetAttribute_Bytea: TFieldBytea;
begin
   Result := GetPropertyAttribute(TFieldBytea) as TFieldBytea;
end;

function TInspectAttributes.GetAttribute_Currency: TFieldCurrency;
begin
   Result := GetPropertyAttribute(TFieldCurrency) as TFieldCurrency;
end;

function TInspectAttributes.GetAttribute_Date: TFieldDate;
begin
   Result := GetPropertyAttribute(TFieldDate) as TFieldDate;
end;

function TInspectAttributes.GetAttribute_DateTime: TFieldDateTime;
begin
   Result := GetPropertyAttribute(TFieldDateTime) as TFieldDateTime;
end;

function TInspectAttributes.GetAttribute_Field: TField;
begin
   Result := GetPropertyAttribute(TField) as TField;
end;

function TInspectAttributes.GetAttribute_FieldBound: TFieldBound;
begin
   Result := GetPropertyAttribute(TFieldBound) as TFieldBound;
end;

function TInspectAttributes.GetAttribute_FieldParam: TFieldParam;
begin
   Result := GetPropertyAttribute(TFieldParam) as TFieldParam;
end;

function TInspectAttributes.GetAttribute_ForeignKey: TFieldForeignKey;
begin
   Result := GetPropertyAttribute(TFieldForeignKey) as TFieldForeignKey;
end;

function TInspectAttributes.GetAttribute_Index: TFieldIndex;
begin
   Result := GetPropertyAttribute(TFieldIndex) as TFieldIndex;
end;

function TInspectAttributes.GetAttribute_Int64: TFieldInt64;
begin
   Result := GetPropertyAttribute(TFieldInt64) as TFieldInt64;
end;

function TInspectAttributes.GetAttribute_Integer: TFieldInteger;
begin
   Result := GetPropertyAttribute(TFieldInteger) as TFieldInteger;
end;

function TInspectAttributes.GetAttribute_List: TFieldList;
begin
   Result := GetPropertyAttribute(TFieldList) as TFieldList;
end;

function TInspectAttributes.GetAttribute_Object: TFieldObject;
begin
   Result := GetPropertyAttribute(TFieldObject) as TFieldObject;
end;

function TInspectAttributes.GetAttribute_Properties: TObjectProperties;
begin
   Result := GetClassAttribute(TObjectProperties) as TObjectProperties;
end;

function TInspectAttributes.GetAttribute_ShortInt: TFieldShortInt;
begin
   Result := GetPropertyAttribute(TFieldShortInt) as TFieldShortInt;
end;

function TInspectAttributes.GetAttribute_SmallInt: TFieldSmallInt;
begin
   Result := GetPropertyAttribute(TFieldSmallInt) as TFieldSmallInt;
end;

function TInspectAttributes.GetAttribute_String: TFieldString;
begin
   Result := GetPropertyAttribute(TFieldString) as TFieldString;
end;

function TInspectAttributes.GetAttribute_Table: TTable;
begin
   Result := GetClassAttribute(TTable) as TTable;
end;

function TInspectAttributes.GetAttribute_Time: TFieldTime;
begin
   Result := GetPropertyAttribute(TFieldTime) as TFieldTime;
end;

function TInspectAttributes.GetClassAttribute(const AClass: TClass): TCustomAttribute;
var
   LAttribute: TCustomAttribute;
   LContext: TRttiContext;
   LType: TRttiType;
begin
   Result := nil;

   LContext := TRttiContext.Create;
   try
      LType := LContext.GetType(FClass);

      for LAttribute in LType.GetAttributes do
      begin
         if (LAttribute.ClassType = AClass) then
            Exit(LAttribute);
      end;
   finally
      LContext.Free;
   end;
end;

function TInspectAttributes.GetPropertyAttribute(const AClass: TClass): TCustomAttribute;
var
   LAttribute: TCustomAttribute;
begin
   Result := nil;

   for LAttribute in FProperty.GetAttributes do
   begin
      if (LAttribute.ClassType = AClass) then
         Exit(LAttribute);
   end;
end;

end.
