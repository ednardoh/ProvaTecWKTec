unit uPrincipalVIEW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Menus, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu_Principal: TMainMenu;
    Vendas1: TMenuItem;
    PDV1: TMenuItem;
    Sair1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PDV1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LCodigo,
    LNome,
    LCodBarra,
    LPrcProd : string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

 {$R *.dfm}

uses UConexaoBDpas, UPedidoDeVendaVIEW;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.messageBox('Deseja Realmente sair do Sistema?','Confirmação',mb_YesNo+mb_IconInformation+mb_DefButton2) = IdYes then
    begin
      Application.Terminate;
    end
  else
    Action := canone;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(pchar(ExtractFilePath(Application.ExeName) + 'ConfigDB.ini')) then
    begin
      frmConectaDB := TfrmConectaDB.create(Self);
      frmConectaDB.Showmodal;
      close;
    end;
end;

procedure TfrmPrincipal.PDV1Click(Sender: TObject);
begin
  frmMov_PEDVendas := TfrmMov_PEDVendas.create(Self);
  frmMov_PEDVendas.ShowModal;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
 close;
end;

end.
