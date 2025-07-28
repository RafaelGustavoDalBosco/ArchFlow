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
  dxCore, cxClasses, dxSkinsForm, dxPSEngn, Vcl.ExtCtrls;
{$ENDREGION}

type

   TFrmSystemAncestral = class(TForm)
      PnlMain: TPanel;
      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      /// <summary>
      ///    Controla a digitação da tecla Alt para os atalhos
      /// </summary>
      procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
   strict protected
      /// <summary>
      ///    Create.Self
      /// </summary>
      procedure CreateSelf; virtual;

      /// <summary>
      ///    Close.Self
      /// </summary>
      procedure CloseSelf; virtual;

      /// <summary>
      ///    Show.Self
      /// </summary>
      procedure ShowSelf; virtual;

      /// <summary>
      ///    Destroy.Self
      /// </summary>
      procedure DestroySelf; virtual;
   public
      { Public declarations }
   end;

var
   FrmSystemAncestral: TFrmSystemAncestral;

implementation

{$R *.dfm}

{ TFrmSystemAncestral }

procedure TFrmSystemAncestral.CloseSelf;
begin
   // -> Each
end;

procedure TFrmSystemAncestral.CMDialogChar(var Message: TCMDialogChar);
begin
   if (ssAlt in KeyDataToShiftState(Message.KeyData)) then
      inherited;
end;

procedure TFrmSystemAncestral.CreateSelf;
begin
   // -> Each
end;

procedure TFrmSystemAncestral.DestroySelf;
begin
   // -> Each
end;

procedure TFrmSystemAncestral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   CloseSelf;
end;

procedure TFrmSystemAncestral.FormCreate(Sender: TObject);
begin
   inherited;
   CreateSelf;
end;

procedure TFrmSystemAncestral.FormDestroy(Sender: TObject);
begin
   inherited;
   DestroySelf;
end;

procedure TFrmSystemAncestral.FormShow(Sender: TObject);
begin
   inherited;
   ShowSelf;
end;

procedure TFrmSystemAncestral.ShowSelf;
begin
   // -> Each
end;

end.
