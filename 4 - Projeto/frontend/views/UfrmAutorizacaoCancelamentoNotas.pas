unit UfrmAutorizacaoCancelamentoNotas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, UEntity.Nota,
  UEntity.Servico, VoltarTela, Nfse;

type
  TfrmNotas = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    x: TLayout;
    Layout5: TLayout;
    rect_autorizar: TRectangle;
    Image2: TImage;
    Label6: TLabel;
    rect_copiar: TRectangle;
    Image3: TImage;
    Label7: TLabel;
    rect_cancelar: TRectangle;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Image4: TImage;
    FraVoltarTela1: TFraVoltarTela;
    CheckBox2: TCheckBox;
    Frame11: TFrame1;
    Frame12: TFrame1;
    CheckBox1: TCheckBox;
    Frame13: TFrame1;
    Frame14: TFrame1;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Frame15: TFrame1;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Frame16: TFrame1;
    procedure rect_autorizarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ListarNotas;
    procedure ExibirNota(aNota : TNota);
    procedure ExibirServicos(aServico : TServico);
  public
    { Public declarations }
  end;

var
  frmNotas: TfrmNotas;

implementation

uses
  UService.Intf, UService.NotaFiscal, UEntity.ItemServico,
  UService.ItemServico;

{$R *.fmx}

{ TfrmNotas }

procedure TfrmNotas.ExibirNota(aNota : TNota);
begin
 Label1.Text := aNota.Id.ToString + ' ' + CurrToStr(aNota.ValorTotal) + ' '+ aNota.Status;
end;

procedure TfrmNotas.ExibirServicos(aServico: TServico);
begin
  Label1.Text := aServico.Id.ToString + ' ' + aServico.DescricaoServico + ' '+ aServico.CodServico;
end;

procedure TfrmNotas.ListarNotas;
var
  xServiceItemServico: IService;
  xNota: TNota;
  xServico : TServico;
  xItemServico : TItemServico;
begin

  xServiceItemServico := TServiceItemServico.Create;
  xServiceItemServico.Listar;
//  for xItemServico in TServiceItemServico(xServiceItemServico).ItemServicos do
//  begin
//    xNota := xItemServico.Nota;
//    Self.ExibirNota(xNota);
//  end;
for xItemServico in TServiceItemServico(xServiceItemServico).ItemServicos do
  begin
    xServico := xItemServico.Servico;
    Self.ExibirServicos(xServico);
  end;
end;

procedure TfrmNotas.rect_autorizarClick(Sender: TObject);
begin
  Self.ListarNotas;
end;

end.
