object frmPrincipal: TfrmPrincipal
  Left = 177
  Top = 111
  Caption = 'Prova Tecnica'
  ClientHeight = 492
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu_Principal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu_Principal: TMainMenu
    Left = 216
    Top = 32
    object Vendas1: TMenuItem
      Caption = '&Pedido no Balc'#227'o'
      object PDV1: TMenuItem
        Caption = 'Fazer Pedido'
        ShortCut = 113
        OnClick = PDV1Click
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sai&r'
      ShortCut = 16467
      OnClick = Sair1Click
    end
  end
end
