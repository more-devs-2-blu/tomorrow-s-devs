unit Servico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TFraServico = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    Label3: TLabel;
    Status: TLabel;
    FraNFSe: TLayout;
    lblNomeFantasia: TLabel;
    lblCNPJ: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
