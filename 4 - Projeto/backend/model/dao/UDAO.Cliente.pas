unit UDAO.Cliente;

interface

uses
  UDAO.Base;

type
  TDAOCliente = class(TDAOBase)
  public
    constructor Create;
  end;

implementation

{ TDAOPecas }

constructor TDAOCliente.Create;
begin
  FTabela := 'cliente';
end;


end.
