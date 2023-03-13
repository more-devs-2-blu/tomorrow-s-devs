unit UDAO.NotaFiscal;

interface

uses
  UDAO.Base,
  System.JSON, UUtil.Banco;

type
  TDAONotaFiscal = class(TDAOBase)
  private
    function ProcurarClientePorId  (const aId: Integer): TJSONObject;
    function ProcurarPrestadorPorId(const aId: Integer): TJSONObject;
    function ProcurarServicoPorId  (const aId: Integer): TJSONObject;
  public
    Constructor Create;
    function ObterRegistros: TJSONArray; override;
    function ProcurarPorId(const aIdentificador: Integer): TJSONObject;
      override;
    function ProcurarPorIdCompleto(const aIdentificador: Integer): TJSONObject; override;
    function ObterServicosDaNota(const aIdNota: Integer): TJSONArray;
  end;

implementation

uses
  System.SysUtils,
  UDAO.Intf,
  UDAO.Servico,
  UDAO.Cliente,
  UDAO.Prestador;

{ TDAOItemServico }

constructor TDAONotaFiscal.Create;
begin
  FTabela := 'nota';
end;

function TDAONotaFiscal.ProcurarPorIdCompleto(const aIdentificador: Integer): TJSONObject;
var
  xJSONObject, xJSONObjectAux: TJSONObject;
  xIdServico, xIdPrestador, xIdCliente, xIdNota, I: Integer;
  xJSONArray, xJSONArrayAux: TJSONArray;
begin
  xJSONObject := Self.ProcurarPorId(aIdentificador);

  xJSONObject.TryGetValue('id', xIdNota);

  xJSONArray := Self.ObterServicosDaNota(xIdNota);
  if xJSONArray.Count = 0 then
    Exit(xJSONObject);

  xJSONArrayAux := TJSONArray.Create;
  for I := 0 to Pred(xJSONArray.Count) do
    begin
      xJSONObjectAux := TJSONObject.Create;
      xJSONObjectAux := TJSONObject.ParseJSONValue
        (TEncoding.ASCII.GetBytes(xJSONArray[I].ToJSON), 0) as TJSONObject;

      xIdServico := StrToInt(xJSONObjectAux.GetValue('idservico').Value);

      xJSONObjectAux.RemovePair('idservico');
      xJSONObjectAux.AddPair('servico', Self.ProcurarServicoPorId(xIdServico));

      xJSONArrayAux.AddElement(xJSONObjectAux);
    end;
  xJSONObject.AddPair(TJSONPair.Create('Servicos', xJSONArrayAux));
  result := xJSONObject;
end;

function TDAONotaFiscal.ObterRegistros: TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdServico, xIdPrestador, xIdCliente: Integer;
begin
  xJSONArray := inherited;

  if xJSONArray.Count = 0 then
    Exit(xJSONArray);

  xJSONArrayAux := TJSONArray.Create;

  for I := 0 to Pred(xJSONArray.Count) do
  begin
    xJSONObject := TJSONObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(xJSONArray[I].ToJSON), 0) as TJSONObject;

    xIdPrestador := StrToInt(xJSONObject.GetValue('idprestador').Value);
    xJSONObject.AddPair('prestador', Self.ProcurarPrestadorPorId(xIdPrestador));
    xJSONObject.RemovePair('idprestador');

    xIdCliente := StrToInt(xJSONObject.GetValue('idcliente').Value);
    xJSONObject.AddPair('cliente', Self.ProcurarClientePorId(xIdPrestador));
    xJSONObject.RemovePair('idcliente');

    xJSONArrayAux.AddElement(xJSONObject);
  end;
  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAONotaFiscal.ObterServicosDaNota(const aIdNota: Integer): TJSONArray;
begin
  try
    Result := TUtilBanco.ExecutarConsulta(Format('SELECT id, quantidade, idservico FROM %s WHERE idnota = %d',
      ['item_servico', aIdNota]));
  except
    on e: Exception do
      raise Exception.Create('Erro ao Obter Serviços da nota: ' + e.Message);
  end;
end;

function TDAONotaFiscal.ProcurarClientePorId(const aId: Integer)
  : TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAOCliente.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

function TDAONotaFiscal.ProcurarPorId(const aIdentificador: Integer)
  : TJSONObject;
var
  xJSONObject, xJSONObjectAux: TJSONObject;
  xIdServico, xIdPrestador, xIdCliente, xIdNota, I: Integer;
  xJSONArray, xJSONArrayAux: TJSONArray;
begin
  xJSONObject := inherited;

  if xJSONObject.Count = 0 then
    Exit(xJSONObject);

  xIdPrestador := StrToInt(xJSONObject.GetValue('idprestador').Value);
  xJSONObject.AddPair('prestador', Self.ProcurarPrestadorPorId(xIdPrestador));
  xJSONObject.RemovePair('idprestador');

  xIdCliente := StrToInt(xJSONObject.GetValue('idcliente').Value);
  xJSONObject.AddPair('cliente', Self.ProcurarClientePorId(xIdPrestador));
  xJSONObject.RemovePair('idcliente');

  Result := xJSONObject;
end;

function TDAONotaFiscal.ProcurarPrestadorPorId(const aId: Integer): TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAOPrestador.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

function TDAONotaFiscal.ProcurarServicoPorId(const aId: Integer): TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAOServico.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

end.
