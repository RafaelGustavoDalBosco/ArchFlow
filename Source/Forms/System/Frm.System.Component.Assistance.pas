unit Frm.System.Component.Assistance;

interface

uses

{$REGION '| USES |'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinBasic,  dxCore, cxClasses, cxLookAndFeels,
  dxSkinsForm, Vcl.AppEvnts, dxSkinWXI, dxSkinWhiteprint, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics, cxControls, cxLookAndFeelPainters,
  cxGeometry, dxFramedControl, cxContainer, cxEdit, dxActivityIndicator,
  dxGDIPlusClasses, cxImage, cxLabel, dxPanel, dxCalloutPopup, dxUIAdorners,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  Vcl.ExtCtrls, dxSpellCheckerCore, dxSpellChecker, cxLocalization, dxScreenTip,
  dxCustomHint, cxHint, FireDAC.Phys.PGDef, FireDAC.Phys, FireDAC.Phys.PG,
  dxHunspellTypes, dxHunspellDictionary,
  dxorgced, dxorgchr, dxTaskbarProgress, cxInplaceContainer, cxVGrid;
{$ENDREGION}

type

   TFrmSystemComponentAssistance = class(TForm)
      dxSkinController: TdxSkinController;
      ApplicationEvents: TApplicationEvents;
      cxImageList16: TcxImageList;
      DxCalloutPopup: TdxCalloutPopup;
      DxPanelCallOutSucess: TdxPanel;
      LblCallOutSucess: TcxLabel;
      CxImgCallOutSucess: TcxImage;
      DxPanelCallOutWaitAndSucess: TdxPanel;
      dxActivityIndicatorCallOut: TdxActivityIndicator;
      LblCallOutWaitAndSucess: TcxLabel;
      CxImgCallOutWaitAndSucess: TcxImage;
      DxPanelCallOutWarning: TdxPanel;
      LblCallOutWarning: TcxLabel;
      CxImgWarn: TcxImage;
      dxUIAdornerManager: TdxUIAdornerManager;
      AdornerGuide: TdxGuide;
      FDGUIxWaitCursor: TFDGUIxWaitCursor;
      TimerCallOutPopUp: TTimer;
      dxSpellChecker: TdxSpellChecker;
      cxLocalizer: TcxLocalizer;
      HintController: TcxHintStyleController;
      FDPhysPgDriverLink: TFDPhysPgDriverLink;
      cxImageList32: TcxImageList;
      procedure ApplicationEventsException(Sender: TObject; E: Exception);
      procedure TimerCallOutPopUpTimer(Sender: TObject);
      procedure FormCreate(Sender: TObject);
   private
      /// <summary>
      ///    Carrega os arquivos do SpellChecker
      /// </summary>
      procedure Load_SpellChecker_Files;

      /// <summary>
      ///    Carrega o arquivo de tradução dos componentes da devexpress
      /// </summary>
      procedure Load_Tradution_File;
   public
   end;

var
  FrmSystemComponentAssistance: TFrmSystemComponentAssistance;

implementation

{$R *.dfm}

uses App.Common.Utils, App.System.Vars;

procedure TFrmSystemComponentAssistance.ApplicationEventsException(Sender: TObject; E: Exception);
begin
   LogUtils.Write('Exception Raised', E.Message);
   MessageUtils.Show_Error(E.Message);
end;

procedure TFrmSystemComponentAssistance.FormCreate(Sender: TObject);
begin
   Load_SpellChecker_Files;
   Load_Tradution_File;
end;

procedure TFrmSystemComponentAssistance.Load_SpellChecker_Files;
var
   LInstance: TdxHunspellDictionary;
begin
   if (gvSettings.Customize.DisableSpellChecker) or
      (not FileUtils.Exists(gvFiles.SpellChecker_Aff_File)) or
      (not FileUtils.Exists(gvFiles.SpellChecker_Dic_File)) then
      Exit;

   LInstance := TdxHunspellDictionary(dxSpellChecker.Dictionaries[0]);
   LInstance.DictionaryPath := gvFiles.SpellChecker_Dic_File;
   LInstance.GrammarPath := gvFiles.SpellChecker_Aff_File;
   LInstance.Load;
end;

procedure TFrmSystemComponentAssistance.Load_Tradution_File;
var
   LFileTradution: UnicodeString;
begin
   LFileTradution := gvFiles.Tradution_DevExpress_File;

   if FileUtils.Exists(LFileTradution) then
   begin
      cxLocalizer.FileName := LFileTradution;
      cxLocalizer.Active := True;
      cxLocalizer.Locale := 1046;
   end;
end;

procedure TFrmSystemComponentAssistance.TimerCallOutPopUpTimer(Sender: TObject);
begin
   DxCallOutPopup.Close;
   TimerCallOutPopUp.Enabled := False;
end;

end.
