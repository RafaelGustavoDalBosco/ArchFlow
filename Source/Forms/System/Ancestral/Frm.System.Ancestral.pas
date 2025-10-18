unit Frm.System.Ancestral;

interface

uses

{$REGION '| USES |'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinOffice2019Black, dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray,
  dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxGeometry, dxFramedControl, dxPanel,
  dxCore, cxClasses, dxSkinsForm, dxPSEngn, Vcl.ExtCtrls, dxSkinWXI,
  App.Common.Utils, App.System.Vars, App.Objects.Common, App.System.Types,
  App.Common.Consts;
{$ENDREGION}

type

   TFrmSystemAncestral = class(TForm)
      PnlMain: TdxPanel;
      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
   private
      FUseKeyEscapeToLeave: Boolean;
      FTypeResultAction: TTypeResultAction;
      procedure SetUseKeyEscapeToLeave(const Value: Boolean);
      procedure SetTypeResultAction(const Value: TTypeResultAction);
   strict private
      /// <summary>
      ///    Controla a digitação da tecla Alt para os atalhos
      /// </summary>
      procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
   strict protected
      /// <summary>
      ///    Create.Self
      /// </summary>
      procedure Create_Self; virtual;

      /// <summary>
      ///    Close.Self
      /// </summary>
      procedure Close_Self; virtual;

      /// <summary>
      ///    Show.Self
      /// </summary>
      procedure Show_Self; virtual;

      /// <summary>
      ///    Destroy.Self
      /// </summary>
      procedure Destroy_Self; virtual;
   public
      property UseKeyEscapeToLeave: Boolean read FUseKeyEscapeToLeave write SetUseKeyEscapeToLeave;
      property TypeResultAction: TTypeResultAction read FTypeResultAction write SetTypeResultAction;
   end;

var
   FrmSystemAncestral: TFrmSystemAncestral;

implementation

{$R *.dfm}

{ TFrmSystemAncestral }

procedure TFrmSystemAncestral.Close_Self;
begin
   // -> Each
end;

procedure TFrmSystemAncestral.CMDialogChar(var Message: TCMDialogChar);
begin
   if (ssAlt in KeyDataToShiftState(Message.KeyData)) then
      inherited;
end;

procedure TFrmSystemAncestral.Create_Self;
begin
   SetUseKeyEscapeToLeave(gvSettings.Customize.UseEscapeKeyToLeave);
end;

procedure TFrmSystemAncestral.Destroy_Self;
begin
   // -> Each
end;

procedure TFrmSystemAncestral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   Close_Self;
end;

procedure TFrmSystemAncestral.FormCreate(Sender: TObject);
begin
   inherited;
   Create_Self;
end;

procedure TFrmSystemAncestral.FormDestroy(Sender: TObject);
begin
   inherited;
   Destroy_Self;
end;

procedure TFrmSystemAncestral.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) and (FUseKeyEscapeToLeave) then
   begin
      if MessageUtils.Show_Question(SConfirm_LeaveScreen) then
         Close;
   end;
end;

procedure TFrmSystemAncestral.FormShow(Sender: TObject);
begin
   inherited;
   Show_Self;
end;

procedure TFrmSystemAncestral.SetTypeResultAction(const Value: TTypeResultAction);
begin
   FTypeResultAction := Value;
end;

procedure TFrmSystemAncestral.SetUseKeyEscapeToLeave(const Value: Boolean);
begin
   FUseKeyEscapeToLeave := Value;
end;

procedure TFrmSystemAncestral.Show_Self;
begin
   if (gvSettings.System.TraceDebug) then
      LogUtils.Write('TraceDebug', Format('Tela %s aberta!', [Self.Name]));
end;

end.
