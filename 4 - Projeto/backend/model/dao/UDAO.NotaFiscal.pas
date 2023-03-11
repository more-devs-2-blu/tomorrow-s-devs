unit UDAO.NotaFiscal;

interface

uses
  UDAO.Base,
  System.JSON;

type
  TDAONotaFiscal = class(TDAOBase)
  private
    function ProcurarClientePorId  (const aId: Integer): TJSONObject;
    function ProcurarPrestadorPorId(const aId: Integer): TJSONObject;
  public
    Constructor Create;
    function ObterRegistros: TJSONArray; override;
    function ProcurarPorId(const aIdentificador: Integer): TJSONObject;
      override;
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
  xJSONObject: TJSONObject;
  xIdServico, xIdPrestador, xIdCliente: Integer;
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

end.
