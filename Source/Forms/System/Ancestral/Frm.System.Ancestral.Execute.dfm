inherited FrmSystemAncestralExecute: TFrmSystemAncestralExecute
  Caption = 'Ancestral Execute'
  ClientHeight = 406
  ClientWidth = 604
  ExplicitWidth = 620
  ExplicitHeight = 445
  TextHeight = 17
  inherited PnlMain: TdxPanel
    Width = 604
    Height = 406
    Color = clWhite
    ParentColor = True
    ExplicitWidth = 604
    ExplicitHeight = 406
    object StatusBar: TdxStatusBar
      Left = 0
      Top = 345
      Width = 604
      Height = 20
      Margins.Bottom = 5
      Color = clWhite
      Images = FrmSystemComponentAssistance.cxImageList16
      Panels = <
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          PanelStyle.Color = clWhite
          PanelStyle.ImageIndex = 0
          PanelStyle.Font.Charset = ANSI_CHARSET
          PanelStyle.Font.Color = clWindowText
          PanelStyle.Font.Height = -11
          PanelStyle.Font.Name = 'Segoe UI Semibold'
          PanelStyle.Font.Style = [fsBold]
          PanelStyle.ParentFont = False
          Width = 150
        end
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          PanelStyle.Color = clWhite
          PanelStyle.ImageIndex = 1
          PanelStyle.Font.Charset = ANSI_CHARSET
          PanelStyle.Font.Color = clWindowText
          PanelStyle.Font.Height = -12
          PanelStyle.Font.Name = 'Segoe UI Semibold'
          PanelStyle.Font.Style = [fsBold]
          PanelStyle.ParentFont = False
        end>
      PaintStyle = stpsUseLookAndFeel
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Whiteprint'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object PnlButtons: TdxPanel
      Left = 0
      Top = 365
      Width = 604
      Height = 41
      Align = alBottom
      Frame.Color = clWhite
      Frame.Borders = []
      Color = clWhite
      TabOrder = 1
      object PnlCancel: TPanel
        AlignWithMargins = True
        Left = 479
        Top = 5
        Width = 120
        Height = 31
        Margins.Left = 0
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alRight
        BevelOuter = bvNone
        Color = 16514043
        ParentBackground = False
        TabOrder = 1
        object BtCancel: TcxButton
          Left = 0
          Top = 0
          Width = 120
          Height = 31
          Align = alClient
          Caption = 'C&ancelar'
          Colors.Default = clSilver
          LookAndFeel.NativeStyle = False
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C00000023744558745469746C650043616E63656C3B53746F703B
            457869743B426172733B526962626F6E3B4C9696B20000009449444154785E95
            93410A834010047D5C2027F3093F104C6461C5CD37F312C5D3641AD27810BAF1
            5030CC587510B68B88EE3BDCFAA46236F0FB190E66CA7B12C9125EFE24F1771E
            584C9009234626230FE514F1F21B2E8E22A2650654A42999011951320322A265
            E0FFF6411301219B88935F49511129F3A622567611C8B3905DA462794FD693EC
            231B5C2C19795E78CE131CCC3FD2409CCC2C3656140000000049454E44AE4260
            82}
          SpeedButtonOptions.Transparent = True
          TabOrder = 0
          OnEnter = BtCancelEnter
          OnMouseEnter = BtCancelEnter
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = BtCancelClick
        end
      end
      object PnlConfirm: TPanel
        AlignWithMargins = True
        Left = 356
        Top = 5
        Width = 120
        Height = 31
        Margins.Left = 0
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alRight
        BevelOuter = bvNone
        Color = 16024898
        ParentBackground = False
        TabOrder = 0
        object BtConfirm: TcxButton
          Left = 0
          Top = 0
          Width = 120
          Height = 31
          Align = alClient
          Caption = '&Confirmar'
          Colors.Default = 12615680
          LookAndFeel.NativeStyle = False
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C00000021744558745469746C65004170706C793B4F4B3B436865
            636B3B426172733B526962626F6E3B6463C8680000009449444154785EC59341
            0A83400C4547BAEAB6E0097A912E2DB8D2BBB8F1201EC19BD82B74E3294AC159
            C52F2464182498B6D0C5239B798F309040445FF1FB40370E4728787E14A8C004
            2EBE80CA0B20F0008523A032CF3B08B97CF2C81BA97C054F703B220B229FC1CC
            8FDE1AB1E57C8316C424D2677295CB7B7FD0680498B206AC4894B53D0189BC40
            0D823720943C4DFE7F8D2B585260AAC36B7FD80000000049454E44AE426082}
          TabOrder = 0
          OnEnter = BtConfirmEnter
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = BtConfirmClick
        end
      end
    end
  end
  object dxUIAdornerManager: TdxUIAdornerManager
    Left = 391
    Top = 156
    object AdornerGuideFocus: TdxGuide
      TargetElementClassName = 'TdxAdornerTargetElementPath'
      BorderColor = 4227327
    end
    object AdornerGuidePersist: TdxGuide
      TargetElementClassName = 'TdxAdornerTargetElementPath'
      BorderColor = clWhite
    end
  end
end
