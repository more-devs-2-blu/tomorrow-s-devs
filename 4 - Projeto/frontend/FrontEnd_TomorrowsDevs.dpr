program FrontEnd_TomorrowsDevs;



uses
  System.StartUpCopy,
  FMX.Forms,
  UService.Base in 'model\services\UService.Base.pas',
  UService.Cliente in 'model\services\UService.Cliente.pas',
  UService.Intf in 'model\services\UService.Intf.pas',
  UService.ItemServico in 'model\services\UService.ItemServico.pas',
  UService.NotaFiscal in 'model\services\UService.NotaFiscal.pas',
  UService.Prestador in 'model\services\UService.Prestador.pas',
  UService.Servico in 'model\services\UService.Servico.pas',
  UUtils.Constants in 'model\utils\UUtils.Constants.pas',
  UUtils.Functions in 'model\utils\UUtils.Functions.pas',
  UController.Base in '..\backend\model\controllers\UController.Base.pas',
  UController.Cliente in '..\backend\model\controllers\UController.Cliente.pas',
  UController.ItemServico in '..\backend\model\controllers\UController.ItemServico.pas',
  UController.Login in '..\backend\model\controllers\UController.Login.pas',
  UController.NotaFiscal in '..\backend\model\controllers\UController.NotaFiscal.pas',
  UController.Prestador in '..\backend\model\controllers\UController.Prestador.pas',
  UController.Servico in '..\backend\model\controllers\UController.Servico.pas',
  UController.Usuario in '..\backend\model\controllers\UController.Usuario.pas',
  UDAO.Base in '..\backend\model\dao\UDAO.Base.pas',
  UDAO.Cliente in '..\backend\model\dao\UDAO.Cliente.pas',
  UDAO.Intf in '..\backend\model\dao\UDAO.Intf.pas',
  UDAO.ItemServico in '..\backend\model\dao\UDAO.ItemServico.pas',
  UDAO.NotaFiscal in '..\backend\model\dao\UDAO.NotaFiscal.pas',
  UDAO.Prestador in '..\backend\model\dao\UDAO.Prestador.pas',
  UDAO.Servico in '..\backend\model\dao\UDAO.Servico.pas',
  UDAO.Usuario in '..\backend\model\dao\UDAO.Usuario.pas',
  UUtil.Banco in '..\backend\model\utils\UUtil.Banco.pas',
  UUtils.JSON in '..\backend\model\utils\UUtils.JSON.pas',
  UEntity.ItemServico in '..\backend\model\entities\UEntity.ItemServico.pas',
  UEntity.Nota in '..\backend\model\entities\UEntity.Nota.pas',
  UEntity.Servico in '..\backend\model\entities\UEntity.Servico.pas',
  UEntity.Cliente in '..\backend\model\entities\UEntity.Cliente.pas',
  UEntity.Prestador in '..\backend\model\entities\UEntity.Prestador.pas',
  UfrmAdicionarServico in 'views\UfrmAdicionarServico.pas' {frmNotas},
  UfrmCriarCopiar in 'views\UfrmCriarCopiar.pas' {frmCriarCopia},
  UfrmDigitacaoNota in 'views\UfrmDigitacaoNota.pas' {frmDigitacaoNota},
  UfrmPrincipal in 'views\UfrmPrincipal.pas' {frmPrincipal},
  UUtils.XML in '..\backend\model\utils\UUtils.XML.pas',
  VoltarTela in 'frames\VoltarTela.pas' {FraVoltarTela: TFrame},
<<<<<<< Updated upstream
  Nfse in 'frames\Nfse.pas' {Frame1: TFrame},
  Servico in 'frames\Servico.pas' {FraServico: TFrame},
  UfrmAutorizacaoCancelamentoNotas in 'views\UfrmAutorizacaoCancelamentoNotas.pas' {frmservicos};
=======
  uFrmRelatorio in 'views\uFrmRelatorio.pas' {FrmRelatorio};
>>>>>>> Stashed changes

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmNotas, frmNotas);
  Application.CreateForm(TfrmDigitacaoNota, frmDigitacaoNota);
  Application.CreateForm(TfrmCriarCopia, frmCriarCopia);
<<<<<<< Updated upstream
  Application.CreateForm(Tfrmservicos, frmservicos);
=======
  Application.CreateForm(TFrmRelatorio, FrmRelatorio);
>>>>>>> Stashed changes
  Application.Run;
end.
