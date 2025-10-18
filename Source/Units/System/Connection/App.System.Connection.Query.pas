unit App.System.Connection.Query;

interface

uses

{$REGION '| FIREDAC |'}
   FireDAC.Comp.Client,
   FireDAC.Stan.Param,
   FireDAC.Stan.Error,
{$ENDREGION}

{$REGION '| VCL |'}
   Vcl.Dialogs,
{$ENDREGION}

{$REGION '| NATIVE |'}
   System.SysUtils,
   System.Classes,
   Data.DB,
{$ENDREGION}

{$REGION '| APP |'}
   App.System.Connection,
   App.System.Connection.Transaction,
   App.System.Consts;
{$ENDREGION}

type

   TQuery = class
   private
      FFDQuery: TFDQuery;
      procedure SetFDQuery(const Value: TFDQuery);
   protected
      FClosed: Boolean;
      property FDQuery: TFDQuery read FFDQuery write SetFDQuery;
   public
      {$REGION '| CONTROL |'}
      /// <summary>
      ///   Verifica se a query retornou algum dado da abertura <Open>
      /// </summary>
      function GetData: Boolean;

      /// <summary>
      ///   Obtém o <TDataSet>
      /// </summary>
      function GetDataSet: TDataSet;

      /// <summary>
      ///   Obtém a lista de parâmetros
      /// </summary>
      function GetParams: TFDParams;

      /// <summary>
      ///   Obtém a lista de campos <TFields>
      /// </summary>
      function GetFields: TFields;

      /// <summary>
      ///   Obtém a lista de campos def <TFieldDefs>
      /// </summary>
      function GetFieldDef: TFieldDefs;

      /// <summary>
      ///   Abre a SQL de select na query
      /// </summary>
      procedure Open;

      /// <summary>
      ///   Adiciona uma SQL na query
      /// </summary>
      procedure AddSQL(const ASQL: UnicodeString);

      /// <summary>
      ///   Incrementa uma SQL na query
      /// </summary>
      procedure AppendSQL(const ASQL: UnicodeString);

      /// <summary>
      ///   Obtém o texto corrente da SQL da query
      /// </summary>
      function GetSQLText: UnicodeString;

      /// <summary>
      ///    Define um Status para o CachedUpdates
      /// </summary>
      procedure SetCachedUpdates(const AStatus: Boolean);

      /// <summary>
      ///   Move o indicador de registro para o primeiro da lista
      /// </summary>
      procedure First;

      /// <summary>
      ///   Move o indicador de registro para o último da lista
      /// </summary>
      procedure Last;

      /// <summary>
      ///   Move o indicador de registro para o próximo da lista
      /// </summary>
      procedure Next;

      /// <summary>
      ///   Limpa a query
      /// </summary>
      procedure Clear;

      /// <summary>
      ///   Fecha a query
      /// </summary>
      procedure Close;

      /// <summary>
      ///   Verifica se chegou ao final dos dados da query
      /// </summary>
      function EndOfData: Boolean;

      /// <summary>
      ///   Verifica se está no ínicio dos dados da query
      /// </summary>
      function BeginOfData: Boolean;

      /// <summary>
      ///   Verifica se a query está sem dados
      /// </summary>
      function EmptyData: Boolean;

      /// <summary>
      ///   Obtém o contador de registros <Last> <First>
      /// </summary>
      function RecordCount: Integer;

      /// <summary>
      ///   Verifica se a query está ativa
      /// </summary>
      function IsActive: Boolean;

      /// <summary>
      ///   Executa a SQL da query
      /// </summary>
      function Execute: Boolean;

      /// <summary>
      ///    Execute a SQL com uma transação externa
      /// </summary>
      function ExecuteWithTransaction: Boolean;

      /// <summary>
      ///    CommitUpdates
      /// </summary>
      procedure CommitUpdates;

      /// <summary>
      ///   Starta a transação da query
      /// </summary>
      procedure StartTransaction;

      /// <summary>
      ///   Commita a transação da query
      /// </summary>
      procedure CommitTransaction;

      /// <summary>
      ///   RollBack a transação da query
      /// </summary>
      procedure RollBackTransaction;

      /// <summary>
      ///    Cria um Stream através do Field
      /// </summary>
      function CreateBlobStream(const AField: TField): TStream;

      /// <summary>
      ///    Seta o MasterFields
      /// </summary>
      procedure SetMasterFields(const AValue: UnicodeString);

      /// <summary>
      ///    Seta o IndexFieldsNames
      /// </summary>
      procedure SetIndexFieldsNames(const AValue: UnicodeString);

      /// <summary>
      ///    Seta o MasterDataSource
      /// </summary>
      procedure SetMasterDataSource(const ADataSource: TDataSource);
      {$ENDREGION}

      {$REGION '| PARAM |'}
      /// <summary>
      ///   Obtém um parâmetro da Query por seu nome
      /// </summary>
      function ParamFrom(const AParamName: UnicodeString): TFDParam;

      /// <summary>
      ///   Limpa o parâmetro juntamente com o seu tipo <TFieldType>
      /// </summary>
      procedure ParamClear(const AParam: UnicodeString; const AType: TFieldType); overload;

      /// <summary>
      ///   Limpa o parâmetro
      /// </summary>
      procedure ParamClear(const AParam: UnicodeString); overload;

      /// <summary>
      ///   Param Value <Integer>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: Integer); overload;

      /// <summary>
      ///   Param Value <Int64>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: Int64); overload;

      /// <summary>
      ///   Param Value <ShortInt>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: ShortInt); overload;

      /// <summary>
      ///   Param Value <SmallInt>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: SmallInt); overload;

      /// <summary>
      ///   Param Value <Boolean>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: Boolean); overload;

      /// <summary>
      ///   Param Value <Currency>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: Currency); overload;

      /// <summary>
      ///   Param Value <Date>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: TDate); overload;

      /// <summary>
      ///   Param Value <TDateTime>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: TDateTime); overload;

      /// <summary>
      ///   Param Value <TTime>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: TTime); overload;

      /// <summary>
      ///   Param Value <UnicodeString>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: UnicodeString); overload;

      /// <summary>
      ///   Param Value <Variant>
      /// </summary>
      procedure ParamValue(const AParam: UnicodeString; const AValue: Variant); overload;
      {$ENDREGION}

      {$REGION '| FIELD |'}
      /// <summary>
      ///   Obtém um field da Query por seu nome
      /// </summary>
      function FieldFrom(const AFieldName: UnicodeString): TField;

      /// <summary>
      ///   To String
      /// </summary>
      function FieldToString(const AFieldName: UnicodeString): UnicodeString;

      /// <summary>
      ///   To Integer
      /// </summary>
      function FieldToInteger(const AFieldName: UnicodeString): Integer;

      /// <summary>
      ///   To Int64 <LargeInt>
      /// </summary>
      function FieldToInt64(const AFieldName: UnicodeString): Int64;

      /// <summary>
      ///   To Currency
      /// </summary>
      function FieldToCurr(const AFieldName: UnicodeString): Currency;

      /// <summary>
      ///   To Date
      /// </summary>
      function FieldToDate(const AFieldName: UnicodeString): TDate;

      /// <summary>
      ///   To DateTime
      /// </summary>
      function FieldToDateTime(const AFieldName: UnicodeString): TDateTime;

      /// <summary>
      ///   To Char
      /// </summary>
      function FieldToChar(const AFieldName: UnicodeString): Char;

      /// <summary>
      ///   To Boolean
      /// </summary>
      function FieldToBool(const AFieldName: UnicodeString): Boolean;

      /// <summary>
      ///   To Time
      /// </summary>
      function FieldToTime(const AFieldName: UnicodeString): TTime;

      /// <summary>
      ///   To Blog <TBlobField>
      /// </summary>
      function FieldToBlob(const AFieldName: UnicodeString): TBlobField;
      {$ENDREGION}

      {$REGION '| CREATE/DESTROY |'}
      /// <summary>
      ///   Query criada com o objeto padrão de conexão da aplicação <TConnection>
      /// </summary>
      constructor Create; overload;

      /// <summary>
      ///   Query criada com o objeto passado via parâmetro <TConnection>
      /// </summary>
      constructor Create(const AConnection: TConnection); overload;

      /// <summary>
      ///   Query criada com o objeto de transação via parâmetro <TConnectionTransaction.TConnection>
      /// </summary>
      constructor Create(const ATransaction: TConnectionTransaction); overload;

      destructor Destroy; override;
{$ENDREGION}
  end;

