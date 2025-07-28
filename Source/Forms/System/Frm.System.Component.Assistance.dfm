object FrmSystemComponentAssistance: TFrmSystemComponentAssistance
  Left = 0
  Top = 0
  Caption = 'FrmSystemComponentAssistance'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object dxSkinController: TdxSkinController
    Kind = lfOffice11
    NativeStyle = False
    ScrollbarMode = sbmClassic
    SkinName = 'VisualStudio2013Light'
    RenderMode = rmGDI
    FormCorners = fcRounded
    Left = 40
    Top = 32
  end
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 56
    Top = 192
  end
end
