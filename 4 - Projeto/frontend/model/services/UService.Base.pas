unit UService.Base;

interface

uses
  UService.intf, REST.Client, REST.Types;

type
  TServiceBase = class(TInterfacedObject, IService)
    private

    protected
      FRESTClient: TRESTClient;
      FRESTRequest: TRESTRequest;
      FRESTResponse: TRESTResponse;

    procedure Registrar; virtual; abstract;
    procedure Listar; virtual; abstract;
    procedure Excluir; virtual; abstract;

    function ObterRegistro(const aId: Integer): TObject; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.Classes, System.SysUtils, Winapi.Windows;

{ TServiceBase }


constructor TServiceBase.Create;
begin

  FRESTClient   := TRESTClient.Create(nil);
  FRESTRequest  := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);

  FRESTRequest.Accept   := 'application/json';
  FRESTRequest.Client   := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
  FRESTRequest.Params.Clear;

end;

destructor TServiceBase.Destroy;
begin
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTResponse);
  inherited;
end;


end.
