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
    FSituacao_Tributaria : Integer;
    FLocal_Prest_Servico : String;
    FTrib_mun_Prestado : String;
    FValorUnitario : Currency;
    FJSON : TJSONObject;

    function GetAliquotaServico: Double;
    function GetCodServico: Integer;
    function GetDescricaoServico: String;
    function GetId: Integer;
    function GetLocalPrestacaoServico: String;
    function GetSituacaoTributaria: Integer;
    function GetJSON: TJSONObject;
    function GetTributacaoMunicipioPrestado: String;
    function GetValorUnitario: Currency;

    procedure SetAliquotaServico(const Value: Double);
    procedure SetCodServico(const Value: Integer);
    procedure SetDescricaoServico(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetLocalPrestacaoServico(const Value: String);
    procedure SetSituacaoTributaria(const Value: Integer);
    procedure SetTributacaoMunicipioPrestado(const Value: String);
    procedure SetValorUnitario(const Value: Currency);
  public
    Constructor Create; overload;
    Constructor Create(aId : Integer); overload;
    Constructor Create(aId, aCodServico, aSituacaoTributaria: Integer;
    aDescricao, aLocalPrest : String; aTribMunPrestado : String; aValor : Currency
    ; aAliquota : Double);overload;
    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property DescricaoServico : String read GetDescricaoServico write SetDescricaoServico;
    property CodServico : Integer read GetCodServico write SetCodServico;
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

constructor TServico.Create(aId, aCodServico,
  aSituacaoTributaria: Integer; aDescricao, aLocalPrest: String;
  aTribMunPrestado: String; aValor: Currency; aAliquota: Double);
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

function TServico.GetJSON: TJSONObject;
begin
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


procedure TServico.SetTributacaoMunicipioPrestado(const Value: String);
begin
  FTrib_mun_Prestado := Value;
end;

procedure TServico.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
