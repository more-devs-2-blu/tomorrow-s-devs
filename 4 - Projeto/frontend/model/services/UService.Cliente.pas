unit UService.Cliente;

interface

uses
  UEntity.Cliente, UService.Base;

type
  TServiceCliente = class(TServiceBase)
  private
    FCliente: TCliente;
  public
    constructor Create; overload;
    constructor Create(aCliente: TCliente); overload;
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

{ TServiceCliente }

constructor TServiceCliente.Create;
begin
  Inherited Create;
end;

constructor TServiceCliente.Create(aCliente: TCliente);
begin
  FCliente := aCliente;
  self.Create;
end;

destructor TServiceCliente.Destroy;
begin
  FreeAndNil(FCliente);
  Inherited;
end;

procedure TServiceCliente.Excluir;
begin
  inherited;
//
end;

procedure TServiceCliente.Listar;
begin
  inherited;
//
end;

function TServiceCliente.ObterRegistro(const aId: Integer): TObject;
var
  xMemTable: TFDMemTable;
begin
  Result := nil;

  xMemTable := TFDMemTable.Create(nil);

  try
    FRESTClient.BaseURL := URL_BASE_CLIENTES + '/' + aId.ToString;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    if (FRESTResponse.StatusCode = API_SUCESSO) then
    begin
      xMemTable.LoadFromJSON(FRESTResponse.Content);

      if (xMemTable.FindFirst) then
        Result := TCliente.Create(xMemTable.FieldByName('id').AsInteger);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceCliente.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_CLIENTES;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Params.AddBody(FCliente.JSON);
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Cliente não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

