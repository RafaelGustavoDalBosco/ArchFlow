unit Frm.System.Ancestral.Execute;

interface

uses

{$REGION '| USES |'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm.System.Ancestral, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinWhiteprint, dxSkinWXI, cxGeometry, dxFramedControl, dxPanel, dxStatusBar,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  Frm.System.Component.Assistance, cxClasses, dxUIAdorners, App.System.Types;
{$ENDREGION}

type

   TFrmSystemAncestralExecute = class(TFrmSystemAncestral)
      StatusBar: TdxStatusBar;
      PnlButtons: TdxPanel;
      PnlCancel: TPanel;
      BtCancel: TcxButton;
      PnlConfirm: TPanel;
      BtConfirm: TcxButton;
      dxUIAdornerManager: TdxUIAdornerManager;
      AdornerGuideFocus: TdxGuide;
      AdornerGuidePersist: TdxGuide;
      procedure BtCancelClick(Sender: TObject);
      procedure BtCancelEnter(Sender: TObject);
      procedure BtConfirmClick(Sender: TObject);
      procedure BtConfirmEnter(Sender: TObject);
   strict protected
      /// <summary>
      ///    Código que executa no botão Confirmar
      /// </summary>
      procedure Apply_Self; virtual;

      /// <summary>
      ///    Persiste as informações no Banco de Dados/Other
      /// </summary>
      procedure Persist_Self; virtual;

      /// <summary>
      ///    Valida as informações digitadas no Form
      /// </summary>
      function Validate_Self: Boolean; virtual;
   public
      /// <summary>
      ///    Seta os textos no StatusBar
      /// </summary>
      /// <param name="ACaption">
      ///    é o título que vai aparecer
      /// </param>
      /// <param name="AText">
      ///    é o texto que vai aparecer
      /// </param>
      procedure SetTextStatusBar(const ACaption, AText: UnicodeString);

      /// <summary>
      ///    Guia e seta o Foco em um componente usando o DxAdorner
      /// </summary>
      /// <param name="AComponent">
      ///    Componente que receberá o guia e o foco
      /// </param>
      /// <param name="ACaption">
      ///    é o título que vai usar no Adorner
      /// </param>
      procedure GuideAndFocus(const AComponent: TComponent; const ACaption: UnicodeString);
   end;

var
  FrmSystemAncestralExecute: TFrmSystemAncestralExecute;

implementation

{$R *.dfm}

uses App.Common.Utils, App.Common.Consts;

{ TFrmSystemAncestralExecute }

procedure TFrmSystemAncestralExecute.Apply_Self;
begin
   if (Validate_Self) then
   begin
      Persist_Self;
      TypeResultAction := traConfirmed;
      Close;
   end
   else
      TypeResultAction := traCanceled;
end;

procedure TFrmSystemAncestralExecute.BtCancelClick(Sender: TObject);
begin
   inherited;
   TypeResultAction := traCanceled;
   Close;
end;

procedure TFrmSystemAncestralExecute.BtCancelEnter(Sender: TObject);
begin
   inherited;
   SetTextStatusBar('Cancelar', 'Cancela os dados digitados');
end;

procedure TFrmSystemAncestralExecute.BtConfirmClick(Sender: TObject);
begin
   inherited;
   Apply_Self;
end;

procedure TFrmSystemAncestralExecute.BtConfirmEnter(Sender: TObject);
begin
   inherited;
   SetTextStatusBar('Confirmar', 'Confirma os dados digitados');
end;

procedure TFrmSystemAncestralExecute.GuideAndFocus(const AComponent: TComponent; const ACaption: UnicodeString);
begin
   CompUtils.Show_CallOut_Warn_And_Guide(PnlButtons, AComponent, AdornerGuideFocus, Format(SWarn_Empty_FieldValue, [ACaption]));
end;

procedure TFrmSystemAncestralExecute.Persist_Self;
begin
   // -> Each
end;

procedure TFrmSystemAncestralExecute.SetTextStatusBar(const ACaption, AText: UnicodeString);
begin
   StatusBar.Panels[0].Text := ACaption;
   StatusBar.Panels[1].Text := AText;
end;

function TFrmSystemAncestralExecute.Validate_Self: Boolean;
begin
   Result := True;
end;

end.
