unit UService.Intf;

interface

type
  IService = interface
    procedure Registrar;
    procedure Listar;
    procedure Excluir;

    function ObterRegistro(const aId: Integer): TObject;
  end;

implementation

end.