implementation

uses
   App.System.Vars, App.Common.Utils;

{ TQuery }

constructor TQuery.Create;
begin
   FDQuery := TFDQuery.Create(nil);
   FDQuery.Connection := gvConnection.GetFDConnection;
   FDQuery.CachedUpdates := True;
   inherited Create;
end;

constructor TQuery.Create(const AConnection: TConnection);
begin
   FDQuery := TFDQuery.Create(nil);
   FDQuery.Connection := AConnection.GetFDConnection;
   FDQuery.CachedUpdates := True;
   inherited Create;
end;

procedure TQuery.AddSQL(const ASQL: UnicodeString);
begin
   if (FFDQuery.SQL.Count > 0) then
      FFDQuery.SQL.Clear;

   if (ASQL.IsEmpty) then
      Exit;

   FFDQuery.SQL.Add(ASQL);

   if (gvSettings.System.TraceDebug) then
      LogUtils.Write('TraceDebug<SQL>', ASQL);
end;

procedure TQuery.AppendSQL(const ASQL: UnicodeString);
begin
   if (ASQL.IsEmpty) then
      Exit;

   FFDQuery.SQL.Append(sLineBreak);
   FFDQuery.SQL.Append(ASQL);
end;

function TQuery.BeginOfData: Boolean;
begin
   Result := FFDQuery.Bof;
