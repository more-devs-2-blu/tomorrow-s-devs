unit VoltarTela;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, UfrmPrincipal;

type
  TFraVoltarTela = class(TFrame)
    Rectangle1: TRectangle;
    procedure VoltarTelaPrincipal;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFraVoltarTela.VoltarTelaPrincipal;
var
 oldForm : TCommonCustomForm;
begin
  oldForm := Application.MainForm;

  if not(Assigned(frmPrincipal)) then
    frmPrincipal := TfrmPrincipal.Create(Application);

  frmPrincipal.Show;
  Application.MainForm := frmPrincipal;
  oldForm.close;
end;

end.
