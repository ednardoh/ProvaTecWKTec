unit uPedidoXProdutosDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uPedidoXProdutosModel, System.SysUtils,
  uSistemaControl;

type
  TPedidoXProdutosDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;

      function Incluir(APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
      function Alterar(APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
      function Excluir(APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
      function GetId: Integer;
      function Obter(AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TPedidoXProdutosDAO }
constructor TPedidoXProdutosDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TPedidoXProdutosDAO.GetId: Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.Open('select case when id is null THEN               '+
              '            1                                  '+
              '       else                                    '+
              '         max(id)+1                             '+
              '       end as id                               '+
              'from pedido_produtos                           ');
    Result := vQry.Fields[0].AsInteger;
    vQry.Close;
  finally
    vQry.Free;
  end;
end;

function TPedidoXProdutosDAO.Incluir(
  APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('insert into pedido_produtos (id,                '+
                   '                             numpedido,         '+
                   '                             codigo_produto,    '+
                   '                             quantidade,        '+
                   '                             vlr_unitario,      '+
                   '                             vlr_total)         '+
                   'values (:id,                                    '+
                   '        :numpedido,                             '+
                   '        :codigo_produto,                        '+
                   '        :quantidade,                            '+
                   '        :vlr_unitario,                          '+
                   '        :vlr_total)                             ',
                    [APedidoXProdutosModel.ID,
                     APedidoXProdutosModel.NUMPEDIDO,
                     APedidoXProdutosModel.CODPRODUTO,
                     APedidoXProdutosModel.QUANTIDADE,
                     APedidoXProdutosModel.VALORUNITARIO,
                     APedidoXProdutosModel.VALORTOTAL]
                     );

      Result := True;
    except
      on E: Exception do
        begin
          Result := False;
        end;
    end;
  finally
    VQry.Free;
  end;
end;

function TPedidoXProdutosDAO.Alterar(
  APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('update pedido_produtos set quantidade    =:quantidade,    '+
                   '                           vlr_unitario  =:vlr_unitario,  '+
                   '                           vlr_total     =:vlr_total      '+
                   'where id=:id                                              '+
                   '  and numpedido=:numpedido                                '+
                   '  and codigo_produto=:codigo_produto                      ',
                    [
                      APedidoXProdutosModel.ID,
                      APedidoXProdutosModel.NUMPEDIDO,
                      APedidoXProdutosModel.CODPRODUTO,
                      APedidoXProdutosModel.QUANTIDADE,
                      APedidoXProdutosModel.VALORUNITARIO,
                      APedidoXProdutosModel.VALORTOTAL
                     ]
                    );
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

function TPedidoXProdutosDAO.Excluir(
  APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('delete from pedido_produtos where numpedido=:numpedido  ',
                    [APedidoXProdutosModel.NUMPEDIDO]);

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

function TPedidoXProdutosDAO.Obter(AValorpesquisa: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  if AValorpesquisa <> '' then
    vQry.Open('select id, numpedido, codigo_produto, quantidade, vlr_unitario, vlr_total from pedido_produtos where numpedido = '+AValorpesquisa)
  else
    vQry.Open('select id, numpedido, codigo_produto, quantidade, vlr_unitario, vlr_total from pedido_produtos order by 1');
  Result := vQry;
end;

end.
