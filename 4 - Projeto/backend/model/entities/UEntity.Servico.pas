unit UEntity.Servico;

interface

uses
  System.JSON;

type
  TServico = class
  private
    FId: Integer;
    FDescricaoServico: String;
    FCod_Servico : Integer;
    FAliquotaServico : Double;
    FTipo_Tributacao : Integer;
    FSituacao_Tributaria : Integer;
    FLocal_Prest_Servico : String;
    FTrib_mun_Prestado : Char;
    FValorUnitario : Currency;
    FJSON : TJSONObject;

    function GetAliquotaServico: Double;
    function GetCodServico: Integer;
    function GetDescricaoServico: String;
    function GetId: Integer;
    function GetLocalPrestacaoServico: String;
    function GetSituacaoTributaria: Integer;
    function GetTipoTributacao: Integer;
    function GetJSON: TJSONObject;
    function GetTributacaoMunicipioPrestado: Char;
    function GetValorUnitario: Currency;

    procedure SetAliquotaServico(const Value: Double);
    procedure SetCodServico(const Value: Integer);
    procedure SetDescricaoServico(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetLocalPrestacaoServico(const Value: String);
    procedure SetSituacaoTributaria(const Value: Integer);
    procedure SetTipoTributacao(const Value: Integer);
    procedure SetTributacaoMunicipioPrestado(const Value: Char);
    procedure SetValorUnitario(const Value: Currency);
  public
    Constructor Create; overload;
    Constructor Create(aId, aTipoTributacao, aCodServico, aSituacaoTributaria: Integer;
    aDescricao, aLocalPrest, aServico : String; aTribMunPrestado : Char; aValor : Currency
    ; aAliquota : Double);overload;
    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property DescricaoServico : String read GetDescricaoServico write SetDescricaoServico;
    property CodServico : Integer read GetCodServico write SetCodServico;
    property AliquotaServico : Double read GetAliquotaServico write SetAliquotaServico;
    property TipoTributacao : Integer read GetTipoTributacao write SetTipoTributacao;
    property SituacaoTributaria : Integer read GetSituacaoTributaria write SetSituacaoTributaria;
    property LocalPrestacaoServico : String read GetLocalPrestacaoServico write SetLocalPrestacaoServico;
    property TributacaoMunicipioPrestado : Char read GetTributacaoMunicipioPrestado write SetTributacaoMunicipioPrestado;
    property ValorUnitario : Currency read GetValorUnitario write SetValorUnitario;
    property JSON : TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TServico }

constructor TServico.Create(aId, aTipoTributacao, aCodServico,
  aSituacaoTributaria: Integer; aDescricao, aLocalPrest, aServico: String;
  aTribMunPrestado: Char; aValor: Currency; aAliquota: Double);
begin
    FId := aId;
    FDescricaoServico := aDescricao;
    FCod_Servico := aCodServico;
    FAliquotaServico := aAliquota;
    FTipo_Tributacao := aTipoTributacao;
    FSituacao_Tributaria := aSituacaoTributaria;
    FLocal_Prest_Servico := aLocalPrest;
    FTrib_mun_Prestado := aTribMunPrestado;
    FValorUnitario := aValor;

    Self.Create;
end;

constructor TServico.Create;
begin
  FJSON := TJSONObject.Create;
end;

destructor TServico.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TServico.GetAliquotaServico: Double;
begin
  Result := FAliquotaServico;
end;


function TServico.GetCodServico: Integer;
begin
  Result := FCod_Servico;
end;

function TServico.GetDescricaoServico: String;
begin
  Result := FDescricaoServico;
end;

function TServico.GetId: Integer;
begin
  Result := FId;
end;

function TServico.GetLocalPrestacaoServico: String;
begin
  Result := FLocal_Prest_Servico;
end;

function TServico.GetSituacaoTributaria: Integer;
begin
  Result := FSituacao_Tributaria;
end;

function TServico.GetTipoTributacao: Integer;
begin
  Result := FTipo_Tributacao;
end;

function TServico.GetJSON: TJSONObject;
begin
  Result := FJSON;
end;

function TServico.GetTributacaoMunicipioPrestado: Char;
begin
  Result := FTrib_mun_Prestado;
end;

function TServico.GetValorUnitario: Currency;
begin
  Result := FValorUnitario;
end;

procedure TServico.SetAliquotaServico(const Value: Double);
begin
  FAliquotaServico := Value;
end;

procedure TServico.SetCodServico(const Value: Integer);
begin
  FCod_Servico := Value;
end;

procedure TServico.SetDescricaoServico(const Value: String);
begin
  FDescricaoServico := Value;
end;

procedure TServico.SetId(const Value: Integer);
begin
  FId := Value;
end;


procedure TServico.SetLocalPrestacaoServico(const Value: String);
begin
  FLocal_Prest_Servico := Value;
end;

procedure TServico.SetSituacaoTributaria(const Value: Integer);
begin
  FSituacao_Tributaria := Value;
end;

procedure TServico.SetTipoTributacao(const Value: Integer);
begin
  FTipo_Tributacao := Value;
end;

procedure TServico.SetTributacaoMunicipioPrestado(const Value: Char);
begin
  FTrib_mun_Prestado := Value;
end;

procedure TServico.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
