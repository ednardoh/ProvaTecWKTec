unit uPesquisaVIEW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, FMTBcd, SqlExpr,
  Provider, DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.Intf, uClienteControl, uProdutoControl;

type
  TFrmPesquisa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtNome: TEdit;
    btnPesquisar: TButton;
    btnSelecionar: TButton;
    btnCancelar: TButton;
    dbgPesquisa: TDBGrid;
    dsPesquisa: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    Clientes       : TClienteControl;
    Produtos       : TProdutoControl;
    procedure buscaRegistro;
  public
    { Public declarations }
    gblNomeTabela,
    gblCodigo,
    gblNomepesquisa : String;
  end;

var
  FrmPesquisa: TFrmPesquisa;

implementation

 {$R *.dfm}

uses UPrincipalVIEW;

procedure TFrmPesquisa.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPesquisa.btnSelecionarClick(Sender: TObject);
begin
  if gblNomeTabela = 'clientes' then
  begin
    frmPrincipal.LCodigo   := dbgPesquisa.Columns.Grid.Fields[0].AsString;
    frmPrincipal.LNome     := dbgPesquisa.Columns.Grid.Fields[1].AsString;
  end
  else
    if gblNomeTabela = 'produtos' then
    begin
      frmPrincipal.LCodigo   := dbgPesquisa.Columns.Grid.Fields[0].AsString;
      frmPrincipal.LNome     := dbgPesquisa.Columns.Grid.Fields[2].AsString;
      frmPrincipal.LPrcProd  := FormatFloat(',0.00',dsPesquisa.DataSet.FieldByName('preco_venda').AsFloat);
    end;
  close;
end;

procedure TFrmPesquisa.buscaRegistro;
begin
  if gblNomeTabela = 'clientes' then
    begin
      Clientes := TClienteControl.Create;
      if CheckBox1.Checked then
        dsPesquisa.DataSet := Clientes.Obter(1,'')  //ordena por codigo
      else
        dsPesquisa.DataSet := Clientes.Obter(2,''); //ordena por nome
      Clientes.Free;
    end
  else
    if gblNomeTabela = 'produtos' then
      begin
        Produtos := TProdutoControl.Create;
        if CheckBox1.Checked then
          dsPesquisa.DataSet := Produtos.Obter(1,'')
        else
          dsPesquisa.DataSet := Produtos.Obter(2,'');
        Produtos.Free;
      end
  else
    if gblNomeTabela = 'pedidos' then
      begin
        if CheckBox1.Checked then
          gblCodigo := 'numpedido'
        else
          gblCodigo := 'numpedido';
      end
  else
    if gblNomeTabela = 'pedido_produtos' then
      begin
        if CheckBox1.Checked then
          gblCodigo := 'numpedido'
        else
          gblCodigo := 'numpedido';
      end;
end;

procedure TFrmPesquisa.CheckBox1Click(Sender: TObject);
begin
  buscaRegistro;
end;

procedure TFrmPesquisa.FormShow(Sender: TObject);
begin
  buscaRegistro;
end;

procedure TFrmPesquisa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TFrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_f3 then btnPesquisarClick(Self);
  if key = vk_f5 then btnSelecionarClick(Self);
  if key = vk_escape then btnCancelarClick(Self);
end;

procedure TFrmPesquisa.dbgPesquisaDblClick(Sender: TObject);
begin
  btnSelecionarClick(Self);
end;

procedure TFrmPesquisa.btnPesquisarClick(Sender: TObject);
begin
  if edtNome.Text = '' then
    Showmessage('Campo pesquisa n�o pode ser vazio.')
  else
    begin
      if gblNomeTabela = 'clientes' then
        begin
          if StrToIntDef(edtNome.Text, 0) = 0 then  //tem letras
            dsPesquisa.DataSet.Locate('nome',edtNome.Text,[loPartialKey, loCaseInsensitive])
          else
            dsPesquisa.DataSet.Locate('codigo',edtNome.Text,[]);
        end
      else
        if gblNomeTabela = 'produtos' then
          begin
            if StrToIntDef(edtNome.Text, 0) = 0 then  //tem letras
              dsPesquisa.DataSet.Locate('descricao',edtNome.Text,[loPartialKey, loCaseInsensitive])
            else
              dsPesquisa.DataSet.Locate('codigo',edtNome.Text,[]);
          end
      else
        if gblNomeTabela = 'pedidos' then
          begin
            if StrToIntDef(edtNome.Text, 0) <> 0 then  //tem letras
              dsPesquisa.DataSet.Locate('numpedido',edtNome.Text,[]);
          end
      else
        if gblNomeTabela = 'pedido_produtos' then
          begin
            if StrToIntDef(edtNome.Text, 0) <> 0 then  //tem letras
              dsPesquisa.DataSet.Locate('numpedido',edtNome.Text,[]);
          end;
        end;
end;

procedure TFrmPesquisa.edtNomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    begin
      dbgPesquisa.SetFocus;
    end;
end;

procedure TFrmPesquisa.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      dbgPesquisa.SetFocus;
    end;
end;

procedure TFrmPesquisa.dbgPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Return then btnSelecionarClick(Self);

end;

procedure TFrmPesquisa.dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btnSelecionarClick(Self);
end;

end.
