unit UController.NotaFiscal;

interface

uses
  Horse,
  UController.Base, UUtil.Banco, System.JSON;

type
  TControllerNotaFiscal = class (TControllerBase)
    private
    public
      class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure GetCompleto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
      class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
  end;


implementation

uses
  UDAO.NotaFiscal;

{ TControllerNotaFiscal }

class procedure TControllerNotaFiscal.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAONotaFiscal.Create;
  inherited;
end;

class procedure TControllerNotaFiscal.Get(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAONotaFiscal.Create;
  inherited;
end;

class procedure TControllerNotaFiscal.GetCompleto(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAONotaFiscal.Create;
  inherited;
end;

class procedure TControllerNotaFiscal.Gets(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAONotaFiscal.Create;
  inherited;
end;

class procedure TControllerNotaFiscal.Post(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAONotaFiscal.Create;
  inherited;
  Res.Send<TJSONObject>(TUtilBanco.RetornarUltimoRegistro('nota'));
end;

end.
