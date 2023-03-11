unit UDAO.Usuario;

interface

uses
  UDAO.Base;

type
  TDAOUsuario = class(TDAOBase)
  public
    function ValidarLogin(const aUser, aPassword: String): Integer;
    constructor Create;
  end;

implementation

uses
  JSON, UUtil.Banco, SysUtils;

{ TDAOUsuario }

constructor TDAOUsuario.Create;
begin
  FTabela := 'usuario'
end;

function TDAOUsuario.ValidarLogin(const aUser, aPassword: String): Integer;
var
  xJSONArray: TJSONArray;
begin
  Result := 0;
  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format('SELECT * FROM %S WHERE Login = %s AND Senha = %s',
      [FTabela, QuotedStr(aUser), QuotedStr(aPassword)]));

    if Assigned(xJSONArray) and (xJSONArray.Count > 0) then
      Result := StrToIntDef(xJSONArray[0].FindValue('id').Value, 0)
  except on e: Exception do
    raise Exception.Create('Erro ao validar usuário: ' + e.Message);
  end;

end;

end.
