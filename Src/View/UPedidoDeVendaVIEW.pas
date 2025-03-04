unit UPedidoDeVendaVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Buttons, Datasnap.DBClient,
  uPesquisaVIEW, uPedidovendaControl, uPedidoXProdutosControl, uClienteControl,
  uProdutoControl, uEnumerado, math;

type
  TfrmMov_PEDVendas = class(TForm)
    Panel1: TPanel;
    pn_Top: TPanel;
    pn_Botton: TPanel;
    pn_Grid: TPanel;
    Panel7: TPanel;
    Shape1: TShape;
    pn_left: TPanel;
    GRD_Produtos: TDBGrid;
    lblMessagem: TLabel;
    edt_CodigoProd: TEdit;
    Edt_Qtde: TEdit;
    Edt_PrecProd: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    ds_PedVenda: TDataSource;
    Panel5: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    EDT_Numpedido: TEdit;
    EDT_DTEMISSAO: TDateTimePicker;
    EDT_CodCliente: TEdit;
    EDT_NomeCliente: TEdit;
    Label1: TLabel;
    QryPedproduto: TClientDataSet;
    QryPedprodutoCodProduto: TStringField;
    QryPedprodutoDescrProduto: TStringField;
    QryPedprodutoQuantidade: TFloatField;
    QryPedprodutoValor_Unitario: TFloatField;
    Label5: TLabel;
    EDT_ValorTotal: TEdit;
    EDT_DescrProduto: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Panel12: TPanel;
    Label7: TLabel;
    EdtTotVenda: TEdit;
    Panel13: TPanel;
    Panel14: TPanel;
    dsRet_Pedido: TDataSource;
    ds_ConsPedido: TDataSource;
    ds_ConsCliente: TDataSource;
    ds_ConsProduto: TDataSource;
    QryPedprodutoID: TIntegerField;
    pn_TopButton: TPanel;
    BTN_Inserir: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    QryPedprodutoValor_Total: TFloatField;
    Label19: TLabel;
    Label20: TLabel;
    QryAux: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_CodigoProdKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_QtdeKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_PrecProdKeyPress(Sender: TObject; var Key: Char);
    procedure EDT_DTEMISSAOEnter(Sender: TObject);
    procedure EDT_DTEMISSAOExit(Sender: TObject);
    procedure EDT_DTEMISSAOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDT_CodClienteEnter(Sender: TObject);
    procedure EDT_CodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EDT_CodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CodigoProdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edt_QtdeExit(Sender: TObject);
    procedure BTN_InserirClick(Sender: TObject);
    procedure EDT_CodClienteExit(Sender: TObject);
    procedure edt_CodigoProdExit(Sender: TObject);
    procedure Edt_QtdeChange(Sender: TObject);
    procedure QryPedprodutoAfterPost(DataSet: TDataSet);
    procedure GRD_ProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure QryPedprodutoAfterDelete(DataSet: TDataSet);
    procedure Edt_PrecProdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GRD_ProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GRD_ProdutosColExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GRD_ProdutosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    sCodCupom : String;
    strStatusPDV : String;
    statusGravaPed: string;
    statusGridPed: string;
    PedidovendaCab: TPedidovendaControl;
    ProdutosPedido: TPedidoXProdutosControl;
    Clientes: TClienteControl;
    Produtos: TProdutoControl;
    procedure MenssagemPDV(pMenssagem: string);
    procedure AbrePedidoVenda;
    procedure ConsultaClientes;
    procedure ConsultaProdutos;
    procedure CalculaValor;
    Procedure Memo_Print(Conteudo:TStrings);
    procedure Limpacampo;
    procedure ConsultaPedido;
    procedure CancelaPedido;
    procedure ImprimirPedido;
    procedure AbreAqrFilePed;
    function SomaValorTotal : Real;
    function PadC(S: String; I: Integer): String;
    function Espaco(Tamanho: Integer): string;
    function FormataMonetario(sValor: string): string;
    function ValidaCodProduto(ACodP: string) : boolean;
    function ValidaCodCliente(ACodCli: string): boolean;
    function ColocaTextoEsq(Texto: string; Qtd: integer; Ch: Char): string;
    function ColocaTextoDir(Texto: string; Qtd: integer; Ch: Char): string;
  public
    { Public declarations }
  end;

var
  frmMov_PEDVendas: TfrmMov_PEDVendas;

implementation

Uses Printers, UPrincipalVIEW, uPrintPEDVIEW;

{$R *.dfm}

procedure TfrmMov_PEDVendas.AbreAqrFilePed;
begin
  frm_PrintPED := Tfrm_PrintPED.create(Self);
  frm_PrintPED.RCE_Relatorio.Lines.Clear;
  frm_PrintPED.RCE_Relatorio.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pedidovenda.TXT');
  frm_PrintPED.Showmodal;
