program backend;

{$APPTYPE CONSOLE}

uses
  Horse,
  Horse.CORS,
  Horse.Jhonson,
  System.SysUtils,
  UDAO.Cliente in 'model\dao\UDAO.Cliente.pas',
  UDAO.Base in 'model\dao\UDAO.Base.pas',
  UDAO.Intf in 'model\dao\UDAO.Intf.pas',
  UUtil.Banco in 'model\utils\UUtil.Banco.pas',
  UDAO.Usuario in 'model\dao\UDAO.Usuario.pas',
  UController.Base in 'model\controllers\UController.Base.pas',
  UController.Usuario in 'model\controllers\UController.Usuario.pas',
  UController.Login in 'model\controllers\UController.Login.pas',
  UDAO.NotaFiscal in 'model\dao\UDAO.NotaFiscal.pas',
  UDAO.Servico in 'model\dao\UDAO.Servico.pas',
  UController.Cliente in 'model\controllers\UController.Cliente.pas',
  UController.Servico in 'model\controllers\UController.Servico.pas',
  UController.Prestador in 'model\controllers\UController.Prestador.pas',
  UDAO.Prestador in 'model\dao\UDAO.Prestador.pas',
  UController.NotaFiscal in 'model\controllers\UController.NotaFiscal.pas';

procedure Registry;
begin
//  THorse.Group.Prefix('v1')
//    .Post('/login', TControllerLogin.PostLogin);

  THorse.Group.Prefix('v1')
    .Get('/clientes', TControllerCliente.Gets)
    .Get('/cliente/:id', TControllerCliente.Get)
    .Post('/cliente', TControllerCliente.Post)
    .Delete('/cliente/:id', TControllerCliente.Delete);

  THorse.Group.Prefix('v1')
    .Get('/servicos', TControllerServico.Gets)
    .Get('/servico/:id', TControllerServico.Get)
    .Post('/servico', TControllerServico.Post)
    .Delete('/servico/:id', TControllerServico.Delete);

  THorse.Group.Prefix('v1')
    .Get('/notasfiscais', TControllerNotaFiscal.Gets)
    .Get('/notafiscal/:id', TControllerNotaFiscal.Get)
    .Post('/notafiscal', TControllerNotaFiscal.Post)
    .Delete('/notafiscal/:id', TControllerNotaFiscal.Delete);

  THorse.Group.Prefix('v1')
    .Get('/prestadores', TControllerPrestador.Gets)
    .Get('/prestador/:id', TControllerPrestador.Get)
    .Post('/prestador', TControllerPrestador.Post)
    .Delete('/prestador/:id', TControllerPrestador.Delete);
end;

procedure ConfigMiddleware;
begin
  THorse
    .Use(Cors)
    .Use(Jhonson);
end;

begin
  ConfigMiddleware;
  Registry;
  THorse.Listen(9000);
end.