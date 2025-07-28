unit App.Controller.Usuario.Access;

interface

uses
   App.Objects.Entity.Usuario.Acccess,
   App.DataBase.Utils, System.SysUtils,
   App.Objects.Entity.Default,
   App.System.ORM.CustomAttributes,
   App.System.ORM.InspectAttributes, App.System.ORM.Utils;

type

   TControllerUsuarioAccess = class sealed (TObject)
   public
      /// <summary>
      ///    Insere um novo registro na tabela t_usuario_access
      /// </summary>
      /// <param name="AFormClass">
      ///    Nome da Classe do Form (Entidade) que será controlada
      /// </param>
      /// <param name="ADescricao">
      ///    Descrição do acesso, que será utilizada para visualização
      /// </param>
      /// <param name="AIdUsuario">
      ///    Id do Usuário
      /// </param>
      /// <param name="AIdEmpresa">
      ///    Id da Empresa
      /// </param>
      /// <param name="AEnableAll">
      ///    Controla se é para liberar tudo ou não
      /// </param>
      procedure Insert(const AFormClass, ADescricao: UnicodeString; const AIdUsuario, AIdEmpresa: Int64; const AEnableAll: Boolean);

      /// <summary>
      ///    Insere um registro para cada Form na aplicação
      /// </summary>
      /// <param name="AIdUsuario">
      ///    Id do Usuário
      /// </param>
      /// <param name="AIdEmpresa">
      ///    Id da Empresa
      /// </param>
      /// <param name="AEnableAll">
      ///    Controla se é para liberar tudo ou não
      /// </param>
      procedure Insert_AllFormClass(const AIdUsuario, AIdEmpresa: Int64; const AEnableAll: Boolean);
   end;

implementation

{ TControllerUsuarioAccess }

procedure TControllerUsuarioAccess.Insert(const AFormClass, ADescricao: UnicodeString; const AIdUsuario, AIdEmpresa: Int64; const AEnableAll: Boolean);
var
   LUsuarioAccess: TUsuarioAccess;
begin
   LUsuarioAccess := TUsuarioAccess.Create;
   try
      LUsuarioAccess.IdEmpresa := AIdEmpresa;
      LUsuarioAccess.IdUsuario := AIdUsuario;
      LUsuarioAccess.Descricao := ADescricao;
      LUsuarioAccess.FormClass := AFormClass;
      LUsuarioAccess.CanAccess := AEnableAll;
      LUsuarioAccess.CanInsert := AEnableAll;
      LUsuarioAccess.CanUpdate := AEnableAll;
      LUsuarioAccess.CanDelete := AEnableAll;

      TORMUtils.New_Record(LUsuarioAccess);
   finally
      FreeAndNil(LUsuarioAccess);
   end;
end;

procedure TControllerUsuarioAccess.Insert_AllFormClass(const AIdUsuario, AIdEmpresa: Int64; const AEnableAll: Boolean);
var
   LLoop: TObject;
   LInspect: TInspectAttributes;
   LObjectProperties: TObjectProperties;
   LTable: TTable;
begin
   for LLoop in gvRegistry do
   begin
      LInspect := TInspectAttributes.Create(LLoop.ClassType);
      try
         LObjectProperties := LInspect.GetAttribute_Properties;

         if (LObjectProperties <> nil) and (LObjectProperties.AccessControl) then
         begin
            LTable := LInspect.GetAttribute_Table;

            Insert(LLoop.ClassName, LTable.Comment, AIdUsuario, AIdEmpresa, AEnableAll);
         end;
      finally
         FreeAndNil(LInspect);
      end;
   end;
end;

end.