end;

procedure TQuery.Clear;
begin
   FFDQuery.Params.Clear;
   FFDQuery.SQL.Clear;
   FFDQuery.Fields.Clear;
end;

procedure TQuery.Close;
begin
   if (IsActive) then
   begin
      if (not FClosed) then
      begin
         FFDQuery.Close;
         FClosed := True;
      end;
   end;
end;

procedure TQuery.CommitTransaction;
begin
   try
      if (FFDQuery.Transaction <> nil) then
         FFDQuery.Transaction.Commit
      else
         FFDQuery.Connection.Commit;
   except
      on E: Exception do
         raise Exception.CreateFmt('TQuery.CommitTransaction Exception! SQL: %s' + sLineBreak + 'Erro: %s', [GetSQLText, E.Message]);
   end;
end;


procedure TQuery.CommitUpdates;
begin
   FFDQuery.CommitUpdates;
end;

constructor TQuery.Create(const ATransaction: TConnectionTransaction);
begin
   ObjUtils.CheckAndRaiseNilObject(ATransaction);

   FDQuery := TFDQuery.Create(nil);
   FDQuery.Connection := gvConnection.GetFDConnection;
   FDQuery.Transaction := ATransaction.Transaction;
   inherited Create;
end;

function TQuery.CreateBlobStream(const AField: TField): TStream;
begin
   Result := FFDQuery.CreateBlobStream(AField, bmRead);
end;

destructor TQuery.Destroy;
begin
   FreeAndNil(FFDQuery);
   inherited Destroy;
end;

function TQuery.EmptyData: Boolean;
begin
   Result := (FFDQuery.IsEmpty);
end;

function TQuery.EndOfData: Boolean;
begin
   Result := (FFDQuery.Eof);
end;

function TQuery.Execute: Boolean;
begin
   StartTransaction;
   try
      FFDQuery.ExecSQL;

      Result := (FFDQuery.RowsAffected > 0);

      CommitTransaction;
   except
      on E: EFDDBEngineException do
      begin
         RollBackTransaction;
         raise Exception.CreateFmt('TQuery.Execute Exception! SQL: %s' + sLineBreak + 'Erro: %s', [GetSQLText, E.Message]);
      end;
   end;
