unit UController.Cliente;

interface

uses
  Horse,
  UController.Base;

type
  TControllerCliente = class(TControllerBase)
    private
    public
      class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
  end;

implementation

uses
  UDAO.Intf,
  UDAO.Cliente;

{ TControllerCliente }

class procedure TControllerCliente.Delete(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOCliente.Create;
  inherited;
end;

class procedure TControllerCliente.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOCliente.Create;
  inherited;
end;

class procedure TControllerCliente.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOCliente.Create;
  inherited;
end;

class procedure TControllerCliente.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOCliente.Create;
  inherited;
end;

end.
