inherited FrmSystemEngage: TFrmSystemEngage
  BorderIcons = [biSystemMenu]
  Caption = 'Inicializa'#231#227'o da aplica'#231#227'o'
  ClientHeight = 210
  ClientWidth = 544
  ExplicitWidth = 560
  ExplicitHeight = 249
  TextHeight = 17
  inherited PnlMain: TdxPanel
    Width = 544
    Height = 210
    ExplicitWidth = 544
    ExplicitHeight = 210
    inherited StatusBar: TdxStatusBar
      Top = 149
      Width = 544
      ExplicitTop = 149
      ExplicitWidth = 544
    end
    inherited PnlButtons: TdxPanel
      Top = 169
      Width = 544
      TabOrder = 6
      ExplicitTop = 169
      ExplicitWidth = 544
      inherited PnlCancel: TPanel
        Left = 419
        ExplicitLeft = 419
      end
      inherited PnlConfirm: TPanel
        Left = 296
        ExplicitLeft = 296
      end
    end
    object RgTypeConnection: TcxRadioGroup
      Left = 3
      Top = 6
      Caption = 'Tipo de Conex'#227'o'
      ParentFont = False
      Properties.Items = <
        item
          Caption = 'Remoto'
        end
        item
          Caption = 'Local'
        end>
      Properties.OnChange = RgTypeConnectionPropertiesChange
      ItemIndex = 0
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
      StyleDisabled.LookAndFeel.NativeStyle = False
      TabOrder = 0
      Height = 82
      Width = 126
    end
    object GrbServerPath: TcxGroupBox
      Left = 3
      Top = 91
      Caption = 'Server Path'
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
      TabOrder = 2
      Height = 57
      Width = 255
      object EdtServerPath: TcxTextEdit
        Left = 4
        Top = 15
        Align = alClient
        ParentFont = False
        Properties.MaxLength = 50
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
        TextHint = '< endere'#231'o do banco de dados >'
        ExplicitHeight = 21
        Width = 247
      end
    end
    object GrbNameDataBase: TcxGroupBox
      Left = 327
      Top = 91
      Caption = 'Nome banco de dados'
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
      TabOrder = 4
      Height = 57
      Width = 213
      object EdtNameDataBase: TcxTextEdit
        Left = 4
        Top = 15
        Align = alClient
        ParentFont = False
        Properties.MaxLength = 50
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
        ExplicitHeight = 21
        Width = 205
      end
    end
    object GrbCNPJ: TcxGroupBox
      Left = 131
      Top = 6
      Caption = 'CNPJ'
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
      Height = 57
      Width = 409
      object EdtCnpj: TcxMaskEdit
        Left = 4
        Top = 15
        Align = alLeft
        Properties.MaskKind = emkRegExprEx
        TabOrder = 0
        ExplicitHeight = 21
        Width = 157
      end
      object BtDownloadFromServer: TcxButton
        Left = 170
        Top = 15
        Width = 235
        Height = 26
        Align = alRight
        Caption = 'Baixar do servidor usando o CNPJ'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
          63653D227072657365727665223E2E5265647B66696C6C3A234431314331433B
          7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A2337323732
          37323B7D262331333B262331303B2623393B2E426C75657B66696C6C3A233131
          373744373B7D262331333B262331303B2623393B2E477265656E7B66696C6C3A
          233033394332333B7D262331333B262331303B2623393B2E59656C6C6F777B66
          696C6C3A234646423131353B7D262331333B262331303B2623393B2E57686974
          657B66696C6C3A234646464646463B7D262331333B262331303B2623393B2E73
          74307B6F7061636974793A302E353B7D262331333B262331303B2623393B2E73
          74317B6F7061636974793A302E37353B7D262331333B262331303B2623393B2E
          7374327B6F7061636974793A302E32353B7D3C2F7374796C653E0D0A3C672069
          643D224C6F77496D706F7274616E6365223E0D0A09093C706F6C79676F6E2063
          6C6173733D22426C75652220706F696E74733D2231382C32302E332031382C34
          2031342C342031342C32302E3320362C31322E3320362C31382031362C323820
          32362C31382032362C31322E33202623393B222F3E0D0A093C2F673E0D0A3C2F
          7376673E0D0A}
        TabOrder = 1
      end
    end
    object CxImgInfo: TcxImage
      Left = 131
      Top = 69
      Picture.Data = {
        0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
        2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
        6F6E3D22312E31222069643D224C61796572312220786D6C6E733D2268747470
        3A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A786C
        696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C696E
        6B2220783D223070782220793D22307078222076696577426F783D2230203020
        333220333222207374796C653D22656E61626C652D6261636B67726F756E643A
        6E6577203020302033322033323B2220786D6C3A73706163653D227072657365
        727665223E262331333B262331303B20203C7374796C6520747970653D227465
        78742F6373732220786D6C3A73706163653D227072657365727665223E2E426C
        7565262331333B262331303B202020207B262331333B262331303B2020202020
        2066696C6C3A233131373744373B262331333B262331303B202020202020666F
        6E742D66616D696C793A2661706F733B64782D666F6E742D69636F6E73266170
        6F733B3B262331333B262331303B202020202020666F6E742D73697A653A3332
        70783B262331333B262331303B202020207D262331333B262331303B20203C2F
        7374796C653E0D0A3C7465787420783D22302220793D2233322220636C617373
        3D22426C7565223EEF85A73C2F746578743E0D0A3C2F7376673E0D0A}
      Properties.ReadOnly = True
      Style.BorderStyle = ebsNone
      StyleFocused.BorderStyle = ebsNone
      StyleHot.BorderStyle = ebsNone
      TabOrder = 7
      Height = 19
      Width = 33
    end
    object LblInfoCNPJ: TcxLabel
      Left = 169
      Top = 64
      Caption = 
        'Caso seja escolhida a op'#231#227'o local, o CNPJ posteriormente ser'#225' va' +
        'lidado!'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI Semibold'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
    end
    object GrbPorta: TcxGroupBox
      Left = 260
      Top = 91
      Caption = 'Porta'
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
      TabOrder = 3
      Height = 57
      Width = 65
      object EdtPorta: TcxSpinEdit
        Left = 4
        Top = 15
        Align = alClient
        Properties.MaxValue = 5450.000000000000000000
        Properties.MinValue = 5432.000000000000000000
        TabOrder = 0
        Value = 5432
        ExplicitHeight = 21
        Width = 57
      end
    end
  end
  inherited dxUIAdornerManager: TdxUIAdornerManager
    Left = 367
    Top = 412
  end
  object dxSkinController: TdxSkinController
    Kind = lfOffice11
    NativeStyle = False
    ScrollbarMode = sbmClassic
    SkinName = 'WXI'
    RenderMode = rmGDI
    FormCorners = fcRounded
    Left = 600
    Top = 152
  end
end
