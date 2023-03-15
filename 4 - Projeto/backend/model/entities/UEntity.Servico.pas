unit UEntity.Servico;

interface

uses
  System.JSON;

type
  TServico = class
  private
    FId: Integer;
    FDescricaoServico: String;
    FCod_Servico : String;
    FAliquotaServico : Double;
    FSituacao_Tributaria : Integer;
    FLocal_Prest_Servico : String;
    FTrib_mun_Prestado : String;
    FValorUnitario : Currency;
    FJSON : TJSONObject;

    function GetAliquotaServico: Double;
    function GetCodServico: String;
    function GetDescricaoServico: String;
    function GetId: Integer;
    function GetLocalPrestacaoServico: String;
    function GetSituacaoTributaria: Integer;
    function GetJSON: TJSONObject;
    function GetTributacaoMunicipioPrestado: String;
    function GetValorUnitario: Currency;

    procedure SetAliquotaServico(const Value: Double);
    procedure SetCodServico(const Value: String);
    procedure SetDescricaoServico(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetLocalPrestacaoServico(const Value: String);
    procedure SetSituacaoTributaria(const Value: Integer);
    procedure SetTributacaoMunicipioPrestado(const Value: String);
    procedure SetValorUnitario(const Value: Currency);
  public
    Constructor Create; overload;
    Constructor Create(aId : Integer); overload;
    Constructor Create(aId,  aSituacaoTributaria: Integer;
    aDescricao, aLocalPrest : String; aCodServico, aTribMunPrestado : String; aValor : Currency
    ; aAliquota : Double);overload;
    Constructor Create( aSituacaoTributaria: Integer;
    aDescricao, aLocalPrest : String; aCodServico, aTribMunPrestado : String; aValor : Currency
    ; aAliquota : Double);overload;
    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property DescricaoServico : String read GetDescricaoServico write SetDescricaoServico;
    property CodServico : String read GetCodServico write SetCodServico;
    property AliquotaServico : Double read GetAliquotaServico write SetAliquotaServico;
    property SituacaoTributaria : Integer read GetSituacaoTributaria write SetSituacaoTributaria;
    property LocalPrestacaoServico : String read GetLocalPrestacaoServico write SetLocalPrestacaoServico;
    property TributacaoMunicipioPrestado : String read GetTributacaoMunicipioPrestado write SetTributacaoMunicipioPrestado;
    property ValorUnitario : Currency read GetValorUnitario write SetValorUnitario;
    property JSON : TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TServico }

constructor TServico.Create(aId,
  aSituacaoTributaria: Integer; aDescricao, aLocalPrest: String;
  aCodServico, aTribMunPrestado: String; aValor: Currency; aAliquota: Double);
begin
    FId := aId;
    FDescricaoServico := aDescricao;
    FCod_Servico := aCodServico;
    FAliquotaServico := aAliquota;
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

constructor TServico.Create(aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TServico.Create(aSituacaoTributaria: Integer; aDescricao,
  aLocalPrest, aCodServico, aTribMunPrestado: String; aValor: Currency;
  aAliquota: Double);
begin
    FDescricaoServico := aDescricao;
    FCod_Servico := aCodServico;
    FAliquotaServico := aAliquota;
    FSituacao_Tributaria := aSituacaoTributaria;
    FLocal_Prest_Servico := aLocalPrest;
    FTrib_mun_Prestado := aTribMunPrestado;
    FValorUnitario := aValor;

    Self.Create;
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

function TServico.GetCodServico: String;
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

function TServico.GetJSON: TJSONObject;
begin
  FJSON.AddPair('descricao', FDescricaoServico);
  FJSON.AddPair('codigo', FCod_Servico);
  FJSON.AddPair('aliquota', CurrToStr(FAliquotaServico));
  FJSON.AddPair('situacao_Tributaria', FSituacao_Tributaria.ToString);
  FJSON.AddPair('local_Prestacao', FLocal_Prest_Servico);
  FJSON.AddPair('tributacao_Municipal', FTrib_mun_Prestado);
  FJSON.AddPair('valor_Unitario', CurrToStr(FValorUnitario));

  Result := FJSON;
end;

function TServico.GetTributacaoMunicipioPrestado: String;
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

procedure TServico.SetCodServico(const Value: String);
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


procedure TServico.SetTributacaoMunicipioPrestado(const Value: String);
begin
  FTrib_mun_Prestado := Value;
end;

procedure TServico.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
