unit UController.Login;

interface

uses
  Horse,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
//  UEntity.Logins,
  UController.Base;

type
  TControllerLogin = class(TControllerBase)
    private
    public
    class procedure PostLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

uses
  JSON, SysUtils, UController.Usuario;

{ TControllerLogin }

class procedure TControllerLogin.PostLogin(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xToken: TJWT;
  xCompactToken: String;
  xJSONLogin: TJSONObject;
  xUser, xPassword: String;
begin
  xToken := TJWT.Create;
  try
    xToken.Claims.Issuer := 'Tomorrow_s Devs';
    xToken.Claims.Subject := 'Projeto final em grupo';
    xToken.Claims.Expiration := Now + 1;

    xJSONLogin := Req.Body<TJSONObject>;
    if not Assigned(xJSONLogin) then
    begin
      Res.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if not xJSONLogin.TryGetValue<String>('login', xUser) then
    begin
      Res.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if not xJSONLogin.TryGetValue<String>('senha', xPassword) then
    begin
      Res.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    xToken.Claims.SetClaimOfType<Integer>('id', UController.Usuario.GidUsuario);
    xToken.Claims.SetClaimOfType<String>('login', xUser);

//    xCompactToken := TJOSE.SHA256CompactToken('SECRET_KEY', xToken);
//
//    Res.Send(xCompactToken);
  finally
    xToken.Free;
  end;

end;

end.
