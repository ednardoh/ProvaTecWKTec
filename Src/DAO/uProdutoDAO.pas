unit uProdutoDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uProdutoModel, System.SysUtils, uSistemaControl,
  Data.DB, Vcl.Dialogs;

type
  TProdutoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(AProdutoModel: TProdutoModel): Boolean;
    function Alterar(AProdutoModel: TProdutoModel): Boolean;
    function Excluir(AProdutoModel: TProdutoModel): Boolean;
    function GetId: string;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterProdDesc(AValorpesquisa: string): TFDQuery;
    function ObterCodBarra(AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TProdutoDAO.GetId: string;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open(' SELECT case when codigo is null THEN                          '+
              '                    1                                          '+
              '               else                                            '+
              '                 max(cast(codigo as unsigned integer))+1       '+
              '               end as codigo                                   '+
              ' from produtos;                                                ');

    try
      Result := FormatFloat('0000000000000',VQry.Fields[0].AsInteger);
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TProdutoDAO.Incluir(AProdutoModel: TProdutoModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into produtos(codigo, descricao, preco_venda) '+
                 '      values(:codigo, :descricao, :preco_venda)',
                  [AProdutoModel.Codigo,
                   AProdutoModel.Descricao,
                   AProdutoModel.PRECOVENDA]);

    VQry.Connection.Commit;
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TProdutoDAO.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  if AValorparcial = '' then
    begin
      vQry.Open('select codigo,                              '+
                '       descricao,                           '+
                '       preco_venda                          '+
                'from produtos order by ' + AorderBy.ToString);
    end
  else
  begin
    vQry.Open('select codigo,                                                 '+
              '       descricao,                                              '+
              '       preco_venda                                             '+
              'from produtos                                                  '+
              ' where descricao like '+ quotedstr(AValorparcial) + ' order by ' + AorderBy.ToString);
  end;
  Result := vQry;
end;

function TProdutoDAO.ObterCodBarra(AValorpesquisa: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();

  vQry.Open('select codigo from produtos where codigo = '+ quotedstr(AValorpesquisa));

  Result := vQry;
end;

function TProdutoDAO.ObterProdDesc(AValorpesquisa: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  VQry.Open('select codigo, descricao, preco_venda from produtos where codigo = '+ quotedstr(AValorpesquisa));

  Result := VQry;
end;

function TProdutoDAO.Alterar(AProdutoModel: TProdutoModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.ExecSQL('update produtos set '+
                 '       descricao  =:descricao,   '+
                 '       preco_venda=:preco_venda, '+
                 'where codigo      =:codigo       ',
                  [AProdutoModel.Codigo,
                   AProdutoModel.Descricao,
                   AProdutoModel.PRECOVENDA]);
    Result := True;
  finally
    vQry.Free;
  end;
end;

function TProdutoDAO.Excluir(AProdutoModel: TProdutoModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('delete from produtos where codigo=:codigo ', [AProdutoModel.Codigo]);
      Result := True;
    except
    on E: Exception do
      begin
        Result := False;
      end;
    end;
  finally
    vQry.Free;
  end;

end;

end.
