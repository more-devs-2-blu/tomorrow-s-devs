unit UService.ItemServico;

interface

Uses
  UService.Base,
  Generics.Collections,
  UEntity.ItemServico, UEntity.Servico, UEntity.Nota, UEntity.Prestador,
  UEntity.Cliente;

type
  TServiceItemServico = class(TServiceBase)
  private
    FItemServico: TItemServico;
    FItemServicos: TObjectList<TItemServico>;

    function GetItemServicos: TObjectList<TItemServico>;

    procedure PreencherItemServicos(const aJsonServicos: String);
    procedure CarregarServicos(const aJsonServico: String; var aServico : TServico);
    procedure CarregarNota(const aJsonNota: String; var aNota : TNota);
    procedure CarregarCliente(const aJsonCliente : String; var aCliente : TCliente);
    procedure CarregarPrestador(const aJsonPrestador : String; var aPrestador : TPrestador);

  public
    constructor Create; overload;
    constructor Create(aItemServico: TItemServico); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;


    function ObterRegistro(const aId: Integer): TObject; override;

    property ItemServicos: TObjectList<TItemServico> read GetItemServicos;
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

{ TServiceItemServico }

constructor TServiceItemServico.Create;
begin
  Inherited Create;

  FItemServicos := TObjectList<TItemServico>.Create;
end;

constructor TServiceItemServico.Create(aItemServico: TItemServico);
begin
  FItemServico := aItemServico;
  Self.Create;
end;

destructor TServiceItemServico.Destroy;
begin
  FreeAndNil(FItemServico);
  FreeAndNil(FItemServicos);
  inherited;
end;

procedure TServiceItemServico.Excluir;
begin
  if (not Assigned(FItemServico)) or (FItemServico.Id = 0) then
    raise Exception.Create
      ('Nenhum Item de Serviço foi escolhido para exclusão.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_ITENS_SERVICOS+ '/%d',
      [FItemServico.Id]);
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

function TServiceItemServico.GetItemServicos: TObjectList<TItemServico>;
begin
  Result := FItemServicos;
end;

procedure TServiceItemServico.Listar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_ITENS_SERVICOS;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherItemServicos(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create
        ('Erro ao carregar a lista de Times. Código do Erro: ' +
        FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceItemServico.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //
end;

procedure TServiceItemServico.PreencherItemServicos(const aJsonServicos
  : String);
  var
 xMemTable: TFDMemTable;
  xServico: TServico;
  xStatus: Byte;
begin
  FItemServicos.Clear;

  xMemTable := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(FRESTResponse.Content);

    while not xMemTable.Eof do
    begin
      Self.CarregarServicos(xMemTable.FieldByName('SERVICO').AsString,
                         xServico);


      FItemServicos.Add(TItemServico.Create(
        xMemTable.FieldByName('ID').AsInteger,
        xMemTable.FieldByName('QUANTIDADE').AsInteger,
        xServico,
        xMemTable.FieldByName('result_Team_A').AsInteger,
        xMemTable.FieldByName('result_Team_B').AsInteger,
 ));

      xMemTable.Next;
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;



procedure TServiceItemServico.CarregarCliente(const aJsonCliente: String;
  var aCliente: TCliente);
  var
  xMemTable: TFDMemTable;
  xMemTableTeam: TFDMemTable;
begin
  aCliente        := nil;
  xMemTable     := TFDMemTable.Create(nil);
  xMemTableTeam := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonCliente);

    if xMemTable.RecordCount > 0 then    begin

      aCliente := TCliente.Create(
        xMemTable.FieldByName('id').AsInteger,
        xMemTable.FieldByName('email').AsString,
        xMemTable.FieldByName('cnpj').AsString,
        xMemTable.FieldByName('razaoSocial').AsFloat,
        xMemTable.FieldByName('nomeFantasia').AsString,
        xMemTable.FieldByName('logradouro').AsString,
        xMemTable.FieldByName('bairro').AsString,
        xMemTable.FieldByName('complemento').AsString,
        xMemTable.FieldByName('numero').AsInteger,
        xMemTable.FieldByName('cidade').AsString,
        xMemTable.FieldByName('endInformado').AsString,
        xMemTable.FieldByName('tipoCliente').AsString,
        xMemTable.FieldByName('inscEstadual').AsString);
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableTeam);
  end;
end;

procedure TServiceItemServico.CarregarNota(const aJsonNota: String;
  var aNota: TNota);
var
  xMemTable: TFDMemTable;
  xMemTableTeam: TFDMemTable;
  xStatus: Byte;
begin
  aNota        := nil;
  xMemTable     := TFDMemTable.Create(nil);
  xMemTableTeam := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonNota);

    if xMemTable.RecordCount > 0 then    begin

      aNota := TServico.Create(
        xMemTable.FieldByName('id').AsInteger,
        xMemTable.FieldByName('valorTotal').AsString,
        xMemTable.FieldByName('statusNota').AsInteger,
        xMemTable.FieldByName('chaveIndentificador').AsFloat,
        xMemTable.FieldByName('dataEmissao').AsInteger,
        xMemTable.FieldByName('idCliente').AsString,
        xMemTable.FieldByName('idPrestador').AsString);
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableTeam);
  end;
end;

procedure TServiceItemServico.CarregarPrestador(const aJsonPrestador: String;
  var aPrestador: TPrestador);
begin

end;

procedure TServiceItemServico.CarregarServicos(const aJsonServico: String; var aServico : TServico);
var
  xMemTable: TFDMemTable;
  xMemTableTeam: TFDMemTable;
  xStatus: Byte;
begin
  aServico        := nil;
  xMemTable     := TFDMemTable.Create(nil);
  xMemTableTeam := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonServico);

    if xMemTable.RecordCount > 0 then    begin

      aServico := TServico.Create(
        xMemTable.FieldByName('id').AsInteger,
        xMemTable.FieldByName('descricao').AsString,
        xMemTable.FieldByName('codigo').AsInteger,
        xMemTable.FieldByName('aliquota').AsFloat,
        xMemTable.FieldByName('situacaoTributaria').AsInteger,
        xMemTable.FieldByName('localPrestacao').AsString,
        xMemTable.FieldByName('tributacaoMunicipal').AsString,
        xMemTable.FieldByName('valorUnitario').AsCurrency);
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableTeam);
  end;
end;

procedure TServiceItemServico.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_ITENS_SERVICOS;
    FRESTRequest.Params.AddBody(FItemServico.JSON);
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
