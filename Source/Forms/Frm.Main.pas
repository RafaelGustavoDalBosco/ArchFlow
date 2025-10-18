unit Frm.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm.System.Ancestral, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinWhiteprint, dxSkinWXI, cxGeometry, dxFramedControl, dxPanel;

type

  TFrmMain = class(TFrmSystemAncestral)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

end.
