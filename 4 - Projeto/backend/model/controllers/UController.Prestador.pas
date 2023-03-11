unit UController.Prestador;

interface

uses
  Horse,
  UController.Base;

type
  TControllerPrestador = class (TControllerBase)
    private
    public
      class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
  end;

implementation

uses
  UDAO.Prestador;

{ TControllerPrestador }

class procedure TControllerPrestador.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOPrestador.Create;
  inherited;
end;

class procedure TControllerPrestador.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOPrestador.Create;
  inherited;
end;

class procedure TControllerPrestador.Gets(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOPrestador.Create;
  inherited;
end;

class procedure TControllerPrestador.Post(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOPrestador.Create;
  inherited;
end;

end.
