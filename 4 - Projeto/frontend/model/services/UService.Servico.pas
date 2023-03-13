unit UService.Servico;

interface

uses
  UEntity.Servico,
  UService.Base,
  Generics.Collections;

type
  TServiceServico = class(TServiceBase)
  private
    FServico: TServico;
    FServicos: TObjectList<TServico>;
    function GetServicos: TObjectList<TServico>;
  public
    constructor Create; overload;
    constructor Create(aServico: TServico); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;

    property Servicos: TObjectList<TServico> read GetServicos;
  end;

implementation

uses
  System.SysUtils,
  System.JSON, UUtils.Constants, DataSet.Serialize,
  FireDAC.Comp.Client, REST.Types;

{ TServiceServico }

constructor TServiceServico.Create;
begin
  Inherited Create;

  FServicos := TObjectList<TServico>.Create;
end;

constructor TServiceServico.Create(aServico: TServico);
begin
  FServico := aServico;
  Self.Create;
end;

destructor TServiceServico.Destroy;
begin
  FreeAndNil(FServico);
  FreeAndNil(FServicos);
  inherited;
end;

procedure TServiceServico.Excluir;
begin

  if (not Assigned(FServico)) or (FServico.Id = 0) then
    raise Exception.Create('Nenhum time foi encontrado para exclusão.');

    try
      FRESTClient.BaseURL := Format(URL_BASE_SERVICOS + '/d', [FServico.Id]);
      FRESTRequest.Method := rmDELETE;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO_SEM_RETORNO:
          Exit;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não encontrado.');
        else
          raise Exception.Create('Erro não catalogado.');
      end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
end;

function TServiceServico.GetServicos: TObjectList<TServico>;
begin
  Result := FServicos;
end;

procedure TServiceServico.Listar;
var
  xMemTable : TFDMemTable;
begin
  FServicos.Clear;

  xMemTable := TFDMemTable.Create(nil);
  try
    try
      FRESTClient.BaseURL := URL_BASE_SERVICOS;
      FRESTRequest.Method := rmGet;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          xMemTable.LoadFromJSON(FRESTResponse.Content);

          while not xMemTable.Eof do
          begin
            FServicos.Add(TServico.Create(xMemTable.FieldByName('id').AsInteger,
            xMemTable.FieldByName('descricao').AsString));
            xMemTable.Next;
          end;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não autorizado.');
        else
          raise Exception.Create('Erro ao carregar a lista de times. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
      end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
  inherited;

end;

function TServiceServico.ObterRegistro(const aId: Integer): TObject;
var
  xMemTable: TFDMemTable;
begin
  Result := nil;

  xMemTable := TFDMemTable.Create(nil);

  try
    FRESTClient.BaseURL := URL_BASE_SERVICOS + '/' + aId.ToString;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    if (FRESTResponse.StatusCode = API_SUCESSO) then
    begin
      xMemTable.LoadFromJSON(FRESTResponse.Content);

      if (xMemTable.FindFirst) then
        Result := TServico.Create(xMemTable.FieldByName('id').AsInteger);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceServico.Registrar;
begin
   try
    FRESTClient.BaseURL := URL_BASE_SERVICOS;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Params.AddBody(FServico.JSON);
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuario não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;

end;

end.
