unit uClienteDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel, System.SysUtils, uSistemaControl,
  Data.DB, Vcl.Dialogs;

type
  TClienteDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(AClienteModel: TClienteModel): Boolean;
    function Alterar(AClienteModel: TClienteModel): Boolean;
    function Excluir(AClienteModel: TClienteModel): Boolean;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterCLIByCodigo(AValorpesquisa: string): TFDQuery;
  end;

implementation

{ TClienteDao }

constructor TClienteDao.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TClienteDao.Incluir(AClienteModel: TClienteModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('insert into clientes(codigo, nome, cidade, uf)     '+
                   '              Values(:codigo, :nome, :cidade, :uf) ',
                    [AClienteModel.Codigo,
                     AClienteModel.Nome,
                     AClienteModel.Cidade,
                     AClienteModel.UF]);

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

function TClienteDao.Excluir(AClienteModel: TClienteModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('delete from clientes where codigo=:codigo ',
                    [AClienteModel.Codigo]);

      vQry.Connection.Commit;
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

function TClienteDao.Alterar(AClienteModel: TClienteModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('update clientes set   '+
                   ' nome   =:nome,       '+
                   ' cidade =:cidade,     '+
                   ' uf     =:uf          '+
                   'where codigo =:codigo ',
                   [ AClienteModel.Codigo,
                     AClienteModel.Nome,
                     AClienteModel.Cidade,
                     AClienteModel.UF]);

      vQry.Connection.Commit;
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

function TClienteDao.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();

  if AValorparcial = '' then
    vQry.Open('select codigo, nome, Cidade, UF from clientes order by '+AorderBy.ToString)
  else
    vQry.Open('select codigo, nome, Cidade, UF from clientes where nome like ' + quotedstr(AValorparcial) + ' order by '+AorderBy.ToString);

  Result := vQry;
end;

function TClienteDao.ObterCLIByCodigo(AValorpesquisa: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();

  vQry.Open('select codigo, nome, Cidade, UF from clientes where codigo = '+AValorpesquisa);

  Result := vQry;
end;

end.
