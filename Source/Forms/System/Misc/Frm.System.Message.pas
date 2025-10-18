unit Frm.System.Message;

interface

uses

{$REGION '| USES |'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm.System.Ancestral, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, cxGeometry, dxFramedControl,
  dxPanel, dxSkinWhiteprint, dxSkinWXI, cxContainer, cxEdit, dxGDIPlusClasses,
  cxImage, cxClasses, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  cxTextEdit, cxMemo, App.System.Types;
{$ENDREGION}

type

   TFrmSystemMessage = class(TFrmSystemAncestral)
      cxImageCollection: TcxImageCollection;
      CxImgSucess: TcxImageCollectionItem;
      CxImgWarning: TcxImageCollectionItem;
      CxImgError: TcxImageCollectionItem;
      CxImgQuestion: TcxImageCollectionItem;
      CxImgInfo: TcxImageCollectionItem;
      PnlBackGround: TPanel;
      PnlButtons: TPanel;
      PnlInnerButtons: TdxPanel;
      PnlCancel: TPanel;
      BtCancel: TcxButton;
      PnlConfirm: TPanel;
      BtConfirm: TcxButton;
      PnlOk: TPanel;
      BtOk: TcxButton;
      PnlText: TdxPanel;
      LblAction: TLabel;
      MemoText: TcxMemo;
      PnlImages: TdxPanel;
      ImgMessage: TcxImage;
      procedure BtConfirmClick(Sender: TObject);
      procedure BtCancelClick(Sender: TObject);
      procedure BtOkClick(Sender: TObject);
   private
      FTypeMessage: TTypeMessage;
      FMessageText: UnicodeString;
      procedure SetTypeMessage(const Value: TTypeMessage);
      procedure SetMessageText(const Value: UnicodeString);

      /// <summary>
      ///    Abre o form de acordo com tipo da mensagem
      /// </summary>
      procedure OpenFormFrom_Type;

      /// <summary>
      ///    Ajusta o tamanho do form para caber o texto
      /// </summary>
      procedure Resize_Self;
   strict protected
      /// <summary>
      ///    Show.Self
      /// </summary>
      procedure Show_Self; override;
   public
      property TypeMessage: TTypeMessage read FTypeMessage write SetTypeMessage;
      property MessageText: UnicodeString read FMessageText write SetMessageText;
   end;

var
  FrmSystemMessage: TFrmSystemMessage;

implementation

{$R *.dfm}

{ TFrmSystemMessage }

procedure TFrmSystemMessage.BtCancelClick(Sender: TObject);
begin
   inherited;
   TypeResultAction := traCanceled;
   Self.Close;
end;

procedure TFrmSystemMessage.BtConfirmClick(Sender: TObject);
begin
   inherited;
   TypeResultAction := traConfirmed;
   Self.Close;
end;

procedure TFrmSystemMessage.BtOkClick(Sender: TObject);
begin
   inherited;
   TypeResultAction := traConfirmed;
   Self.Close;
end;

procedure TFrmSystemMessage.OpenFormFrom_Type;
begin
   PnlOk.Visible := True;
   PnlOk.Enabled := True;

   case TypeMessage of
      tmNone: raise Exception.Create('Tipo não definido no método [OpenFormFrom_Type]');

      tmInfo:     begin
                     ImgMessage.Picture := CxImgInfo.Picture;
                     LblAction.Caption := 'Informação';
                  end;

      tmWarning:  begin
                     ImgMessage.Picture := CxImgWarning.Picture;
                     LblAction.Caption := 'Aviso';
                  end;

      tmSucess:   begin
                    ImgMessage.Picture := CxImgSucess.Picture;
                    LblAction.Caption := 'Sucesso';
                  end;

      tmError:    begin
                     ImgMessage.Picture := CxImgError.Picture;
                     LblAction.Caption := 'Erro';
                  end;

      tmQuestion: begin
                     ImgMessage.Picture := CxImgQuestion.Picture;
                     PnlCancel.Visible := True;
                     PnlCancel.Visible := True;
                     PnlConfirm.Enabled := True;
                     PnlConfirm.Enabled := True;
                     PnlOk.Enabled := False;
                     PnlOk.Visible := False;
                     LblAction.Caption := 'Confirmação?';
                  end;
   end;
end;

procedure TFrmSystemMessage.Resize_Self;
var
   LHeigthInc: Integer;
begin
   if (MemoText.Lines.Count > 4) then
   begin
      LHeigthInc := 25 * (MemoText.Lines.Count - 4);

      Self.Height := Self.Height + LHeigthInc;

      if (Self.Height >= Screen.Height) then
       Self.Height := Screen.Height - 100;
   end;
end;

procedure TFrmSystemMessage.SetMessageText(const Value: UnicodeString);
begin
   FMessageText := Value;
end;

procedure TFrmSystemMessage.SetTypeMessage(const Value: TTypeMessage);
begin
   FTypeMessage := Value;
end;

procedure TFrmSystemMessage.Show_Self;
begin
   inherited;
   OpenFormFrom_Type;
   MemoText.Lines.Text := MessageText;
   Resize_Self;
end;

end.
