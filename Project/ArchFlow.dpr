program ArchFlow;

uses
  Vcl.Forms,
  Frm.System.Ancestral in '..\Source\Forms\System\Frm.System.Ancestral.pas' {FrmSystemAncestral},
  Frm.System.Component.Assistance in '..\Source\Forms\System\Frm.System.Component.Assistance.pas' {FrmSystemComponentAssistance},
  App.System.Types in '..\Source\Units\System\App.System.Types.pas',
  App.Common.Utils in '..\Source\Units\Common\App.Common.Utils.pas',
  App.System.Connection in '..\Source\Units\System\Connection\App.System.Connection.pas',
  App.System.Connection.Query in '..\Source\Units\System\Connection\App.System.Connection.Query.pas',
  App.System.Connection.Transaction in '..\Source\Units\System\Connection\App.System.Connection.Transaction.pas',
  App.System.Consts in '..\Source\Units\System\App.System.Consts.pas',
  App.System.Vars in '..\Source\Units\System\App.System.Vars.pas',
  App.System.ORM.CustomAttributes in '..\Source\Units\System\ORM\App.System.ORM.CustomAttributes.pas',
  App.Objects.Entity.Default in '..\Source\Units\Objects\EntityFramework\Default\App.Objects.Entity.Default.pas',
  App.DataBase.Consts in '..\Source\Units\DataBase\App.DataBase.Consts.pas',
  App.Common.Types in '..\Source\Units\Common\App.Common.Types.pas',
  App.System.ORM.InspectAttributes in '..\Source\Units\System\ORM\App.System.ORM.InspectAttributes.pas',
  App.System.ORM.Extract in '..\Source\Units\System\ORM\App.System.ORM.Extract.pas',
  App.Objects.Common in '..\Source\Units\Objects\Common\App.Objects.Common.pas',
  App.DataBase.Objects in '..\Source\Units\DataBase\App.DataBase.Objects.pas',
  App.System.List in '..\Source\Units\System\App.System.List.pas',
  App.System.ORM.Persistent in '..\Source\Units\System\ORM\App.System.ORM.Persistent.pas',
  App.System.ORM.CommandsText in '..\Source\Units\System\ORM\App.System.ORM.CommandsText.pas',
  App.System.SQL.Pattern in '..\Source\Units\System\SQL\App.System.SQL.Pattern.pas',
  App.Common.Vars in '..\Source\Units\Common\App.Common.Vars.pas',
  App.Common.Consts in '..\Source\Units\Common\App.Common.Consts.pas',
  App.Common.Files.Settings in '..\Source\Units\Common\Files\App.Common.Files.Settings.pas',
  App.Objects.Entity.Empresa in '..\Source\Units\Objects\EntityFramework\App.Objects.Entity.Empresa.pas',
  App.Objects.Entity.Usuario in '..\Source\Units\Objects\EntityFramework\App.Objects.Entity.Usuario.pas',
  App.System.Engine.DataBase in '..\Source\Units\System\Engine\App.System.Engine.DataBase.pas',
  App.Common.Records in '..\Source\Units\Common\App.Common.Records.pas',
  App.System.Records in '..\Source\Units\System\App.System.Records.pas',
  App.DataBase.Utils in '..\Source\Units\DataBase\App.DataBase.Utils.pas',
  App.Objects.Entity.ApplicationData in '..\Source\Units\Objects\EntityFramework\App.Objects.Entity.ApplicationData.pas',
  App.Objects.Entity.Usuario.Acccess in '..\Source\Units\Objects\EntityFramework\App.Objects.Entity.Usuario.Acccess.pas',
  App.Controller.Usuario.Access in '..\Source\Units\Controller\App.Controller.Usuario.Access.pas',
  App.System.ORM.Utils in '..\Source\Units\System\ORM\App.System.ORM.Utils.pas',
  App.System.Manager.Billing in '..\Source\Units\System\Manager\App.System.Manager.Billing.pas',
  App.Controller.AmazonCloud in '..\Source\Units\Controller\App.Controller.AmazonCloud.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSystemAncestral, FrmSystemAncestral);
  Application.CreateForm(TFrmSystemComponentAssistance, FrmSystemComponentAssistance);
  Application.Run;
end.
