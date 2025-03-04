program Pedidos;

uses
  Forms,
  UConecta in 'Conexao\UConecta.pas',
  uConexao in 'Conexao\uConexao.pas',
  UConexaoBDpas in 'Conexao\UConexaoBDpas.pas' {frmConectaDB},
  uEnumerado in 'Model\uEnumerado.pas',
  uClienteDAO in 'DAO\uClienteDAO.pas',
  uSistemaControl in 'Controller\uSistemaControl.pas',
  uClienteControl in 'Controller\uClienteControl.pas',
  uProdutoModel in 'Model\uProdutoModel.pas',
  uProdutoDAO in 'DAO\uProdutoDAO.pas',
  uProdutoControl in 'Controller\uProdutoControl.pas',
  uPesquisaVIEW in 'View\uPesquisaVIEW.pas' {FrmPesquisa},
  UPedidoDeVendaVIEW in 'View\UPedidoDeVendaVIEW.pas' {frmMov_PEDVendas},
  uPedidovendaModel in 'Model\uPedidovendaModel.pas',
  uPedidoXProdutosModel in 'Model\uPedidoXProdutosModel.pas',
  uPedidovendaDAO in 'DAO\uPedidovendaDAO.pas',
  uPedidoXProdutosDAO in 'DAO\uPedidoXProdutosDAO.pas',
  uPedidovendaControl in 'Controller\uPedidovendaControl.pas',
  uPedidoXProdutosControl in 'Controller\uPedidoXProdutosControl.pas',
  uPrintPEDVIEW in 'View\uPrintPEDVIEW.pas' {frm_PrintPED},
  uClienteModel in 'Model\uClienteModel.pas',
  uPrincipalVIEW in 'View\uPrincipalVIEW.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
