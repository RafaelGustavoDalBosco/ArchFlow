unit App.System.Manager.View;

interface

uses
    cxClasses, dxUIAdorners, Vcl.Controls, System.Threading, System.Classes, System.SysUtils, App.System.Types, cxTextEdit, cxDropDownEdit;

type

   TProcedure = reference to procedure();

   TSystemManagerView = class
   strict private
      /// <summary>
      ///    Execute uma procedure utilizando um ITask
      /// </summary>
      /// <param name="AProc">
      ///    Define qual será o procedimento a ser executado
      /// </param>
      /// <param name="AMessageCallOut">
      ///    Define a mensagem que será apresentada durante o CallOut
      /// </param>
      /// <param name="AOwner">
      ///    Define o componente Dono da execução
      /// </param>
      /// <param name="AAdorner">
      ///    é o Componente responsável por ''travar'' a tela durante a operação
      /// </param>
      function Execute(const AProc: TProcedure; const AMessageCallOut: UnicodeString; const AOwner: TWinControl; const AAdorner: TdxGuide): Boolean;
   public
      /// <summary>
      ///    Persiste as informações de uma Entidade, mostrando um visualizar,
      ///    por padrão usa o Owner e um TdxGuide para pausar o View durante a operação
      /// </summary>
      /// <param name="AOwner">
      ///    Define o componente Dono da execução
      /// </param>
      /// <param name="AAdorner">
      ///    é o Componente responsável por ''travar'' a tela durante a operação
      /// </param>
      /// <param name="AObject">
      ///    Objeto que será persistido
      /// </param>
      /// <param name="AType">
      ///    TTypeOperation -> Define qual operação será (Insert, Update, Delete)
      /// </param>
      function Persist_Entity(const AOwner: TWinControl; const AAdorner: Tdxguide; const AObject: TObject; const AType: TTypeOperation): Boolean;
   end;

implementation

{ TSystemManagerView }

uses App.Common.Utils, Frm.System.Component.Assistance;

function TSystemManagerView.Execute(const AProc: TProcedure; const AMessageCallOut: UnicodeString; const AOwner: TWinControl; const AAdorner: TdxGuide): Boolean;
var
   LTask: ITask;
begin
   TdxAdornerTargetElementPath(AAdorner.TargetElement).Path := AOwner.Name;
   AAdorner.Adorners.Active := True;
   CompUtils.Show_CallOut_Wait_And_Sucess(AOwner, AMessageCallOut);

   LTask := TTask.Run(
   procedure
   begin
      AProc;

      TThread.Synchronize(nil,
      procedure
      begin
         AAdorner.Adorners.Active := False;
         FrmSystemComponentAssistance.DxCalloutPopup.Close;
      end);
   end);
end;

function TSystemManagerView.Persist_Entity(const AOwner: TWinControl; const AAdorner: Tdxguide; const AObject: TObject; const AType: TTypeOperation): Boolean;
begin

end;

end.
