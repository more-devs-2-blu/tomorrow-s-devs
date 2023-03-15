unit UfrmCriarCopiar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, VoltarTela;

type
  TfrmCriarCopia = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Layout2: TLayout;
    lyt_digitar_nfse: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    Label2: TLabel;
    lyt_ver_relatorio_nfse: TLayout;
    Rectangle2: TRectangle;
    Image2: TImage;
    Label3: TLabel;
    lyt_visualizar_nfse: TLayout;
    Rectangle3: TRectangle;
    Image3: TImage;
    Label4: TLabel;
    Rectangle4: TRectangle;
    Layout3: TLayout;
    Rectangle6: TRectangle;
    Label6: TLabel;
    Layout5: TLayout;
    rect_autorizar: TRectangle;
    Image4: TImage;
    Label5: TLabel;
    rect_cancelar: TRectangle;
    Image6: TImage;
    Label8: TLabel;
    Image5: TImage;
    FraVoltarTela1: TFraVoltarTela;
    procedure rect_autorizarClick(Sender: TObject);
    procedure rect_cancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure TelaDigitacao;
    procedure TelaNotas;
  public
    { Public declarations }
  end;

var
  frmCriarCopia: TfrmCriarCopia;

implementation

uses
  UfrmDigitacaoNota, UfrmAutorizacaoCancelamentoNotas;

{$R *.fmx}

procedure TfrmCriarCopia.rect_autorizarClick(Sender: TObject);
begin
  Self.TelaDigitacao;
end;

procedure TfrmCriarCopia.rect_cancelarClick(Sender: TObject);
begin
  Self.TelaNotas;
end;

procedure TfrmCriarCopia.TelaDigitacao;
begin
  if not(Assigned(frmDigitacaoNota)) then
    frmDigitacaoNota := TfrmDigitacaoNota.Create(Application);

  frmDigitacaoNota.Show;
  Application.MainForm := frmDigitacaoNota;
  Self.Close;
end;

procedure TfrmCriarCopia.TelaNotas;
begin
  if not(Assigned(frmNotas)) then
    frmNotas := TfrmNotas.Create(Application);

  frmNotas.Show;
  Application.MainForm := frmNotas;
  Self.Close;
end;

end.
