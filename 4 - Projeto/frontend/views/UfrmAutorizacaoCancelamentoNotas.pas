unit UfrmAutorizacaoCancelamentoNotas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, UEntity.Nota,
  UEntity.Servico;

type
  TfrmNotas = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Layout2: TLayout;
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
