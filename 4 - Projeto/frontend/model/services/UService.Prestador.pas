unit UService.Prestador;

interface


uses
  UEntity.Prestador, UService.Base;

type
  TServicePrestador = class(TServiceBase)
  private
    FPrestador: TPrestador;
  public
    constructor Create; overload;
    constructor Create(aPrestador: TPrestador); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;
  end;

implementation

uses
  REST.Types, System.JSON,
  UUtils.Constants,
  System.SysUtils,
  System.Classes, FireDAC.Comp.Client, DataSet.Serialize;

{ TServicePrestador }

constructor TServicePrestador.Create;
begin
  Inherited Create;
end;

constructor TServicePrestador.Create(aPrestador: TPrestador);
begin
  FPrestador := aPrestador;
  self.Create;
end;

destructor TServicePrestador.Destroy;
begin
  FreeAndNil(FPrestador);
  Inherited;
end;

procedure TServicePrestador.Excluir;
begin
  inherited;
//
end;

procedure TServicePrestador.Listar;
begin
  inherited;
//
end;

function TServicePrestador.ObterRegistro(const aId: Integer): TObject;
var
  xMemTable: TFDMemTable;
begin
  Result := nil;

  xMemTable := TFDMemTable.Create(nil);

  try
    FRESTClient.BaseURL := URL_BASE_PRESTADORES + '/' + aId.ToString;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    if (FRESTResponse.StatusCode = API_SUCESSO) then
    begin
      xMemTable.LoadFromJSON(FRESTResponse.Content);

      if (xMemTable.FindFirst) then
        Result := TPrestador.Create(xMemTable.FieldByName('id').AsInteger);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServicePrestador.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_CLIENTES;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Params.AddBody(FPrestador.JSON);
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Prestador não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;
