unit UDAO.Servico;

interface

uses
  UDAO.Base;

type
  TDAOServico = class(TDAOBase)
    public
      constructor Create;
  end;

implementation

{ TDAOServico }

constructor TDAOServico.Create;
begin
  FTabela := 'servico';
end;

end.
