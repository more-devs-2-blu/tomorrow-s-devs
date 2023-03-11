unit UController.Usuario;

interface

uses
  Horse,
  UController.Base;

type
  TControllerUsuario = class(TControllerBase)
  private
  public
    class function ValidateUser(const aUserName, aPassword: String): Boolean;

    class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
    class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
    class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
    class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

  end;

var
  GidUsuario: Integer;

implementation

uses
  UDAO.Usuario, UDAO.Intf;

{ TControllerUser }

class procedure TControllerUsuario.Delete(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  inherited;
end;

class procedure TControllerUsuario.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  inherited;
end;

class procedure TControllerUsuario.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  inherited;
end;

class procedure TControllerUsuario.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  inherited;
end;

class function TControllerUsuario.ValidateUser(const aUserName,
  aPassword: String): Boolean;
var
  xDAO: IDAO;
begin
  xDAO := TDAOUsuario.Create;

  GidUsuario := TDAOUsuario(xDAO).ValidarLogin(aUserName, aPassword);

  Result := GidUsuario > 0;
end;

end.
