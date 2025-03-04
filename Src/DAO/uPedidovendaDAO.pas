unit uPedidovendaDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uPedidovendaModel, System.SysUtils,
  uSistemaControl;

type
  TPedidovendaDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;

      function Incluir(APedidovendaModel: TPedidovendaModel): Boolean;
      function Alterar(APedidovendaModel: TPedidovendaModel): Boolean;
      function Excluir(APedidovendaModel: TPedidovendaModel): Boolean;
      function GetId: Integer;
      function Obter(AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TPedidovendaDAO }
constructor TPedidovendaDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TPedidovendaDAO.GetId: Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.Open('select case when numpedido is null THEN               '+
              '            1                                         '+
              '       else                                           '+
              '         max(numpedido)+1                             '+
              '       end as numpedido                               '+
              'from pedidos                                          ');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TPedidovendaDAO.Incluir(APedidovendaModel: TPedidovendaModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.Close;
      vQry.ExecSQL('insert into pedidos (numpedido, data_emissao, codigo_cliente, valor_total) '+
                   '       values (:numpedido, :data_emissao, :codigo_cliente, :valor_total)   ',
                    [APedidovendaModel.NUMPEDIDO,
                     APedidovendaModel.DATAEMISSAO,
                     APedidovendaModel.CODCLIENTE,
                     APedidovendaModel.VALORTOTAL]);

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

function TPedidovendaDAO.Alterar(APedidovendaModel: TPedidovendaModel): Boolean;
var
  vQry: TFDQuery;
  strSQL: string;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      strSQL :='';
      vQry.Close;
      vQry.SQL.Clear;

      strSQL := 'update pedidos set data_emissao  =:data_emissao,   '+
                '                   codigo_cliente=:codigo_cliente, '+
                '                   valor_total   =:valor_total     '+
                'where numpedido =:numpedido                        ';

      vQry.SQL.Add(strSQL);
      vQry.ParamByName('data_emissao').AsDateTime  := APedidovendaModel.DATAEMISSAO;
      vQry.ParamByName('codigo_cliente').AsInteger := APedidovendaModel.CODCLIENTE;
      vQry.ParamByName('valor_total').AsFloat      := APedidovendaModel.VALORTOTAL;
      vQry.ParamByName('numpedido').AsInteger      := APedidovendaModel.NUMPEDIDO;
      vQry.ExecSQL();
    except
      on E: Exception do
        begin
          Result := False;
        end;
    end;
    Result := True;
  finally
    vQry.Free;
  end;

end;

function TPedidovendaDAO.Excluir(APedidovendaModel: TPedidovendaModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
    vQry.ExecSQL('delete from pedidos where numpedido =:numpedido',
                  [APedidovendaModel.NUMPEDIDO]);

     Result := True;
    except
      on E: Exception do
        begin
          Result := false;
        end;
    end;
  finally
    vQry.Free;
  end;
end;

function TPedidovendaDAO.Obter(AValorpesquisa: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();

  if AValorpesquisa = '' then
    vQry.Open('select numpedido , data_emissao, codigo_cliente, valor_total from pedidos order by 1')
  else
    vQry.Open('select numpedido , data_emissao, codigo_cliente, valor_total from pedidos WHERE numpedido=' + AValorpesquisa + ' order by 1');

  Result := VQry;
end;

end.
