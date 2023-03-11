unit UController.ItemServico;

interface

uses
  Horse,
  UController.Base;

type
  TControllerItemServico = class(TControllerBase)
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
  UDAO.ItemServico;

{ TControllerItemServico }

class procedure TControllerItemServico.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOItemServico.Create;
  inherited;
end;

class procedure TControllerItemServico.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOItemServico.Create;
  inherited;
end;

class procedure TControllerItemServico.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOItemServico.Create;
  inherited;
end;

class procedure TControllerItemServico.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOItemServico.Create;
  inherited;
end;

end.
