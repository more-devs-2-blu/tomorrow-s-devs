unit UfrmAdicionarServico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, UEntity.Nota,
  UEntity.Servico, VoltarTela, Nfse, Servico;

type
  Tfrmsrvicos = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    x: TLayout;
    Layout5: TLayout;
    rect_autorizar: TRectangle;
    Image2: TImage;
    Label6: TLabel;
    Label3: TLabel;
    Image4: TImage;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    FraServico1: TFraServico;
    FraServico2: TFraServico;
    FraServico3: TFraServico;
    FraServico4: TFraServico;
    FraVoltarTela1: TFraVoltarTela;
    FraServico5: TFraServico;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsrvicos: Tfrmsrvicos;

implementation

uses
  UService.Intf, UService.NotaFiscal, UEntity.ItemServico,
  UService.ItemServico;

{$R *.fmx}

{ TfrmNotas }

end.
