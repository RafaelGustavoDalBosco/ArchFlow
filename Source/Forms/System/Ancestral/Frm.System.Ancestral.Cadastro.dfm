inherited FrmSystemAncestralCadastro: TFrmSystemAncestralCadastro
  Caption = 'FrmSystemAncestralCadastro'
  ClientHeight = 606
  ClientWidth = 556
  ExplicitWidth = 572
  ExplicitHeight = 645
  TextHeight = 17
  inherited PnlMain: TdxPanel
    Width = 556
    Height = 606
    ExplicitWidth = 556
    ExplicitHeight = 606
    inherited StatusBar: TdxStatusBar
      Top = 545
      Width = 556
      ExplicitTop = 545
      ExplicitWidth = 556
    end
    inherited PnlButtons: TdxPanel
      Top = 565
      Width = 556
      ExplicitTop = 565
      ExplicitWidth = 556
      inherited PnlCancel: TPanel
        Left = 431
        ExplicitLeft = 431
      end
      inherited PnlConfirm: TPanel
        Left = 308
        ExplicitLeft = 308
      end
    end
    object PgMain: TcxPageControl
      AlignWithMargins = True
      Left = 3
      Top = 33
      Width = 550
      Height = 509
      Align = alClient
      TabOrder = 2
      Properties.ActivePage = TabSheetDados
      Properties.CustomButtons.Buttons = <>
      Properties.Images = FrmSystemComponentAssistance.cxImageList32
      LookAndFeel.NativeStyle = True
      ClientRectBottom = 505
      ClientRectLeft = 4
      ClientRectRight = 546
      ClientRectTop = 41
      object TabSheetDados: TcxTabSheet
        ImageIndex = 0
        object GrbAtivo: TcxGroupBox
          Left = 47
          Top = 0
          Caption = 'Ativo'
          ParentFont = False
          Style.BorderColor = clWhite
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.IsFontAssigned = True
          StyleDisabled.BorderStyle = ebsNone
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Height = 62
          Width = 82
          object TSActive: TdxToggleSwitch
            Left = 4
            Top = 15
            Align = alClient
            Checked = True
            Style.LookAndFeel.NativeStyle = False
            Style.TransparentBorder = False
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.NativeStyle = False
            StyleReadOnly.LookAndFeel.NativeStyle = False
            TabOrder = 0
          end
        end
        object GrbID: TcxGroupBox
          Left = 0
          Top = 0
          Caption = 'ID'
          ParentFont = False
          Style.BorderColor = clWhite
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.IsFontAssigned = True
          StyleDisabled.BorderStyle = ebsNone
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 1
          Height = 62
          Width = 45
          object EdtID: TcxTextEdit
            Left = 4
            Top = 15
            Align = alClient
            Enabled = False
            ParentFont = False
            Properties.MaxLength = 50
            Properties.ReadOnly = True
            Style.BorderStyle = ebsNone
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -13
            Style.Font.Name = 'Tahoma'
            Style.Font.Style = []
            Style.LookAndFeel.NativeStyle = False
            Style.IsFontAssigned = True
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleFocused.BorderStyle = ebsNone
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleHot.BorderStyle = ebsNone
            StyleHot.LookAndFeel.NativeStyle = False
            StyleReadOnly.LookAndFeel.NativeStyle = False
            TabOrder = 0
            TextHint = '< nome do banco de dados >'
            Width = 37
          end
        end
      end
      object TabSheetHistoricChanges: TcxTabSheet
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object TvcHistoricChanges: TdxTreeViewControl
          Left = 0
          Top = 0
          Width = 542
          Height = 464
          Align = alClient
          BorderStyle = cxcbsNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          LookAndFeel.Kind = lfOffice11
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'DevExpressStyle'
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object PnlHeader: TPanel
      Left = 0
      Top = 0
      Width = 556
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      Caption = '[STATUS FORM]'
      Color = 8236425
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = 8388672
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      object BtHelp: TcxButton
        Left = 516
        Top = 0
        Width = 40
        Height = 30
        Align = alRight
        Colors.Default = 12615680
        LookAndFeel.NativeStyle = False
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000028744558745469746C6500446F63756D656E746174696F
          6E3B48656C703B5175657374696F6E3B496E6465783B6F3C3577000000C94944
          4154785EAD93CD0D02211046A9655BF0CA916C0736C0C1C40A8CDB00D442016E
          ECC15ABCEDC944F41920910C21EB7AF89209CCFB323FA0628C5F0A215C9D738B
          B5F6398E6344C49C7157E797609E2F47EFDD628C895A6B51DC91436EE60A3C4D
          E74702BA2217A618E00AB04630B09F9E1B650FB9CC77BC97DA81550CA701031E
          80537CAAF3601513160C3C4AF13D19ECEA3C58C59A3AFD865C4D7D07DB33B825
          78A012C9A0B42009184930822D43FC45B0798DBD0A62738DF243EA1BC06C7ECA
          7FF94C9BBFF30B519A09830C3C3C3A0000000049454E44AE426082}
        TabOrder = 0
        OnEnter = BtHelpEnter
        OnMouseEnter = BtHelpEnter
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = BtHelpClick
      end
    end
  end
end
