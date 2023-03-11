unit UController.Servico;

interface

uses
  Horse,
  UController.Base;

type
  TControllerServico = class(TControllerBase)
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
  UDAO.Servico;

{ TControllerServico }

class procedure TControllerServico.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOServico.Create;
  inherited;
end;

class procedure TControllerServico.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOServico.Create;
  inherited;
end;

class procedure TControllerServico.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOServico.Create;
  inherited;
end;

class procedure TControllerServico.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOServico.Create;
  inherited;
end;

end.
