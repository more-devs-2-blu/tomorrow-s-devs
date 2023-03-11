unit UEntity.Prestador;

interface

uses
  System.JSON;

type
  TPrestador = class
  private
    FId: Integer;
    FCNPJ : String;
    FCidadePrestador : String;
    FJSON : TJSONObject;
    function GetCidadePrestador: String;
    function GetCNPJ: String;
    function GetId: Integer;
    function GetJSON: TJSONObject;
    procedure SetCidadePrestador(const Value: String);
    procedure SetCNPJ(const Value: String);
    procedure SetId(const Value: Integer);
  public
    constructor Create; overload;
    constructor Create(aId : Integer; aCNPJ, aCidadePrestador : String); overload;
    destructor Destroy; override;

    property Id : Integer read GetId write SetId;
    property CNPJ : String read GetCNPJ write SetCNPJ;
    property CidadePrestador : String read GetCidadePrestador write SetCidadePrestador;
    property JSON : TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TPrestador }

constructor TPrestador.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TPrestador.Create(aId: Integer; aCNPJ, aCidadePrestador: String);
begin
  FId := aId;
  FCNPJ := aCNPJ;
  FCidadePrestador := aCidadePrestador;
end;

destructor TPrestador.Destroy;
begin
  FreeAndNil(JSON);
  inherited;
end;

function TPrestador.GetCidadePrestador: String;
begin
  Result := FCidadePrestador;
end;

function TPrestador.GetCNPJ: String;
begin
  Result := FCNPJ;
end;

function TPrestador.GetId: Integer;
begin
  Result := FId;
end;

function TPrestador.GetJSON: TJSONObject;
begin
  Result := FJSON;
end;

procedure TPrestador.SetCidadePrestador(const Value: String);
begin
  FCidadePrestador := Value;
end;

procedure TPrestador.SetCNPJ(const Value: String);
begin
  FCNPJ:= Value;
end;

procedure TPrestador.SetId(const Value: Integer);
begin
  FId := Value;
end;

end.
