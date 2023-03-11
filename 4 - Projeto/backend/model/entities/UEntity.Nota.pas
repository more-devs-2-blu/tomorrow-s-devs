unit UEntity.Nota;

interface

uses
  System.JSON, UEntity.Cliente, UEntity.Prestador;

type
  TNota = class
  private
    FId: Integer;
    FDataEmissao : TDate;
    FChaveIndentificador : String;
    FStatus : String;
    FValorTotal : Currency;
    FCliente : TCliente;
    FPrestador : TPrestador;
    FJSON : TJSONObject;

    function GetChaveidentificador: String;
    function GetCliente: TCliente;
    function GetDataEmissao: TDate;
    function GetId: Integer;
    function GetJSON: TJSONObject;
    function GetPrestador: TPrestador;
    function GetStatus: String;
    function GetValorTotal: Currency;

    procedure SetChaveIdentificador(const Value: String);
    procedure SetCliente(const Value: TCliente);
    procedure SetDataEmissao(const Value: TDate);
    procedure SetId(const Value: Integer);
    procedure SetPrestador(const Value: TPrestador);
    procedure SetStatus(const Value: String);
    procedure SetValorTotal(const Value: Currency);
  public
    Constructor Create; overload;
    Constructor Create(aId : Integer; aDataEmissao : TDate; avalorTotal : Currency;
     aStatus, aChaveIdentificador : String; aCliente : TCliente; aPrestador : TPrestador); overload;
    Destructor Destroy; override;

    property Id : Integer read GetId write SetId;
    property DataEmissao : TDate read GetDataEmissao write SetDataEmissao;
    property ChaveIdentificador : String read GetChaveidentificador write SetChaveIdentificador;
    property Status : String read GetStatus write SetStatus;
    property ValorTotal : Currency read GetValorTotal write SetValorTotal;
    property Cliente : TCliente read GetCliente write SetCliente;
    property Prestador : TPrestador read GetPrestador write SetPrestador;
    property JSON : TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TNota }

constructor TNota.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TNota.Create(aId: Integer; aDataEmissao: TDate;
  aValorTotal: Currency; aStatus, aChaveIdentificador: String;
  aCliente: TCliente; aPrestador: TPrestador);
begin
  FId := aId;
  FDataEmissao := aDataEmissao;
  FChaveIndentificador := aChaveIdentificador;
  FStatus := aStatus;
  FValorTotal := aValorTotal;
  FCliente := aCliente;
  FPrestador := aPrestador;
end;

destructor TNota.Destroy;
begin
  FreeAndNil(FJSON);
  FreeAndNil(FCliente);
  FreeAndNil(FPrestador);
  inherited;
end;

function TNota.GetChaveidentificador: String;
begin
  Result := FChaveIndentificador;
end;

function TNota.GetCliente: TCliente;
begin
  Result := FCliente;
end;

function TNota.GetDataEmissao: TDate;
begin
  Result := FDataEmissao;
end;

function TNota.GetId: Integer;
begin
  Result := FId;
end;

function TNota.GetJSON: TJSONObject;
begin
  Result := FJSON;
end;

function TNota.GetPrestador: TPrestador;
begin
  Result := FPrestador;
end;

function TNota.GetStatus: String;
begin
  Result := FStatus;
end;

function TNota.GetValorTotal: Currency;
begin
  Result := FValorTotal;
end;

procedure TNota.SetChaveIdentificador(const Value: String);
begin
  FChaveIndentificador := Value;
end;

procedure TNota.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TNota.SetDataEmissao(const Value: TDate);
begin
  FDataEmissao := Value;
end;

procedure TNota.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TNota.SetPrestador(const Value: TPrestador);
begin
  FPrestador := Value;
end;

procedure TNota.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TNota.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
