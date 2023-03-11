unit UDAO.Prestador;

interface

uses
  UDAO.Base;

type
  TDAOPrestador = class(TDAOBase)
  public
    constructor Create;
  end;

implementation

{ TDAOPecas }

constructor TDAOPrestador.Create;
begin
  FTabela := 'prestador';
end;


end.