end;

procedure TfrmMov_PEDVendas.AbrePedidoVenda;
begin
  if statusGravaPed <> 'dsInsert' then
    begin
      EDT_CodCliente.Clear;
      EDT_NomeCliente.Clear;
      EdtTotVenda.Text   :='0,00';
      EDT_Numpedido.Text := '000000';
      EDT_DTEMISSAO.Date := Now();
      sCodCupom          :='';
      statusGravaPed     := 'dsInsert';
      statusGridPed      := 'dsInsert';
      BTN_Inserir.Caption := 'Inserir Produto';
      MenssagemPDV('PEDIDO EM MOVIMENTA��O');
      EDT_DTEMISSAO.SetFocus;
      strStatusPDV :='EM PROCESSO DE MOVIMENTACAO';
      QryPedproduto.Close;
      QryPedproduto.CreateDataSet;
    end
  else
    begin
      Application.MessageBox(pchar('Pedido j� est� em modo de Inser��o.: '), 'Aten��o', MB_ICONEXCLAMATION + MB_OK);
      exit;
    end;
end;

procedure TfrmMov_PEDVendas.BTN_InserirClick(Sender: TObject);
begin
  try
    if statusGridPed = 'dsInsert' then
      begin
        QryPedproduto.Insert;
        QryPedprodutoCodProduto.AsString     := edt_CodigoProd.Text;
        QryPedprodutoDescrProduto.AsString   := EDT_DescrProduto.Text;
        QryPedprodutoQuantidade.AsString     := Edt_Qtde.Text;
        QryPedprodutoValor_Unitario.AsString := Edt_PrecProd.Text;
        QryPedprodutoValor_Total.Value       := FormataMonetario(EDT_ValorTotal.Text).ToDouble;
        QryPedproduto.Post;
        Limpacampo;
      end
    else
      if statusGridPed = 'dsEdit' then
        begin
          QryPedproduto.IndexFieldNames := 'CodProduto';
          if QryPedproduto.FindKey([edt_CodigoProd.Text]) then
            begin
              QryPedproduto.Edit;
              QryPedprodutoCodProduto.AsString     := edt_CodigoProd.Text;
              QryPedprodutoDescrProduto.AsString   := EDT_DescrProduto.Text;
              QryPedprodutoQuantidade.AsString     := Edt_Qtde.Text;
              QryPedprodutoValor_Unitario.AsString := Edt_PrecProd.Text;
              QryPedprodutoValor_Total.Value       := FormataMonetario(EDT_ValorTotal.Text).ToDouble;
              QryPedproduto.Post;
              statusGridPed  := 'dsInsert';
              BTN_Inserir.Caption := 'Inserir Produto';
            end;
          Limpacampo;
        end;
  except on e : exception do
    begin
      Application.MessageBox(pchar('Ocorreu erro Inesperado na Iser��o do Produto. Erro: '+e.Message), 'Erro', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TfrmMov_PEDVendas.CalculaValor;
var
  fPrecoVenda, fQtde, fValorTot : Double;
  fFormataValor : string;
begin
  try
    fPrecoVenda := 0;
    fQtde       := 0;
    fValorTot   := 0;
    fFormataValor :='';

    if trim(Edt_Qtde.Text) = '' then
      begin
        Showmessage('Qtde n�o pode ser Nulo, Favor prencha o campo da Qtde.');
        Edt_Qtde.SetFocus;
      end
    else
      begin
        fPrecoVenda   := StrToFloat(Edt_PrecProd.Text);
        fQtde         := StrToFloat(Edt_Qtde.Text);
        fValorTot     := (fQtde * fPrecoVenda);
        Edt_Qtde.Text := FormatFloat(',0.00',StrToFloat(Edt_Qtde.Text));
        EDT_ValorTotal.Text := FormatFloat(',0.00',fValorTot);
      end;
  except
  end;
end;

procedure TfrmMov_PEDVendas.CancelaPedido;
var
  intVal: Integer;
begin
  try
    PedidovendaCab := TPedidovendaControl.Create;
    ProdutosPedido := TPedidoXProdutosControl.Create;
    if Application.messageBox('Confirma o Cancelamento do Pedido?','Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES then
      begin
        intVal := StrToInt(EDT_Numpedido.Text);
        //excluindo(Cancelando) os produtos do pedido, para fazer outro
        ProdutosPedido.PedidoXProdutosModel.Acao := uEnumerado.tacExcluir;
        ProdutosPedido.PedidoXProdutosModel.NUMPEDIDO := intVal;
        ProdutosPedido.PedidoXProdutosModel.Salvar;

        //excluindo(Cancelando) o cabe�alho do pedido para fazer outro
        PedidovendaCab.PedidovendaModel.Acao := uEnumerado.tacExcluir;
        PedidovendaCab.PedidovendaModel.NUMPEDIDO := intVal;
        PedidovendaCab.PedidovendaModel.Salvar;

        Showmessage('Pedido cancelado com sucesso..');
        strStatusPDV :='ABRIR PEDIDO';
        MenssagemPDV('F3 - ABRIR PEDIDO.');
        statusGravaPed := 'dsBrowse';
        EDT_CodCliente.Clear;
        EDT_NomeCliente.Clear;
        EdtTotVenda.Text    :='0,00';
        EDT_Numpedido.Text  := '000000';
        EDT_DTEMISSAO.Date  := Now();
        sCodCupom           :='';
        statusGravaPed      := 'dsBrowse';
        BTN_Inserir.Caption := 'Inserir Produto';
        QryPedproduto.Close;
        QryPedproduto.CreateDataSet;
      end;
  finally
    PedidovendaCab.Free;
    ProdutosPedido.Free;
  end;
end;

function TfrmMov_PEDVendas.ColocaTextoDir(Texto: string; Qtd: integer;
  Ch: Char): string;
var
  x: integer;
  str: string;
begin
  if  Length(Texto) > Qtd then
      Result := Copy( Texto, (Length(Texto)-Qtd) + 1, Length(Texto) )
  else
    begin
      str := '';
      for x := Length(Texto) to Qtd - 1 do
      begin
        str := str + Ch;
      end;
      Result := str + Texto;
    end
end;

function TfrmMov_PEDVendas.ColocaTextoEsq(Texto: string; Qtd: integer;
  Ch: Char): string;
var
  x: integer;
begin
  if  Ch = '' then
      Ch := Chr( 32 ); { Espa�o }

  if  Length(Texto) > Qtd then
      Result := Copy( Texto, 0, Qtd )
  else
    begin
      x := Length( Texto );
      for  Qtd := x to Qtd-1 do
      begin
        Texto := Texto + Ch;
      end;
      Result := Texto;
    end;
end;

procedure TfrmMov_PEDVendas.ConsultaClientes;
begin
  if strStatusPDV ='EM PROCESSO DE MOVIMENTACAO' then
    begin
      FrmPesquisa := TFrmPesquisa.Create(Self);
      FrmPesquisa.gblNomeTabela :='clientes';
      FrmPesquisa.ShowModal;
      EDT_CodCliente.Text  := frmPrincipal.LCodigo;
      EDT_NomeCliente.Text := frmPrincipal.LNome;
    end
  else
    begin
      Showmessage('S� poder� consultar Clientes se estiver em precesso de Movimenta��o.');
    end;
end;

procedure TfrmMov_PEDVendas.ConsultaPedido;
var
  strNumpedido,
  strNumped: string;
begin
  try
    PedidovendaCab := TPedidovendaControl.Create;
    ProdutosPedido := TPedidoXProdutosControl.Create;
    Clientes       := TClienteControl.Create;
    Produtos       := TProdutoControl.Create;

    statusGravaPed := 'dsEdit';
    statusGridPed  := 'dsInsert';
    strNumpedido := InputBox('Digite aqui o N�mero do Pedido','Pedido','000000');
    strNumped := IntToStr(strNumpedido.ToInteger());
    ds_ConsPedido.DataSet := PedidovendaCab.Obter(strNumped);

    if ds_ConsPedido.DataSet.Eof then
      begin
        Showmessage('Pedido N�o encontrado.');
        exit;
      end
    else
      begin
        ds_ConsCliente.DataSet := Clientes.ClienteModel.ObterNomeCLI(ds_ConsPedido.DataSet.FieldByName('codigo_cliente').AsString);

        EDT_Numpedido.Text   := FormatFloat('000000',ds_ConsPedido.DataSet.FieldByName('numpedido').AsInteger);
        EDT_DTEMISSAO.Date   := ds_ConsPedido.DataSet.FieldByName('data_emissao').AsDateTime;
        EDT_CodCliente.Text  := ds_ConsPedido.DataSet.FieldByName('codigo_cliente').AsString;
        EDT_NomeCliente.Text := ds_ConsCliente.DataSet.FieldByName('nome').AsString;
        EdtTotVenda.Text     := FormatFloat(',0.00',ds_ConsPedido.DataSet.FieldByName('valor_total').AsFloat);
        QryPedproduto.EmptyDataSet;
        QryPedproduto.Close;
        QryPedproduto.Open;

        dsRet_Pedido.DataSet   := ProdutosPedido.Obter(strNumped);

        dsRet_Pedido.DataSet.First;
        while not dsRet_Pedido.DataSet.Eof do
          begin
            ds_ConsProduto.DataSet := Produtos.ProdutoModel.ObterProdDesc(dsRet_Pedido.DataSet.FieldByName('codigo_produto').AsString);

            QryPedproduto.Insert;
            QryPedprodutoID.AsInteger         := dsRet_Pedido.DataSet.FieldByName('id').AsInteger;
            QryPedprodutoCodProduto.Value     := dsRet_Pedido.DataSet.FieldByName('codigo_produto').AsString;
            QryPedprodutoDescrProduto.Value   := ds_ConsProduto.DataSet.FieldByName('descricao').AsString;
            QryPedprodutoQuantidade.Value     := dsRet_Pedido.DataSet.FieldByName('quantidade').AsFloat;
            QryPedprodutoValor_Unitario.Value := ds_ConsProduto.DataSet.FieldByName('preco_venda').AsFloat;
            QryPedprodutoValor_Total.Value    := (dsRet_Pedido.DataSet.FieldByName('quantidade').AsFloat*ds_ConsProduto.DataSet.FieldByName('preco_venda').AsFloat);
            QryPedproduto.Post;
            dsRet_Pedido.DataSet.Next;
          end;
      end;
    if Application.messageBox('Deseja Imprimir o Pedido agora ?','Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IdYes then
    begin
      ImprimirPedido;
    end;
  finally
    PedidovendaCab.Free;
    ProdutosPedido.Free;
    Clientes.Free;
    Produtos.Free;
  end;
end;

procedure TfrmMov_PEDVendas.ConsultaProdutos;
begin
  if strStatusPDV ='EM PROCESSO DE MOVIMENTACAO' then
    begin
      FrmPesquisa := TFrmPesquisa.Create(Self);
      FrmPesquisa.gblNomeTabela :='produtos';
      FrmPesquisa.ShowModal;
      edt_CodigoProd.Text   := frmPrincipal.LCodigo;
      EDT_DescrProduto.Text := frmPrincipal.LNome;
      Edt_PrecProd.Text     := frmPrincipal.LPrcProd;
    end
  else
    begin
      Showmessage('S� poder� consultar Clientes se estiver em precesso de Movimenta��o.');
    end;
end;

procedure TfrmMov_PEDVendas.EDT_CodClienteEnter(Sender: TObject);
begin
  TEdit(Sender).Color := clInfoBk;
  CalculaValor;
end;

procedure TfrmMov_PEDVendas.EDT_CodClienteExit(Sender: TObject);
begin
  if statusGravaPed = 'dsInsert' then
    begin
      if EDT_CodCliente.Text ='' then
        begin
          EDT_CodCliente.SetFocus;
          exit;
        end;

     if not ValidaCodCliente(EDT_CodCliente.Text) then
       begin
         Showmessage('Cliente n�o cadastrado, favor selecione outro.');
         EDT_CodCliente.Clear;
         EDT_NomeCliente.Clear;
         EDT_CodCliente.SetFocus;
         Abort;
       end
     else
       begin
         EDT_CodCliente.Text  := ds_ConsCliente.DataSet.FieldByName('codigo').AsString;
         EDT_NomeCliente.Text := ds_ConsCliente.DataSet.FieldByName('nome').AsString;
       end;
    end;

  TEdit(Sender).Color := clWindow;
end;

procedure TfrmMov_PEDVendas.EDT_CodClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F5 then
    begin
      ConsultaClientes;
    end;
end;

procedure TfrmMov_PEDVendas.EDT_CodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
    begin
      edt_CodigoProd.SetFocus;
    end;
end;

procedure TfrmMov_PEDVendas.edt_CodigoProdExit(Sender: TObject);
begin
  if edt_CodigoProd.Text <> '' then
    begin
      if statusGravaPed = 'dsInsert' then
        begin
          edt_CodigoProd.Text := FormatFloat('0000000000000',StrToInt(edt_CodigoProd.Text));
          if not ValidaCodProduto(FormatFloat('0000000000000',StrToInt(edt_CodigoProd.Text))) then
            begin
              Showmessage('Produto n�o cadastrado, favor selecione outro.');
              edt_CodigoProd.SetFocus;
              edt_CodigoProd.Clear;
              EDT_DescrProduto.Clear;
              Edt_PrecProd.Text :='0,00';
              Abort;
            end
          else
            begin
              edt_CodigoProd.Text   := ds_ConsProduto.DataSet.FieldByName('codigo').AsString;
              EDT_DescrProduto.Text := ds_ConsProduto.DataSet.FieldByName('descricao').AsString;
              Edt_PrecProd.Text     := FloatToStr(RoundTo(ds_ConsProduto.DataSet.FieldByName('preco_venda').Asfloat,-2));
            end;
        end;
    end;
  TEdit(Sender).Color := clWindow;
end;

procedure TfrmMov_PEDVendas.edt_CodigoProdKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F4 then
    ConsultaProdutos
  else
    if key = vk_F6 then
      GRD_Produtos.SetFocus;
end;

procedure TfrmMov_PEDVendas.edt_CodigoProdKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      Edt_Qtde.SetFocus;
    end;
end;

procedure TfrmMov_PEDVendas.EDT_DTEMISSAOEnter(Sender: TObject);
begin
  TDateTimePicker(Sender).Color := clInfoBk;
end;

procedure TfrmMov_PEDVendas.EDT_DTEMISSAOExit(Sender: TObject);
begin
  TDateTimePicker(Sender).Color := clWindow;
end;

procedure TfrmMov_PEDVendas.EDT_DTEMISSAOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    EDT_CodCliente.SetFocus;
end;

procedure TfrmMov_PEDVendas.Edt_PrecProdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    begin
      Edt_Qtde.SetFocus;
    end;
end;

procedure TfrmMov_PEDVendas.Edt_PrecProdKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08,#13, ',','.'] ) then
    key:=#0;
end;

procedure TfrmMov_PEDVendas.Edt_QtdeChange(Sender: TObject);
begin
  CalculaValor;
end;

procedure TfrmMov_PEDVendas.Edt_QtdeExit(Sender: TObject);
begin
  if Edt_Qtde.Text='' then
    begin
      Edt_Qtde.SetFocus;
      exit;
    end;
  TEdit(Sender).Color := clWindow;
  CalculaValor;
end;

procedure TfrmMov_PEDVendas.Edt_QtdeKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08,#13] ) then
    key:=#0;

  if key = #13 then
    begin
      if Edt_Qtde.Text <> '' then
        begin
          CalculaValor;
          BTN_Inserir.Click;
        end
      else
        Edt_Qtde.SetFocus;
    end;
end;

function TfrmMov_PEDVendas.Espaco(Tamanho: Integer): string;
begin
  Result := '';
  while Tamanho > 0 do
    begin
      Tamanho:= Tamanho - 1;
      Result := Result + ' ';
    end;
end;

function TfrmMov_PEDVendas.FormataMonetario(sValor: string): string;
var
  sVal: string;
begin
  sVal := StringReplace(sValor,'.','', [rfReplaceAll]);
  Result := sVal;
end;

procedure TfrmMov_PEDVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryPedproduto.EmptyDataSet;
  QryPedproduto.Close;
  Action :=cafree;
end;

procedure TfrmMov_PEDVendas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  frmMov_PEDVendas := NIL;
end;

procedure TfrmMov_PEDVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    close;
  if Key = VK_F3 then
    AbrePedidoVenda;  //Abre a venda
  if key = vk_F6 then
    GRD_Produtos.SetFocus;
  if key = VK_F7 then
    begin
      try
        try
          PedidovendaCab := TPedidovendaControl.Create;
          QryAux := PedidovendaCab.PedidovendaModel.Obter('-1');
          if Application.messageBox('Deseja Gravar o Pedido ?','Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IdYes then
            begin
              if statusGravaPed <> 'dsEdit' then
              begin
                //Grava o cabe�alho do pedido
                QryAux.Connection.StartTransaction;
                PedidovendaCab.PedidovendaModel.Acao := uEnumerado.tacIncluir; //status de inclus�o do pedido
                PedidovendaCab.PedidovendaModel.NUMPEDIDO   := PedidovendaCab.PedidovendaModel.GetId;
                EDT_Numpedido.Text := FormatFloat('000000',PedidovendaCab.PedidovendaModel.NUMPEDIDO);
                PedidovendaCab.PedidovendaModel.DATAEMISSAO := EDT_DTEMISSAO.Date;
                PedidovendaCab.PedidovendaModel.CODCLIENTE  := StrToInt(EDT_CodCliente.Text);
                PedidovendaCab.PedidovendaModel.VALORTOTAL  := StrToFloat(FormataMonetario(EdtTotVenda.Text));
                PedidovendaCab.PedidovendaModel.Salvar;
                ProdutosPedido:= TPedidoXProdutosControl.Create;
                //Grava os itens
                QryPedproduto.First;
                while not QryPedproduto.Eof do
                  begin
                     ProdutosPedido.PedidoXProdutosModel.Acao          := uEnumerado.tacIncluir; //status de inclus�o do pedido
                     ProdutosPedido.PedidoXProdutosModel.ID            := ProdutosPedido.PedidoXProdutosModel.GetId;
                     ProdutosPedido.PedidoXProdutosModel.NUMPEDIDO     := StrToInt(EDT_Numpedido.Text);
                     ProdutosPedido.PedidoXProdutosModel.CODPRODUTO    := QryPedprodutoCodProduto.AsString;
                     ProdutosPedido.PedidoXProdutosModel.QUANTIDADE    := QryPedprodutoQuantidade.Value;
                     ProdutosPedido.PedidoXProdutosModel.VALORUNITARIO := QryPedprodutoValor_Unitario.Value;
                     ProdutosPedido.PedidoXProdutosModel.VALORTOTAL    := QryPedprodutoValor_Total.AsFloat;
                     ProdutosPedido.PedidoXProdutosModel.Salvar;
                     QryPedproduto.Next;
                  end;
              end
              else
              begin
                //Grava o cabe�alho do pedido
                PedidovendaCab := TPedidovendaControl.Create;
                PedidovendaCab.PedidovendaModel.Acao := uEnumerado.tacAlterar; //status de inclus�o do pedido
                PedidovendaCab.PedidovendaModel.NUMPEDIDO   := StrToInt(EDT_Numpedido.Text);
                PedidovendaCab.PedidovendaModel.DATAEMISSAO := EDT_DTEMISSAO.Date;
                PedidovendaCab.PedidovendaModel.CODCLIENTE  := StrToInt(EDT_CodCliente.Text);
                PedidovendaCab.PedidovendaModel.VALORTOTAL  := StrToFloat(FormataMonetario(EdtTotVenda.Text));
                PedidovendaCab.PedidovendaModel.Salvar;
                ProdutosPedido:= TPedidoXProdutosControl.Create;

                //apaga os itens e grava de novo
                ProdutosPedido.PedidoXProdutosModel.Acao := uEnumerado.tacExcluir;
                ProdutosPedido.PedidoXProdutosModel.NUMPEDIDO := StrToInt(EDT_Numpedido.Text);
                ProdutosPedido.PedidoXProdutosModel.Salvar;
                //apaga os itens e grava de novo

                //Grava os itens
                QryPedproduto.First;
                while not QryPedproduto.Eof do
                  begin
                     ProdutosPedido.PedidoXProdutosModel.Acao          := uEnumerado.tacAlterar; //status de inclus�o do pedido
                     ProdutosPedido.PedidoXProdutosModel.ID            := ProdutosPedido.PedidoXProdutosModel.GetId;
                     ProdutosPedido.PedidoXProdutosModel.NUMPEDIDO     := StrToInt(EDT_Numpedido.Text);
                     ProdutosPedido.PedidoXProdutosModel.CODPRODUTO    := QryPedprodutoCodProduto.AsString;
                     ProdutosPedido.PedidoXProdutosModel.QUANTIDADE    := QryPedprodutoQuantidade.Value;
                     ProdutosPedido.PedidoXProdutosModel.VALORUNITARIO := QryPedprodutoValor_Unitario.Value;
                     ProdutosPedido.PedidoXProdutosModel.VALORTOTAL    := QryPedprodutoValor_Total.AsFloat;
                     ProdutosPedido.PedidoXProdutosModel.Salvar;
                     QryPedproduto.Next;
                  end;
              end;
              Showmessage('Seu pedido foi gravado com sucesso. O n�mero do seu pedido � : '+EDT_Numpedido.Text);
              QryAux.Connection.commit;
              if Application.messageBox('Deseja Imprimir o Pedido agora ?','Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IdYes then
              begin
                ImprimirPedido;
              end;
              strStatusPDV :='ABRIR PEDIDO';
              MenssagemPDV('F3 - ABRIR PEDIDO.');
              statusGravaPed := 'dsBrowse';
            end;
        except
          on E: Exception do
            begin
              QryAux.Connection.Rollback;
              Showmessage ('Ocorreu erro no banco de dados.' + E.Message);
            end;
        end;
      finally
        PedidovendaCab.Free;
      end;
    end;
  if key = vk_f8 then
    begin
      ConsultaPedido;
    end;
  if key = vk_f9 then
    begin
      CancelaPedido;
    end;
end;

procedure TfrmMov_PEDVendas.FormShow(Sender: TObject);
begin
  QryPedproduto.CreateDataSet;
  strStatusPDV :='ABRIR PEDIDO';
  MenssagemPDV('F3 - ABRIR PEDIDO.');
  statusGravaPed := 'dsBrowse';
  EDT_DTEMISSAO.SetFocus;
end;

procedure TfrmMov_PEDVendas.GRD_ProdutosColExit(Sender: TObject);
begin
  if GRD_Produtos.Columns[2].Grid.SelectedField.FieldName = 'CodProduto' then
  begin
    if (statusGravaPed = 'dsEdit') or (statusGravaPed = 'dsInsert') then
      begin
        if QryPedproduto.State = dsBrowse then
          QryPedproduto.Edit;
        QryPedprodutoCodProduto.AsString := FormatFloat('0000000000000',StrToInt(QryPedprodutoCodProduto.AsString));
        if not ValidaCodProduto(FormatFloat('0000000000000',StrToInt(GRD_Produtos.Columns[2].Grid.SelectedField.AsString))) then
          begin
            Showmessage('Produto n�o cadastrado, favor selecione outro.');
            QryPedprodutoCodProduto.FocusControl;
            QryPedprodutoCodProduto.Clear;
            QryPedprodutoDescrProduto.Clear;
            QryPedprodutoValor_Unitario.Clear;
            QryPedprodutoValor_Unitario.AsString :='0,00';
            Abort;
          end
        else
          begin
            QryPedprodutoCodProduto.AsString     := ds_ConsProduto.DataSet.FieldByName('codigo').AsString;
            QryPedprodutoDescrProduto.AsString   := ds_ConsProduto.DataSet.FieldByName('descricao').AsString;
            QryPedprodutoValor_Unitario.AsString := ds_ConsProduto.DataSet.FieldByName('preco_venda').AsString;
          end;
      end;
  end;

  if GRD_Produtos.Columns[2].Grid.SelectedField.FieldName = 'Quantidade' then  //ao sair da coluna for a quantidade no grid ele reclacula para alterar
  begin
    if (statusGravaPed = 'dsEdit') or (statusGravaPed = 'dsInsert') then
    begin
      if QryPedproduto.State = dsBrowse then
        QryPedproduto.Edit;
      QryPedprodutoValor_Total.Value := (QryPedprodutoQuantidade.Value * QryPedprodutoValor_Unitario.Value);
      Edt_Qtde.Text    := FormatFloat(',0.00',QryPedprodutoQuantidade.Value);
      EdtTotVenda.Text := FormatFloat(',0.00',SomaValorTotal);
      CalculaValor;
      edt_CodigoProd.Text   :='';
      EDT_DescrProduto.Text :='';
      Edt_Qtde.Text         :='1,00';
      Edt_PrecProd.Text     := '0,00';
      EDT_ValorTotal.Text   := '0,00';
    end;
  end;
end;

procedure TfrmMov_PEDVendas.GRD_ProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then  //se der enter no grid dos produtos ele habilitas os campos para alterar
    begin
      Key := 9;
      if (statusGravaPed = 'dsInsert') or (statusGravaPed = 'dsEdit') then
        begin
          QryPedproduto.edit;
          edt_CodigoProd.Text   := QryPedprodutoCodProduto.AsString;
          EDT_DescrProduto.Text := QryPedprodutoDescrProduto.AsString;
          Edt_Qtde.Text         := QryPedprodutoQuantidade.AsString;
          Edt_PrecProd.Text     := QryPedprodutoValor_Unitario.AsString;
          EDT_ValorTotal.Text   := QryPedprodutoValor_Total.AsString;
          BTN_Inserir.Caption   := 'Atualizar Produto';
          statusGridPed         := 'dsEdit';
          edt_CodigoProd.SetFocus;
        end;
    end
  else
    if key = VK_DELETE then
      begin
         if Application.MessageBox('Deseja realmente Excluir esse produto ? ', 'Informa��o', MB_ICONQUESTION + MB_YESNO) = IDYES then
           begin
             QryPedproduto.Delete;
           end;
      end;

end;

procedure TfrmMov_PEDVendas.GRD_ProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    begin
      if QryPedproduto.State = dsBrowse then
      begin
        QryPedproduto.Edit;
        GRD_Produtos.Perform(WM_KEYDOWN, VK_TAB, 0);
      end;
    end;
end;

procedure TfrmMov_PEDVendas.GRD_ProdutosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CalculaValor;
  edt_CodigoProd.Text   :='';
  EDT_DescrProduto.Text :='';
  Edt_Qtde.Text         :='1,00';
  Edt_PrecProd.Text     := '0,00';
  EDT_ValorTotal.Text   := '0,00';
end;

procedure TfrmMov_PEDVendas.ImprimirPedido;
var  arqF: TextFile;
     sNPed: string;
     iTemPrd  : Integer;
begin
  try
    iTemPrd := 0;
    sNPed := EDT_Numpedido.Text;
    AssignFile(arqF, ExtractFilePath(Application.ExeName) + 'Pedidovenda.TXT');
    Rewrite(arqF);
    Writeln(arqF,' ');
    Writeln(arqF,' ');
    Writeln(arqF,' ');
    Writeln(arqF, '----------------------------------------------------------------------------------------------------------');
    Writeln(arqF, PadC('Sr(a). '+EDT_NomeCliente.Text, 80));
    Writeln(arqF, PadC('NUMERO DO PEDIDO VENDA : ' + FormatFloat('0000000000',StrToInt(EDT_Numpedido.Text)), 80));
    Writeln(arqF, '----------------------------------------------------------------------------------------------------------');
    Writeln(arqF, PadC(FormatDateTime('dd/mm/yyyy HH:mm:ss',Now) + ColocaTextoDir(' PED. : ' + sNPed,30,' '), 80));
    Writeln(arqF, PadC('IMPRESSAO DO PEDIDO DE TESTE - PROVA TECNICA',80));
    Writeln(arqF,' ');
    Writeln(arqF, 'ITEM   CODPROD  DESCRICAO                                  QTDE        VL UNIT      VL TOTAL ');
    Writeln(arqF, '----------------------------------------------------------------------------------------------------------');
    QryPedproduto.First;
    while not QryPedproduto.eof do
      begin
        iTemPrd := iTemPrd + 1;
        Writeln(arqF, ' '+Formatfloat('0000',iTemPrd)+'  '+
                      Formatfloat('000000',QryPedprodutoCodProduto.AsInteger)+'  '+
                      copy(ColocaTextoEsq(QryPedprodutoDescrProduto.AsString, 40, ' '),1,80) + '     '+
                      FormatFloat(',0.00',QryPedprodutoQuantidade.AsFloat)+'     '+
                      ColocaTextoDir(FormatFloat(',0.00',QryPedprodutoValor_Unitario.AsFloat),9, ' ')+'     '+
                      ColocaTextoDir(FormatFloat(',0.00',QryPedprodutoValor_Total.AsFloat),9, ' '));
        QryPedproduto.Next;
      end;
    Writeln(arqF, '----------------------------------------------------------------------------------------------------------');
    Writeln(arqF, ' TOTAL R$ ' + '                       ' +ColocaTextoDir(EdtTotVenda.Text,60,' '));
    Writeln(arqF, '----------------------------------------------------------------------------------------------------------');
    Writeln(arqF, '  OBRIGADO VOLTE SEMPRE !!!');
    CloseFile(arqF);
    AbreAqrFilePed;
  except
  end;
end;

procedure TfrmMov_PEDVendas.Limpacampo;
begin
  edt_CodigoProd.Text   :='';
  EDT_DescrProduto.Text :='';
  Edt_Qtde.Text         :='1,00';
  Edt_PrecProd.Text     :='0,00';
  EDT_ValorTotal.Text   :='0,00';
  edt_CodigoProd.SetFocus;
end;

procedure TfrmMov_PEDVendas.Memo_Print(Conteudo: TStrings);
Var
  MemoFile :TextFile;
  P :Integer;
begin
  AssignPrn(MemoFile);
  Rewrite(MemoFile);
  For P := 0 to Conteudo.Count-1 do
    Writeln(MemoFile,Conteudo.Strings[P]);
  CloseFile(MemoFile);
end;

procedure TfrmMov_PEDVendas.MenssagemPDV(pMenssagem: string);
begin
  lblMessagem.Caption :='';
  lblMessagem.Caption :=UpperCase(pMenssagem);
end;

function TfrmMov_PEDVendas.PadC(S: String; I: Integer): String;
var
  L:byte;
begin
  Result :='';
  if I < Length(s) then
    begin
      Exit;
    end;
  L := (I-Length(S)) div 2;
  while l > 0 do
    begin
      Result := Result + ' ';
      Dec(l);
    end;
  for l:=1 to Length(S) do
    begin
      Result := Result + S[L];
    end;
end;

procedure TfrmMov_PEDVendas.QryPedprodutoAfterDelete(DataSet: TDataSet);
begin
  EdtTotVenda.Text := FormatFloat(',0.00',SomaValorTotal);
  abort;
end;

procedure TfrmMov_PEDVendas.QryPedprodutoAfterPost(DataSet: TDataSet);
begin
  EdtTotVenda.Text := FormatFloat(',0.00',SomaValorTotal);
end;

function TfrmMov_PEDVendas.SomaValorTotal: Real;
var
  dblValor: Real;
begin
  Result   :=0;
  dblValor := 0;
  QryPedproduto.DisableControls;
  QryPedproduto.First;
  while not QryPedproduto.Eof do
    begin
      dblValor := dblValor + QryPedprodutoValor_Total.AsFloat;
      QryPedproduto.Next;
    end;
  QryPedproduto.EnableControls;
  Result := dblValor;
end;

function TfrmMov_PEDVendas.ValidaCodCliente(ACodCli: string): boolean;
begin
  try
    Clientes := TClienteControl.Create;
    ds_ConsCliente.DataSet := Clientes.ObterNomeCLI(ACodCli);
    if not ds_ConsCliente.DataSet.Eof then
      begin
        Result :=True;
      end
    else
      Result := False;
  finally
    Clientes.Free;
  end;
end;

function TfrmMov_PEDVendas.ValidaCodProduto(ACodP: string): boolean;
begin
  try
    Produtos := TProdutoControl.Create;
    ds_ConsProduto.DataSet := Produtos.ObterProdDesc(ACodP);
    if not ds_ConsProduto.DataSet.Eof then
      begin
        Result := True;
      end
    else
      Result := False;
  finally
    Produtos.Free;
  end;
end;

end.