end;

function TQuery.ExecuteWithTransaction: Boolean;
begin
   if (FDQuery.SQL.Count <= 0) then
      Exit(False);
   try
      FFDQuery.ExecSQL;

      Result := (FFDQuery.RowsAffected > 0);
   except
      on E: EFDDBEngineException do
      begin
         RollBackTransaction;
         raise Exception.CreateFmt('TQuery.ExecuteWithTransaction Exception! SQL: %s' + sLineBreak + 'Erro: %s', [GetSQLText, E.Message]);
      end;
   end;
end;

function TQuery.FieldFrom(const AFieldName: UnicodeString): TField;
begin
   if (AFieldName.IsEmpty) then
      raise Exception.Create('TQuery.FieldFrom = AFieldName[Empty]')
   else
   begin
      Result := FFDQuery.FindField(AFieldName);

      if (Result = nil) then
         raise Exception.CreateFmt('TQuery.FieldFrom = FindField[False] = %s', [AFieldName]);
   end;
end;

function TQuery.FieldToBlob(const AFieldName: UnicodeString): TBlobField;
var
   LBlob: TBlobField;
begin
   LBlob := FieldFrom(AFieldName) as TBlobField;

   if (LBlob <> nil) and (not LBlob.AsString.IsEmpty) then
      Result := LBlob
   else
      Result := nil;
end;

function TQuery.FieldToBool(const AFieldName: UnicodeString): Boolean;
begin
   Result := FieldFrom(AFieldName).AsBoolean;
end;

function TQuery.FieldToChar(const AFieldName: UnicodeString): Char;
begin
   Result := FieldFrom(AFieldName).AsString.Chars[0];
end;

function TQuery.FieldToCurr(const AFieldName: UnicodeString): Currency;
begin
   Result := FieldFrom(AFieldName).AsCurrency;
end;

function TQuery.FieldToDate(const AFieldName: UnicodeString): TDate;
begin
   Result := FieldFrom(AFieldName).AsDateTime;
end;

function TQuery.FieldToDateTime(const AFieldName: UnicodeString): TDateTime;
begin
   Result := FieldFrom(AFieldName).AsDateTime;
end;

function TQuery.FieldToInt64(const AFieldName: UnicodeString): Int64;
begin
   Result := FieldFrom(AFieldName).AsLargeInt;
end;

function TQuery.FieldToInteger(const AFieldName: UnicodeString): Integer;
begin
   Result := FieldFrom(AFieldName).AsInteger;
end;

function TQuery.FieldToString(const AFieldName: UnicodeString): UnicodeString;
begin
   Result := FieldFrom(AFieldName).AsString;
end;

function TQuery.FieldToTime(const AFieldName: UnicodeString): TTime;
begin
   Result := FieldFrom(AFieldName).AsDateTime;
end;

procedure TQuery.First;
begin
   FFDQuery.First;
end;

function TQuery.GetSQLText: UnicodeString;
begin
   Result := FFDQuery.SQL.Text;
end;

function TQuery.GetData: Boolean;
begin
   try
      Open;

      Result := (not EmptyData);

      if (not Result) then
         Close
      else
         CommitUpdates;
   except
      on E: Exception do
      begin
         RollBackTransaction;
         raise Exception.CreateFmt('TQuery.GetData Exception! SQL: %s' + sLineBreak + 'Erro: %s', [GetSQLText, E.Message]);
      end;
   end;
end;

function TQuery.GetDataSet: TDataSet;
begin
   Result := FFDQuery;
end;

function TQuery.GetFieldDef: TFieldDefs;
begin
   Result := FFDQuery.FieldDefs;
end;

function TQuery.GetFields: TFields;
begin
   Result := FFDQuery.Fields;
end;

function TQuery.GetParams: TFDParams;
begin
   Result := FFDQuery.Params;
end;

function TQuery.IsActive: Boolean;
begin
   Result := FFDQuery.Active;
