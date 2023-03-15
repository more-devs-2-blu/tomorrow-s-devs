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
  xNota : TNota;
begin
  FItemServicos.Clear;

  xMemTable := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(FRESTResponse.Content);

    while not xMemTable.Eof do
    begin
      Self.CarregarServicos(xMemTable.FieldByName('servico').AsString,
                         xServico);

      Self.CarregarNota(xMemTable.FieldByName('nota').AsString, xNota);


      FItemServicos.Add(TItemServico.Create(
        xMemTable.FieldByName('id').AsInteger,
        xMemTable.FieldByName('quantidade').AsInteger,
        xNota, xServico
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
        xMemTable.FieldByName('numero').AsInteger,
        xMemTable.FieldByName('razao_Social').AsString,
        xMemTable.FieldByName('email').AsString,
        xMemTable.FieldByName('cnpj').AsString,
        xMemTable.FieldByName('nome_Fantasia').AsString,
        xMemTable.FieldByName('logradouro').AsString,
        xMemTable.FieldByName('bairro').AsString,
        xMemTable.FieldByName('complemento').AsString,
        xMemTable.FieldByName('cidade').AsString,
        xMemTable.FieldByName('end_Informado').AsString,
        xMemTable.FieldByName('insc_Estadual').AsString,
        xMemTable.FieldByName('tipo_Cliente').AsString
        );
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
  xPrestador : TPrestador;
  xCliente : TCliente;
begin
  aNota        := nil;
  xMemTable     := TFDMemTable.Create(nil);
  xMemTableTeam := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonNota);

    if xMemTable.RecordCount > 0 then
    begin

    Self.CarregarPrestador(xMemTable.FieldByName('prestador').AsString,
                         xPrestador);

    Self.CarregarCliente(xMemTable.FieldByName('cliente').AsString,
                         xCliente);

      aNota := TNota.Create(
        xMemTable.FieldByName('id').AsInteger,
        xMemTable.FieldByName('data_Emissao').AsDateTime,
        xMemTable.FieldByName('valor_Total').AsCurrency,
        xMemTable.FieldByName('status_Nota').AsString,
        xMemTable.FieldByName('chave_Identificador').AsString,
        xCliente,
        xPrestador);
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableTeam);
  end;
end;

procedure TServiceItemServico.CarregarPrestador(const aJsonPrestador: String;
  var aPrestador: TPrestador);
  var
  xMemTable: TFDMemTable;
  xMemTableTeam: TFDMemTable;
begin
  aPrestador        := nil;
  xMemTable     := TFDMemTable.Create(nil);
  xMemTableTeam := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonPrestador);

    if xMemTable.RecordCount > 0 then
    begin
     aPrestador := TPrestador.Create(
        xMemTable.FieldByName('id').AsInteger,
        xMemTable.FieldByName('cnpj').AsString,
        xMemTable.FieldByName('cidade').AsString);
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableTeam);
  end;
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
        xMemTable.FieldByName('situacao_Tributaria').AsInteger,
        xMemTable.FieldByName('descricao').AsString,
        xMemTable.FieldByName('local_Prestacao').AsString,
        xMemTable.FieldByName('codigo').AsString,
        xMemTable.FieldByName('tributacao_Municipal').AsString,
        xMemTable.FieldByName('valor_Unitario').AsCurrency,
        xMemTable.FieldByName('aliquota').AsFloat);
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
