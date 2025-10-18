program ArchFlow;

uses
  {$REGION}
  Vcl.Forms,
  Windows,
  SysUtils,
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
  App.Controller.AmazonCloud.S3 in '..\Source\Units\Controller\App.Controller.AmazonCloud.S3.pas',
  App.Controller.Engage in '..\Source\Units\Controller\App.Controller.Engage.pas',
  Frm.System.Ancestral in '..\Source\Forms\System\Ancestral\Frm.System.Ancestral.pas' {FrmSystemAncestral},
  Frm.System.Message in '..\Source\Forms\System\Misc\Frm.System.Message.pas' {FrmSystemMessage},
  Frm.System.Watcher in '..\Source\Forms\System\Misc\Frm.System.Watcher.pas' {FrmSystemWatcher},
  Frm.System.Ancestral.Execute in '..\Source\Forms\System\Ancestral\Frm.System.Ancestral.Execute.pas' {FrmSystemAncestralExecute},
  Frm.System.Engage in '..\Source\Forms\System\Misc\Frm.System.Engage.pas' {FrmSystemEngage},
  App.Controller.AmazonCloud.Cognito in '..\Source\Units\Controller\App.Controller.AmazonCloud.Cognito.pas',
  App.System.Manager.Company.Cloud in '..\Source\Units\System\Manager\App.System.Manager.Company.Cloud.pas',
  Frm.System.Application.Enter in '..\Source\Forms\System\Application\Frm.System.Application.Enter.pas' {FrmSystemApplicationEnter},
  Frm.Main in '..\Source\Forms\Frm.Main.pas' {FrmMain},
  Frm.System.Ancestral.Cadastro in '..\Source\Forms\System\Ancestral\Frm.System.Ancestral.Cadastro.pas' {FrmSystemAncestralCadastro},
  App.Controller.Usuario.LogOn in '..\Source\Units\Controller\App.Controller.Usuario.LogOn.pas',
  App.Controller.Cadastro.Blocker in '..\Source\Units\Controller\App.Controller.Cadastro.Blocker.pas',
  App.Objects.Entity.Blocker in '..\Source\Units\Objects\EntityFramework\App.Objects.Entity.Blocker.pas',
  App.System.Manager.View in '..\Source\Units\System\Manager\App.System.Manager.View.pas';

{$ENDREGION}

{$R *.res}

function IsAppAlreadyRunning(const AMutexName: UnicodeString): Boolean;
var
   LMutexHandle: THandle;
   LErrorCode: DWORD;
begin
   LMutexHandle := CreateMutex(nil, True, PChar(AMutexName));
   LErrorCode := GetLastError;

   if (LMutexHandle <> 0) and (LErrorCode = ERROR_ALREADY_EXISTS) then
   begin
      CloseHandle(LMutexHandle);
      Result := True;
   end
   else
      Result := False;
end;

procedure ActivateExistingInstance;
var
   LWindowHandle: HWND;
   LMessage: TMsg;
begin
   LWindowHandle := FindWindow(nil, 'ArchFlow');

   if LWindowHandle <> 0 then
   begin
      if IsIconic(LWindowHandle) then
         ShowWindow(LWindowHandle, SW_RESTORE);

      SetForegroundWindow(LWindowHandle);

      while PeekMessage(LMessage, 0, 0, 0, PM_REMOVE) do
      begin
         TranslateMessage(LMessage);
         DispatchMessage(LMessage);
      end;
   end;
end;

const
   UniqueMutexName = 'ArchFlow_SingleInstanceMutex';
var
   LEngage: TControllerEngage;
begin
   if IsAppAlreadyRunning(UniqueMutexName) then
   begin
      ActivateExistingInstance;
      Halt;
   end;

   {$IFDEF DEBUG}
   ReportMemoryLeaksOnShutdown := True;
   {$ENDIF}

   LEngage := TControllerEngage.Create;
   try
      if LEngage.Execute then
      begin
         Application.Initialize;
         Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmSystemComponentAssistance, FrmSystemComponentAssistance);
  Application.MainFormOnTaskbar := True;
         Application.Run;
      end
      else
         Application.Terminate;
   finally
      LEngage.Destroy;
   end;
end.
