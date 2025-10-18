unit App.Controller.Cadastro.Blocker;

interface

uses
   App.Objects.Entity.Blocker, App.System.ORM.Utils, App.Common.Vars, System.SysUtils;

type

   TControllerCadastroBlocker = class
   private
      FEntity: TEntityCommonBlocker;
      procedure SetEntity(const Value: TEntityCommonBlocker);
      function GetEntity: TEntityCommonBlocker;
   protected
      FIdRecord: Int64;
      FClassParentName: UnicodeString;

      property Entity: TEntityCommonBlocker read GetEntity write SetEntity;
   public
      /// <summary>
      ///    Inicia o bloqueio de um registro de cadastro
      /// </summary>
      procedure Initiate;

      /// <summary>
      ///    Finaliza o bloqueio de um registro de cadastro
      /// </summary>
      procedure Finalize;

      /// <summary>
      ///    Verifica se determiando registro de cadastro está bloqueado
      /// </summary>
      function Check: Boolean;

      constructor Create(const AId: Int64; const AClassName: UnicodeString); overload;
      destructor Destroy; override;
   end;

implementation

{ TControllerCadastroBlocker }

uses
   App.Common.Utils;

function TControllerCadastroBlocker.Check: Boolean;
begin
   if ORMUtils.Select_Record(Entity) then
   begin
      if (Entity.IdUsuario <> gvUsuario.Id) then
      begin
         LogUtils.Write('Bloqueio de Registro', Format('Usuário %s tentou alterar o registro %d da classe %s, porém está sendo editado por %s',
                                                       [gvUsuario.UserName, Entity.IdRecord, Entity.ClassParentName, Entity.UserName]));
         Exit(False);
      end;
   end;

   Result := True;
end;

constructor TControllerCadastroBlocker.Create(const AId: Int64; const AClassName: UnicodeString);
begin
   FIdRecord := AId;
   FClassParentName := AClassName;
   inherited Create;
end;

destructor TControllerCadastroBlocker.Destroy;
begin
   ObjUtils.Release_(FEntity);
   inherited;
end;

procedure TControllerCadastroBlocker.Finalize;
begin
   ORMUtils.Delete_Record(Entity);
end;

function TControllerCadastroBlocker.GetEntity: TEntityCommonBlocker;
begin
   if (not Assigned(FEntity)) then
   begin
      FEntity := TEntityCommonBlocker.Create;
      FEntity.IdEmpresa := gvEmpresa.Id;
      FEntity.IdRecord := FIdRecord;
      FEntity.IdUsuario := gvUsuario.Id;
      FEntity.ClassParentName := FClassParentName;
      FEntity.UserName := gvUsuario.UserName;
   end;

   Result := FEntity;
end;

procedure TControllerCadastroBlocker.Initiate;
begin
   ORMUtils.New_Record(Entity);
end;

procedure TControllerCadastroBlocker.SetEntity(const Value: TEntityCommonBlocker);
begin
   FEntity := Value;
end;

end.
