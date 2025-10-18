unit Frm.System.Application.Enter;

interface

uses

{$REGION '| USES '|'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm.System.Ancestral, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinWhiteprint, dxSkinWXI, cxGeometry, dxFramedControl, dxPanel,
  cxContainer, cxEdit, Vcl.Menus, cxLabel, dxGDIPlusClasses, cxImage,
  Vcl.StdCtrls, cxButtons, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxTextEdit;
{$ENDREGION}

type

   TFrmSystemApplicationEnter = class(TFrmSystemAncestral)
      dxPanelCredentials: TdxPanel;
      EdtUsuario: TcxTextEdit;
      EdtPassWord: TcxTextEdit;
      CbEmpresas: TcxComboBox;
      ChbRemeberUser: TcxCheckBox;
      BtEntrar: TcxButton;
      CxImgVersion: TcxImage;
      LblVersion: TcxLabel;
      LblSair: TcxLabel;
      dxPanelImagem: TdxPanel;
      CxImgLogo: TcxImage;
   private
      FIdEmpresa: Int64;
      FPassWord: UnicodeString;
      FUserName: UnicodeString;
      procedure SetIdEmpresa(const Value: Int64);
      procedure SetPassWord(const Value: UnicodeString);
      procedure SetUserName(const Value: UnicodeString);

      function GetUserName: UnicodeString;
      function GetPassWord: UnicodeString;
      function GetIdEmpresa: Int64;
   public
      property UserName: UnicodeString read GetUserName write SetUserName;
      property PassWord: UnicodeString read GetPassWord write SetPassWord;
      property IdEmpresa: Int64 read GetIdEmpresa write SetIdEmpresa;
   end;

var
  FrmSystemApplicationEnter: TFrmSystemApplicationEnter;

implementation

{$R *.dfm}

uses App.Common.Utils;

{ TFrmSystemApplicationEnter }

function TFrmSystemApplicationEnter.GetIdEmpresa: Int64;
begin
   Result := CompUtils.Get_Object_Integer_From_ComboBox(CbEmpresas);
end;

function TFrmSystemApplicationEnter.GetPassWord: UnicodeString;
begin
   Result := EdtPassWord.Text;
end;

function TFrmSystemApplicationEnter.GetUserName: UnicodeString;
begin
   Result := EdtUsuario.Text;
end;

procedure TFrmSystemApplicationEnter.SetIdEmpresa(const Value: Int64);
begin
   FIdEmpresa := Value;
end;

procedure TFrmSystemApplicationEnter.SetPassWord(const Value: UnicodeString);
begin
   FPassWord := Value;
end;

procedure TFrmSystemApplicationEnter.SetUserName(const Value: UnicodeString);
begin
   FUserName := Value;
end;

end.