end;

procedure TQuery.Last;
begin
   FFDQuery.Last;
end;

procedure TQuery.Next;
begin
   FFDQuery.Next;
end;

procedure TQuery.Open;
begin
   if (FFDQuery.SQL.Count > 0) then
   begin
      try
         FFDQuery.Open;
      except
         on E: Exception do
         begin
            RollBackTransaction;
            raise Exception.Create(E.Message);
         end;
      end;
   end;
end;

procedure TQuery.ParamClear(const AParam: UnicodeString; const AType: TFieldType);
begin
   ParamFrom(AParam).DataType := AType;
   ParamFrom(AParam).Clear;
end;

procedure TQuery.ParamClear(const AParam: UnicodeString);
begin
   ParamFrom(AParam).Clear;
end;

function TQuery.ParamFrom(const AParamName: UnicodeString): TFDParam;
begin
   if (AParamName.IsEmpty) then
      raise Exception.Create('TQuery.ParamFrom = AParamName[Empty]')
   else
   begin
      Result := FFDQuery.FindParam(AParamName);

      if (Result = nil) then
         raise Exception.CreateFmt('TQuery.ParamFrom = FindParam[False] = %s', [AParamName]);
   end;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: SmallInt);
begin
   ParamFrom(AParam).AsSmallInt := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: Boolean);
begin
   ParamFrom(AParam).AsBoolean := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: ShortInt);
begin
   ParamFrom(AParam).AsShortInt := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: Integer);
begin
   ParamFrom(AParam).AsInteger := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: Int64);
begin
   ParamFrom(AParam).AsLargeInt := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: Currency);
begin
   ParamFrom(AParam).AsCurrency := AValue;
end;

procedure TQuery.ParamValue(const AParam, AValue: UnicodeString);
begin
   if (AValue.IsEmpty) then
   begin
      ParamFrom(AParam).DataType := ftString;
      ParamFrom(AParam).Clear;
   end
   else
      ParamFrom(AParam).AsString := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: Variant);
begin
   ParamFrom(AParam).Value := AValue;
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: TTime);
begin
   if (AValue > 0) then
      ParamFrom(AParam).AsTime := AValue
   else
      ParamClear(AParam, ftTime);
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: TDate);
begin
   if (AValue > 0) then
      ParamFrom(AParam).AsDate := AValue
   else
      ParamClear(AParam, ftDate);
end;

procedure TQuery.ParamValue(const AParam: UnicodeString; const AValue: TDateTime);
begin
   if (AValue > 0) then
      ParamFrom(AParam).AsDateTime := AValue
   else
      ParamClear(AParam, ftDateTime);
end;

function TQuery.RecordCount: Integer;
begin
   FFDQuery.DisableControls;
   try
      Last;
      Result := FFDQuery.RecordCount;
      First;
   finally
      FFDQuery.EnableControls;
   end;
end;

procedure TQuery.RollBackTransaction;
begin
   if (FFDQuery.Transaction <> nil) then
      FFDQuery.Transaction.Rollback
   else
      FFDQuery.Connection.Rollback;
end;

procedure TQuery.SetCachedUpdates(const AStatus: Boolean);
begin
   FFDQuery.CachedUpdates := AStatus;
end;

procedure TQuery.SetFDQuery(const Value: TFDQuery);
begin
   FFDQuery := Value;
end;

procedure TQuery.SetIndexFieldsNames(const AValue: UnicodeString);
begin
   FFDQuery.IndexFieldNames := AValue;
end;

procedure TQuery.SetMasterDataSource(const ADataSource: TDataSource);
begin
   FFDQuery.MasterSource := ADataSource;
end;

procedure TQuery.SetMasterFields(const AValue: UnicodeString);
begin
   FFDQuery.MasterFields := AValue;
end;

procedure TQuery.StartTransaction;
begin
   if (FFDQuery.Transaction <> nil) then
      FFDQuery.Transaction.StartTransaction
   else
      FFDQuery.Connection.StartTransaction;
end;

end.
