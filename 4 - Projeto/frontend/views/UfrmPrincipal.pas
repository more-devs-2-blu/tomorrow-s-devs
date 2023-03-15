unit UfrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
    Layout1: TLayout;
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
    Image4: TImage;
    procedure Rectangle1Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  UfrmCriarCopiar, UfrmAutorizacaoCancelamentoNotas;

{$R *.fmx}

procedure TfrmPrincipal.Rectangle1Click(Sender: TObject);
begin
 // Self.TelaCriarCopia;
end;


procedure TfrmPrincipal.Rectangle3Click(Sender: TObject);
begin
  if not(Assigned(frmNotas)) then
    frmNotas := TfrmNotas.Create(Application);

  frmNotas.Show;
  Application.MainForm := frmNotas;
  Self.Close;
end;

end.
