unit Frm.System.Ancestral.Cadastro;

interface

uses

{$REGION '| USES |'}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm.System.Ancestral.Execute,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinWhiteprint, dxSkinWXI, cxGeometry, dxFramedControl, Vcl.Menus,
  cxClasses, dxUIAdorners, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxStatusBar,
  dxPanel, cxContainer, cxEdit, cxTextEdit, cxGroupBox, cxCheckBox,
  dxToggleSwitch, dxBarBuiltInMenu, dxTreeView, cxPC, App.Objects.Entity.Default;
{$ENDREGION}

type

   TFrmSystemAncestralCadastro = class(TFrmSystemAncestralExecute)
      PgMain: TcxPageControl;
      TabSheetDados: TcxTabSheet;
      TabSheetHistoricChanges: TcxTabSheet;
      TvcHistoricChanges: TdxTreeViewControl;
      GrbAtivo: TcxGroupBox;
      TSActive: TdxToggleSwitch;
      GrbID: TcxGroupBox;
      EdtID: TcxTextEdit;
      PnlHeader: TPanel;
      BtHelp: TcxButton;
      procedure BtHelpEnter(Sender: TObject);
      procedure BtHelpClick(Sender: TObject);
   private
      FID: Int64;
      FActive: Boolean;
      FEntity: TEntityCommon;
      procedure SetActive(const Value: Boolean);
      procedure SetID(const Value: Int64);
      procedure SetEntity(const Value: TEntityCommon);

      function GetID: Int64;
      function GetActive: Boolean;
      function GetEntity: TEntityCommon;
   strict private
      /// <summary>
      ///    Mostra um texto de ajuda ao clicar no botão de interrogação da tela
      /// </summary>
      procedure Show_Helper;
   strict protected
      /// <summary>
      ///    Pega as properties da Entidade e coloca no Form
      /// </summary>
      procedure Assign_Properties_Self; virtual;

      /// <summary>
      ///    Pega as properties do Form e coloca na Entidade
      /// </summary>
      procedure Assign_Properties_Entity; virtual;

      /// <summary>
      ///    Mostra a mensagem de ajuda da tela
      /// </summary>
      /// <remarks>
      ///    Método virtual [será mostrado mensagem padrão até que seja usado o override]
      /// </remarks>
      function Assign_Helper: UnicodeString; virtual;

      /// <summary>
      ///    Método virtual abstrato para vincular a Classe do TEntity ao Form
      /// </summary>
      function Get_Entity_Owner_Class: TClass; virtual; abstract;

      /// <summary>
      ///   Valida as informações digitadas no form
      /// </summary>
      function Validate_Self: Boolean; override;

      /// <summary>
      ///    Persiste as informações no Banco de Dados/Other
      /// </summary>
      procedure Persist_Self; override;
   public
      property Entity: TEntityCommon read GetEntity write SetEntity;
      property ID: Int64 read GetID write SetID;
      property Active: Boolean read GetActive write SetActive;
   end;

var
  FrmSystemAncestralCadastro: TFrmSystemAncestralCadastro;

implementation

{$R *.dfm}

uses
   App.Common.Utils, Frm.System.Component.Assistance;

{ TFrmSystemAncestralCadastro }

function TFrmSystemAncestralCadastro.Assign_Helper: UnicodeString;
begin
   Result := 'Not Implemented';
end;

procedure TFrmSystemAncestralCadastro.Assign_Properties_Entity;
begin
   Entity.Id := ID;
   Entity.Active := Active;
end;

procedure TFrmSystemAncestralCadastro.Assign_Properties_Self;
begin
   EdtID.Text := Entity.Id.ToString;
   TSActive.Checked := Entity.Active;
end;

procedure TFrmSystemAncestralCadastro.BtHelpClick(Sender: TObject);
begin
   inherited;
   Show_Helper;
end;

procedure TFrmSystemAncestralCadastro.BtHelpEnter(Sender: TObject);
begin
   SetTextStatusBar('Help', 'Mostra informações de ajuda sobre esta tela')
end;

function TFrmSystemAncestralCadastro.GetActive: Boolean;
begin
   Result := TSActive.Checked;
end;

function TFrmSystemAncestralCadastro.GetEntity: TEntityCommon;
begin
   if (FEntity = nil) then
      FEntity := Get_Entity_Owner_Class.NewInstance as TEntityCommon;

   Result := FEntity;
end;

function TFrmSystemAncestralCadastro.GetID: Int64;
begin
   Result := VarConvUtils.StringToInt64(EdtID.Text);
end;

procedure TFrmSystemAncestralCadastro.Persist_Self;
begin
   inherited;
end;

procedure TFrmSystemAncestralCadastro.SetActive(const Value: Boolean);
begin
   FActive := Value;
end;

procedure TFrmSystemAncestralCadastro.SetEntity(const Value: TEntityCommon);
begin
   FEntity := Value;
end;

procedure TFrmSystemAncestralCadastro.SetID(const Value: Int64);
begin
   FID := Value;
end;

procedure TFrmSystemAncestralCadastro.Show_Helper;
begin
   MessageUtils.Show_Info(Assign_Helper);
end;

function TFrmSystemAncestralCadastro.Validate_Self: Boolean;
begin
   if (ID <= 0) then
   begin
      MessageUtils.Show_Warn('Não foi possível obter o ID deste cadastro!');
      Exit(False);
   end;

   Result := True;
end;

end.
