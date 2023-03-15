unit UEntity.Cliente;

interface

uses
  System.JSON;

type
  TCliente = class
  private
    FId: Integer;
    FRazaoSocial : String;
    FEmail : String;
    FCNPJ : String;
    FNomeFantasia : String;
    FLogradouro : String;
    FBairro : String;
    FComplemento : String;
    FNumero : Integer;
    FCidade : String;
    FEnderecoInformado : String;
    FTipoCliente : String;
    FInscricaoEstadual : String;
    FJSON : TJSONObject;

    function GetBairro: String;
    function GetCidade: String;
    function GetCNPJ: String;
    function GetComplemento: String;
    function GetEmail: String;
    function GetEnderecoInformado: String;
    function GetId: Integer;
    function GetInscricaoEstadual: String;
    function GetJSON: TJSONObject;
    function GetLogradouro: String;
    function GetNomeFantasia: String;
    function GetNumero: Integer;
    function GetRazaoSocial: String;
    function GetTipoCliente: String;

    procedure SetBairro(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetCNPJ(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetEnderecoInformado(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetInscricaoEstadual(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetNomeFantasia(const Value: String);
    procedure SetNumero(const Value: Integer);
    procedure SetRazaoSocial(const Value: String);
    procedure SetTipoCliente(const Value: String);
  public
    Constructor Create; overload;
    Constructor Create(aId : Integer); overload;
    Constructor Create(aId, aNumero : Integer; aRazaoSocial, aEmail, aCnpj, aNomeFantasia,
    aLogradouro, aBairro, aComplemento, aCidade, aEnderecoinformado, aInscricaoEstadual : String;
    aTipoCliente : String); overload;
    Constructor Create(aNumero : Integer; aRazaoSocial, aEmail, aCnpj, aNomeFantasia,
    aLogradouro, aBairro, aComplemento, aCidade, aEnderecoinformado, aInscricaoEstadual : String;
    aTipoCliente : String); overload;
    destructor Destroy; override;

    property Id : Integer read GetId write SetId;
    property RazaoSocial : String read GetRazaoSocial write SetRazaoSocial;
    property Email : String read GetEmail write SetEmail;
    property CNPJ : String read GetCNPJ write SetCNPJ;
    property NomeFantasia : String read GetNomeFantasia write SetNomeFantasia;
    property Logradouro : String read GetLogradouro write SetLogradouro;
    property Bairro : String read GetBairro write SetBairro;
    property Complemento : String read GetComplemento write SetComplemento;
    property Numero : Integer read GetNumero write SetNumero;
    property Cidade : String read GetCidade write SetCidade;
    property EnderecoInformado : String read GetEnderecoInformado write SetEnderecoInformado;
    property TipoCliente : String read GetTipoCliente write SetTipoCliente;
    property InscricaoEstadual : String read GetInscricaoEstadual write SetInscricaoEstadual;
    property JSON : TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TCliente }

constructor TCliente.Create(aId, aNumero: Integer; aRazaoSocial, aEmail, aCnpj,
  aNomeFantasia, aLogradouro, aBairro, aComplemento, aCidade,
  aEnderecoinformado, aInscricaoEstadual: String; aTipoCliente: String);
begin
    FId := aId;
    FRazaoSocial := aRazaoSocial;
    FEmail := aEmail;
    FCNPJ := aCnpj;
    FNomeFantasia := aNomeFantasia;
    FLogradouro := aLogradouro;
    FBairro := aBairro;
    FComplemento := aComplemento;
    FNumero := aNumero;
    FCidade := aCidade;
    FEnderecoInformado := aEnderecoinformado;
    FTipoCliente := aTipoCliente;
    FInscricaoEstadual := aInscricaoEstadual;

  Self.Create;
end;

constructor TCliente.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TCliente.Create(aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TCliente.Create(aNumero: Integer; aRazaoSocial, aEmail, aCnpj,
  aNomeFantasia, aLogradouro, aBairro, aComplemento, aCidade,
  aEnderecoinformado, aInscricaoEstadual, aTipoCliente: String);
begin
    FRazaoSocial := aRazaoSocial;
    FEmail := aEmail;
    FCNPJ := aCnpj;
    FNomeFantasia := aNomeFantasia;
    FLogradouro := aLogradouro;
    FBairro := aBairro;
    FComplemento := aComplemento;
    FNumero := aNumero;
    FCidade := aCidade;
    FEnderecoInformado := aEnderecoinformado;
    FTipoCliente := aTipoCliente;
    FInscricaoEstadual := aInscricaoEstadual;

  Self.Create;
end;

destructor TCliente.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TCliente.GetBairro: String;
begin
  Result := FBairro;
end;

function TCliente.GetCidade: String;
begin
  Result := FCidade;
end;

function TCliente.GetCNPJ: String;
begin
  Result := FCNPJ;
end;

function TCliente.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TCliente.GetEmail: String;
begin
  Result := FEmail;
end;

function TCliente.GetEnderecoInformado: String;
begin
  Result := FEnderecoInformado;
end;

function TCliente.GetId: Integer;
begin
  Result := FId;
end;

function TCliente.GetInscricaoEstadual: String;
begin
  Result := FInscricaoEstadual;
end;

function TCliente.GetJSON: TJSONObject;
begin
  FJSON.AddPair('email', FEmail);
  FJSON.AddPair('cnpj', FCNPJ);
  FJSON.AddPair('razao_Social', FRazaoSocial);
  FJSON.AddPair('nome_Fantasia', FNomeFantasia);
  FJSON.AddPair('logradouro', FLogradouro);
  FJSON.AddPair('bairro', FBairro);
  FJSON.AddPair('complemento', FComplemento);
  FJSON.AddPair('numero', FNumero.ToString);
  FJSON.AddPair('cidade', FCidade);
  FJSON.AddPair('end_Informado', FEnderecoInformado);
  FJSON.AddPair('tipo_Cliente', FTipoCliente);
  FJSON.AddPair('insc_Estadual', FInscricaoEstadual);

  Result := FJSON;
end;

function TCliente.GetLogradouro: String;
begin
  Result := FLogradouro;
end;

function TCliente.GetNomeFantasia: String;
begin
  Result := FNomeFantasia;
end;

function TCliente.GetNumero: Integer;
begin
  Result := FNumero;
end;

function TCliente.GetRazaoSocial: String;
begin
  Result := FRazaoSocial;
end;

function TCliente.GetTipoCliente: String;
begin
  Result := FTipoCliente;
end;

procedure TCliente.SetBairro(const Value: String);
begin
  FBairro := value;
end;

procedure TCliente.SetCidade(const Value: String);
begin
  FCidade := value;
end;

procedure TCliente.SetCNPJ(const Value: String);
begin
  FCNPJ := value;
end;

procedure TCliente.SetComplemento(const Value: String);
begin
  FComplemento := value;
end;

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := value;
end;

procedure TCliente.SetEnderecoInformado(const Value: String);
begin
  FEnderecoInformado := value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := value;
end;

procedure TCliente.SetInscricaoEstadual(const Value: String);
begin
  FInscricaoEstadual := value;
end;

procedure TCliente.SetLogradouro(const Value: String);
begin
  FLogradouro := value;
end;

procedure TCliente.SetNomeFantasia(const Value: String);
begin
  FNomeFantasia := value;
end;

procedure TCliente.SetNumero(const Value: Integer);
begin
  FNumero := value;
end;

procedure TCliente.SetRazaoSocial(const Value: String);
begin
  FRazaoSocial := value;
end;

procedure TCliente.SetTipoCliente(const Value: String);
begin
  FTipoCliente := value;
end;

end.
