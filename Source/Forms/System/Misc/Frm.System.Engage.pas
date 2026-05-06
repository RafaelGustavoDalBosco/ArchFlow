unit Frm.System.Engage;

interface

uses

{$REGION '| USES |'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm.System.Ancestral.Execute,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinWhiteprint, dxSkinWXI, cxGeometry, dxFramedControl, Vcl.Menus,
  cxClasses, dxUIAdorners, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxStatusBar,
  dxPanel, cxContainer, cxEdit, cxTextEdit, cxGroupBox, cxRadioGroup, cxMaskEdit,
  dxGDIPlusClasses, cxImage, cxLabel, cxSpinEdit, App.System.Types, dxCore,
  dxSkinsForm;
{$ENDREGION}

type

   TFrmSystemEngage = class(TFrmSystemAncestralExecute)
      RgTypeConnection: TcxRadioGroup;
      GrbServerPath: TcxGroupBox;
      EdtServerPath: TcxTextEdit;
      GrbNameDataBase: TcxGroupBox;
      EdtNameDataBase: TcxTextEdit;
      GrbCNPJ: TcxGroupBox;
      EdtCnpj: TcxMaskEdit;
      BtDownloadFromServer: TcxButton;
      CxImgInfo: TcxImage;
      LblInfoCNPJ: TcxLabel;
      GrbPorta: TcxGroupBox;
      EdtPorta: TcxSpinEdit;
      dxSkinController: TdxSkinController;
      procedure RgTypeConnectionPropertiesChange(Sender: TObject);
   private
      FPort: SmallInt;
      FDataBaseName: UnicodeString;
      FServer: UnicodeString;
      FCNPJ: UnicodeString;
      FTypeConnection: TTypeConnection;
      FDataBasePassWord: UnicodeString;
      FDataBaseUser: UnicodeString;
      procedure SetDataBaseName(const Value: UnicodeString);
      procedure SetPort(const Value: SmallInt);
      procedure SetServer(const Value: UnicodeString);
      procedure SetCNPJ(const Value: UnicodeString);
      procedure SetTypeConnection(const Value: TTypeConnection);
      procedure SetDataBasePassWord(const Value: UnicodeString);
      procedure SetDataBaseUser(const Value: UnicodeString);

      function GetServer: UnicodeString;
      function GetDataBaseName: UnicodeString;
      function GetPort: SmallInt;
      function GetTypeConnection: TTypeConnection;
      function GetCNPJ: UnicodeString;
   protected
      /// <summary>
      ///    Realiza o download das informações da empresa através da AWS S3
      /// </summary>
      procedure Download_From_Cloud;
   strict protected
      /// <summary>
      ///    Valida as informações digitadas no Form
      /// </summary>
      function Validate_Self: Boolean; override;
   public
      property Server: UnicodeString read GetServer write SetServer;
      property DataBaseName: UnicodeString read GetDataBaseName write SetDataBaseName;
      property Port: SmallInt read GetPort write SetPort;
      property CNPJ: UnicodeString read GetCNPJ write SetCNPJ;
      property TypeConnection: TTypeConnection read GetTypeConnection write SetTypeConnection;
      property DataBaseUser: UnicodeString read FDataBaseUser write SetDataBaseUser;
      property DataBasePassWord: UnicodeString read FDataBasePassWord write SetDataBasePassWord;
   end;

var
  FrmSystemEngage: TFrmSystemEngage;

implementation

{$R *.dfm}

uses App.System.Manager.Company.Cloud, App.Objects.Common, App.Common.Utils;

{ TFrmSystemMiscEngage }

procedure TFrmSystemEngage.Download_From_Cloud;
var
   LManager: TManagerCompanyCloud;
   LCompanyCloud: TCompanyCloud;
begin
   if (not CNPJ.IsEmpty) and (TypeConnection = tcRemote) then
   begin
      LManager := TManagerCompanyCloud.Create(CNPJ);
      try
         LCompanyCloud := LManager.Get_Company_Cloud;

         if (LCompanyCloud <> nil) then
         begin
            EdtServerPath.Text := LCompanyCloud.Server;
            EdtNameDataBase.Text := LCompanyCloud.DataBase_Name;
            EdtPorta.Text := LCompanyCloud.Port.ToString;
            FDataBasePassWord := LCompanyCloud.DataBase_PassWord;
            FDataBaseName := LCompanyCloud.DataBase_User;
            LblInfoCNPJ.Caption := Format('Dados da Empresa %s carregados com sucesso!', [LCompanyCloud.RazaoSocial]);
            LblInfoCNPJ.Style.Font.Color := clWebGreen;
         end;
      finally
         FreeAndNil(LManager);
      end;
   end;
end;

function TFrmSystemEngage.GetCNPJ: UnicodeString;
begin
   Result := EdtCnpj.EditText;
end;

function TFrmSystemEngage.GetDataBaseName: UnicodeString;
begin
   Result := EdtNameDataBase.Text;
end;

function TFrmSystemEngage.GetPort: SmallInt;
begin
   Result := EdtPorta.Value;
end;

function TFrmSystemEngage.GetServer: UnicodeString;
begin
   Result := EdtServerPath.Text;
end;

function TFrmSystemEngage.GetTypeConnection: TTypeConnection;
begin
   Result := TTypeConnection(RgTypeConnection.ItemIndex);
end;

procedure TFrmSystemEngage.RgTypeConnectionPropertiesChange(Sender: TObject);
begin
   inherited;
   if (TypeConnection = tcLocal) then
   begin
      EdtServerPath.Text := '127.0.0.1';
      EdtNameDataBase.Text := 'hope';
   end;
end;

procedure TFrmSystemEngage.SetCNPJ(const Value: UnicodeString);
begin
   FCNPJ := Value;
end;

procedure TFrmSystemEngage.SetDataBaseName(const Value: UnicodeString);
begin
   FDataBaseName := Value;
end;

procedure TFrmSystemEngage.SetDataBasePassWord(const Value: UnicodeString);
begin
   FDataBasePassWord := Value;
end;

procedure TFrmSystemEngage.SetDataBaseUser(const Value: UnicodeString);
begin
   FDataBaseUser := Value;
end;

procedure TFrmSystemEngage.SetPort(const Value: SmallInt);
begin
   FPort := Value;
end;

procedure TFrmSystemEngage.SetServer(const Value: UnicodeString);
begin
   FServer := Value;
end;

procedure TFrmSystemEngage.SetTypeConnection(const Value: TTypeConnection);
begin
   FTypeConnection := Value;
end;

function TFrmSystemEngage.Validate_Self: Boolean;
begin
   if (DataBaseName.IsEmpty) then
   begin
      CompUtils.Show_Warn_And_Focus(GrbNameDataBase);
      Exit(False);
   end;

   if (Server.IsEmpty) then
   begin
      CompUtils.Show_Warn_And_Focus(GrbServerPath);
      Exit(False);
   end;

   Result := True;
end;

end.
