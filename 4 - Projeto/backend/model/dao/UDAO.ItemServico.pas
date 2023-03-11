unit UDAO.ItemServico;

interface

uses
  UDAO.Base,
  System.JSON;

type
  TDAOItemServico = class(TDAOBase)
  private
    function ProcurarServicoPorId  (const aId: Integer): TJSONObject;
    function ProcurarNotaPorId  (const aId: Integer): TJSONObject;
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
  UDAO.NotaFiscal;

{ TDAOItemServico }

constructor TDAOItemServico.Create;
begin
  FTabela := 'item_servico';
end;

function TDAOItemServico.ObterRegistros: TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdServico, xIdNota: Integer;
begin
  xJSONArray := inherited;

  if xJSONArray.Count = 0 then
    Exit(xJSONArray);

  xJSONArrayAux := TJSONArray.Create;

  for I := 0 to Pred(xJSONArray.Count) do
  begin
    xJSONObject := TJSONObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(xJSONArray[I].ToJSON), 0) as TJSONObject;

    xIdServico := StrToInt(xJSONObject.GetValue('idservico').Value);
    xJSONObject.AddPair('servico', Self.ProcurarServicoPorId(xIdServico));
    xJSONObject.RemovePair('idservico');

    xIdServico := StrToInt(xJSONObject.GetValue('idnota').Value);
    xJSONObject.AddPair('nota', Self.ProcurarNotaPorId(xIdNota));
    xJSONObject.RemovePair('idnota');

    xJSONArrayAux.AddElement(xJSONObject);
  end;
  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOItemServico.ProcurarNotaPorId(const aId: Integer): TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAONotaFiscal.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

function TDAOItemServico.ProcurarPorId(
  const aIdentificador: Integer): TJSONObject;
var
  xJSONObject: TJSONObject;
  xIdServico, xIdNota: Integer;
begin
  xJSONObject := inherited;

  if xJSONObject.Count = 0 then
    Exit(xJSONObject);

    xIdServico := StrToInt(xJSONObject.GetValue('idservico').Value);
    xJSONObject.AddPair('servico', Self.ProcurarServicoPorId(xIdServico));
    xJSONObject.RemovePair('idservico');

    xIdServico := StrToInt(xJSONObject.GetValue('idnota').Value);
    xJSONObject.AddPair('nota', Self.ProcurarNotaPorId(xIdNota));
    xJSONObject.RemovePair('idnota');

  Result := xJSONObject;
end;

function TDAOItemServico.ProcurarServicoPorId(const aId: Integer): TJSONObject;
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
