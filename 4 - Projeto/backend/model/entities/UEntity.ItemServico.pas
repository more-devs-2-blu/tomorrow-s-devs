unit UEntity.ItemServico;

interface

uses
  System.JSON, UEntity.Nota, UEntity.Servico;

type
  TItemServico = class
  private
    FId: Integer;
    FQuantidadeServicos : Integer;
    FNota : TNota;
    FServico : TServico;
    FJSON : TJSONObject;

    function GetId: Integer;
    function GetNota: TNota;
    function GetQuantidadeServicos: Integer;

    procedure SetId(const Value: Integer);
    procedure SetNota(const Value: TNota);
    procedure SetQuantidadeServicos(const Value: Integer);
    function GetJSON: TJSONObject;
    function GetServico: TServico;
    procedure SetServico(const Value: TServico);
  public
    Constructor Create; overload;
    Constructor Create(aId : Integer); overload;
    Constructor Create(aId, aQuantidadeServicos : Integer; aNota : TNota; aServico : TServico); overload;
    Destructor Destroy; override;

    property Id : Integer read GetId write SetId;
    property QuantidadeServicos : Integer read GetQuantidadeServicos write SetQuantidadeServicos;
    property Nota : TNota read GetNota write SetNota;
    property Servico : TServico read GetServico write SetServico;
    property JSON : TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TItemServico }

constructor TItemServico.Create(aId, aQuantidadeServicos: Integer;
  aNota: TNota; aServico : TServico);
begin
  FId := aId;
  FQuantidadeServicos := aQuantidadeServicos;
  FNota := aNota;
  FServico := aServico;
  Self.Create;
end;

constructor TItemServico.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TItemServico.Create(aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

destructor TItemServico.Destroy;
begin
  FreeAndNil(FNota);
  FreeAndNil(FServico);

  FreeAndNil(FJSON);
  inherited;
end;

function TItemServico.GetId: Integer;
begin
  Result := FId;
end;

function TItemServico.GetNota: TNota;
begin
  Result := FNota;
end;

function TItemServico.GetQuantidadeServicos: Integer;
begin
  Result := FQuantidadeServicos;
end;

function TItemServico.GetServico: TServico;
begin
  Result :=  FServico;
end;

function TItemServico.GetJSON: TJSONObject;
begin
  Result := FJSON;
end;

procedure TItemServico.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TItemServico.SetNota(const Value: TNota);
begin
  FNota := Value;
end;

procedure TItemServico.SetQuantidadeServicos(const Value: Integer);
begin
  FQuantidadeServicos := Value;
end;

procedure TItemServico.SetServico(const Value: TServico);
begin
  FServico := Value;
end;

end.
