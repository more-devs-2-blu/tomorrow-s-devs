unit UUtils.JSON;

interface

uses
  System.JSON;

type
  TJSONUtil = class
  public
    class function BuscarPropriedadeJSON(aPropriedade,
      aJSONString: String): String;
    class function RetornarJSONArray(aPropriedade, aJSONString: String)
      : TJSONArray;
  end;

implementation

uses
  System.SysUtils;

{ TJSONUtil }

class function TJSONUtil.BuscarPropriedadeJSON(aPropriedade,
  aJSONString: String): String;
var
  xValorJSON: TJSONValue;
  xJSON: TJSONObject;
begin
  xJSON := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(aJSONString), 0)
    as TJSONObject;
  xValorJSON := xJSON.Get(aPropriedade).JsonValue;
  Result := xValorJSON.Value;
end;

class function TJSONUtil.RetornarJSONArray(aPropriedade, aJSONString: String)
  : TJSONArray;
var
  xJSONArray: TJSONArray;
  xJSON: TJSONObject;
begin
  xJSON := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(aJSONString), 0)
    as TJSONObject;
  xJSONArray := xJSON.GetValue(aPropriedade) as TJSONArray;
  Result := xJSONArray;
end;

end.
