unit Nfse;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TFrame1 = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    FraNFSe: TLayout;
    lblNomeFantasia: TLabel;
    lblCNPJ: TLabel;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Status: TLabel;
    Rectangle3: TRectangle;
    Image1: TImage;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
