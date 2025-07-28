 unit App.Objects.Entity.Default;

interface

uses
   App.System.ORM.CustomAttributes, App.DataBase.Consts, App.System.Types, System.Generics.Collections;

type

   TEntity = class
   strict private
      FId: Int64;
      FTypeOperation: TTypeOperation;
      procedure SetId(const Value: Int64);
      procedure SetTypeOperation(const Value: TTypeOperation);
   public
      [TField(SField_Id, True, True)]
      [TFieldInt64]
      property Id: Int64 read FId write SetId;

      property TypeOperation: TTypeOperation read FTypeOperation write SetTypeOperation;

      constructor Create; overload;
   end;

   TEntityCommon = class(TEntity)
   strict private
      FIdEmpresa: Int64;
      FActive: Boolean;
      procedure SetActive(const Value: Boolean);
      procedure SetIdEmpresa(const Value: Int64);
   public
      [TField(SField_Id_Empresa, True)]
      [TFieldInt64]
      [TFieldForeignKey(SField_Id, STable_Empresa)]
      [TFieldParam]
      property IdEmpresa: Int64 read FIdEmpresa write SetIdEmpresa;

      [TField(SField_Active)]
      [TFieldBoolean]
      property Active: Boolean read FActive write SetActive;
   end;

   TEntityRoot = class(TEntityCommon)
   strict private
      FOwnerId: Int64;
      FOwnerType: ShortInt;
      procedure SetOwnerId(const Value: Int64);
      procedure SetOwnerType(const Value: ShortInt);
   public
      [TField(SField_Owner_Type, True)]
      [TFieldShortInt(0, 6)]
      property OwnerType: ShortInt read FOwnerType write SetOwnerType;

      [TField(SField_Owner_Id, True)]
      [TFieldInt64]
      [TFieldParam]
      property OwnerId: Int64 read FOwnerId write SetOwnerId;
   end;

   TRegisterClass = class
   public
      /// <summary>
      ///    Insere um novo Objeto na lista gvRegistry
      /// </summary>
      /// <param name="AClass">
      ///    Define a classe que será registrada
      /// </param>
      class procedure Register(const AClass: TClass); static;
   end;

var
   gvRegistry: TObjectList<TObject>;

implementation

{ TEntity }

constructor TEntity.Create;
begin
   FTypeOperation := toNone;
   inherited Create;
end;

procedure TEntity.SetId(const Value: Int64);
begin
   FId := Value;
end;

procedure TEntity.SetTypeOperation(const Value: TTypeOperation);
begin
   FTypeOperation := Value;
end;

{ TEntityCommon }

procedure TEntityCommon.SetActive(const Value: Boolean);
begin
   FActive := Value;
end;

procedure TEntityCommon.SetIdEmpresa(const Value: Int64);
begin
   FIdEmpresa := Value;
end;

{ TRegisterClass }

class procedure TRegisterClass.Register(const AClass: TClass);
var
   LObject: TObject;
begin
   LObject := AClass.NewInstance;
   gvRegistry.Add(LObject);
end;

{ TEntityRoot }

procedure TEntityRoot.SetOwnerId(const Value: Int64);
begin
   FOwnerId := Value;
end;

procedure TEntityRoot.SetOwnerType(const Value: ShortInt);
begin
   FOwnerType := Value;
end;

initialization
   gvRegistry := TObjectList<TObject>.Create;
finalization
   gvRegistry.Free;
end.
