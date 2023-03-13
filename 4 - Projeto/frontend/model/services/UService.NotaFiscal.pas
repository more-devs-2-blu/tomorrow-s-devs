unit UService.NotaFiscal;

interface

Uses
  UService.Base,
  Generics.Collections,
  UEntity.Nota;

type
  TServiceNotaFiscal = class(TServiceBase)
  private
    FNota: TNota;
    FNotas: TObjectList<TNota>;

    function GetNotas: TObjectList<TNota>;

    procedure PreencherNotas(const aJsonNotas: String);

  public
    constructor Create; overload;
    constructor Create(aNota: TNota); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;

    property Notas: TObjectList<TNota> read GetNotas;
  end;

implementation

uses
  System.SysUtils,
  REST.Types,
  UService.Intf,
  UUtils.Constants,
  DataSet.Serialize,
  FireDAC.Comp.Client,
  UUtils.Functions;

{ TServiceNotaFiscal }

constructor TServiceNotaFiscal.Create;
begin
  Inherited Create;

  FNotas := TObjectList<TNota>.Create;
end;

constructor TServiceNotaFiscal.Create(aNota: TNota);
begin
  FNota := aNota;
  Self.Create;
end;

destructor TServiceNotaFiscal.Destroy;
begin
  FreeAndNil(FNota);
  FreeAndNil(FNotas);
  inherited;
end;

procedure TServiceNotaFiscal.Excluir;
begin
  if (not Assigned(FNota)) or (FNota.Id = 0) then
    raise Exception.Create('Nenhum Orçamento foi escolhido para exclusão.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_NOTAS_FISCAIS + '/%d', [FNota.Id]);
    FRESTRequest.Method := rmDelete;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO_SEM_RETORNO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceNotaFiscal.GetNotas: TObjectList<TNota>;
begin
  Result := FNotas;
end;

procedure TServiceNotaFiscal.Listar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_NOTAS_FISCAIS;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherNotas(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create
        ('Erro ao carregar a lista de Notas Fiscais. Código do Erro: ' +
        FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceNotaFiscal.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //
end;

procedure TServiceNotaFiscal.PreencherNotas(const aJsonNotas: String);
begin
  //
end;

procedure TServiceNotaFiscal.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_NOTAS_FISCAIS;
    FRESTRequest.Params.AddBody(FNota.JSON);
    FRESTRequest.Method := rmPost;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
