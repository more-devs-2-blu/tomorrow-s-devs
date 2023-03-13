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

{ TDAOPrestador }

constructor TDAOPrestador.Create;
begin
  FTabela := 'prestador';
end;


end.
