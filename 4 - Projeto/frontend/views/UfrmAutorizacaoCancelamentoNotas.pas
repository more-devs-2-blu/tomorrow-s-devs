unit UfrmAutorizacaoCancelamentoNotas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

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
  private
    { Private declarations }
    procedure ListarNotas;
  public
    { Public declarations }
  end;

var
  frmNotas: TfrmNotas;

implementation

uses
  UService.Intf, UEntity.Nota, UService.NotaFiscal;

{$R *.fmx}

{ TfrmNotas }

procedure TfrmNotas.ListarNotas;
var
  xServiceNota: IService;
  xNota: TNota;
begin

  xServiceNota := TServiceNotaFiscal.Create;
  xServiceNota.Listar;
  for xNota in TServiceNotaFiscal(xServiceNota). do
    Self.PrepararlistView(xNota);

end;

end.
