unit App.System.Connection.Transaction;

interface

uses
   FireDAC.Comp.Client, App.System.Connection, System.SysUtils;

type

   TConnectionTransaction = class sealed (TObject)
   private
      FTransaction: TFDTransaction;
      FConnection: TConnection;
      procedure SetTransaction(const Value: TFDTransaction);
      procedure SetConnection(const Value: TConnection);

      /// <summary>
      ///   Start Transaction <TFDConnection>
      /// </summary>
      function GetTransaction: TFDTransaction;
   protected
      property Connection: TConnection read FConnection write SetConnection;
   public
      /// <summary>
      ///    Transaction.Start
      /// </summary>
      procedure Start;

      /// <summary>
      ///   Commit <TFDTransaction>
      /// </summary>
      procedure Commit;

      /// <summary>
      ///   RollBack <TFDTransaction>
      /// </summary>
      procedure RollBack;

      /// <summary>
      ///   Cria a instância usando <TConnection>
      /// </summary>
      constructor Create; overload;

      /// <summary>
      ///   Cria uma instância passando via parâmetro <TConnection>
      /// </summary>
      constructor Create(const AConnection: TConnection); overload;

      property Transaction: TFDTransaction read GetTransaction write SetTransaction;

      destructor Destroy; override;
   end;

implementation

uses
    App.System.Vars;

{ TConnectionTransaction }

constructor TConnectionTransaction.Create;
begin
   SetConnection(gvConnection);
   inherited Create;
end;

procedure TConnectionTransaction.Commit;
begin
   Transaction.Commit;
end;

constructor TConnectionTransaction.Create(const AConnection: TConnection);
begin
   SetConnection(AConnection);
   inherited Create;
end;

destructor TConnectionTransaction.Destroy;
begin
   FreeAndNil(FTransaction);
   inherited Destroy;
end;

function TConnectionTransaction.GetTransaction: TFDTransaction;
begin
   if (not Assigned(FTransaction)) then
   begin
      FTransaction := TFDTransaction.Create(nil);
      FTransaction.Connection := FConnection.GetFDConnection;
   end;

  Result := FTransaction;
end;

procedure TConnectionTransaction.RollBack;
begin
   Transaction.Rollback;
end;

procedure TConnectionTransaction.SetConnection(const Value: TConnection);
begin
   FConnection := Value;
end;

procedure TConnectionTransaction.SetTransaction(const Value: TFDTransaction);
begin
   FTransaction := Value;
end;

procedure TConnectionTransaction.Start;
begin
   Transaction.StartTransaction;
end;

end.

