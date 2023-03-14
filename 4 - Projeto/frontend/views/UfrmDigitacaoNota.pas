unit UfrmDigitacaoNota;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Objects;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    lyt_nome_fantasia: TLayout;
    Edit1: TEdit;
    Rectangle1: TRectangle;
    lyt_cnpj: TLayout;
    Label3: TLabel;
    Rectangle2: TRectangle;
    Edit2: TEdit;
    Layout3: TLayout;
    Label4: TLabel;
    Rectangle3: TRectangle;
    Edit3: TEdit;
    lyt_itens: TLayout;
    Label5: TLabel;
    Layout4: TLayout;
    Image1: TImage;
    Layout5: TLayout;
    rect_encerrar: TRectangle;
    Image2: TImage;
    Label6: TLabel;
    rect_excluir: TRectangle;
    Image3: TImage;
    Label7: TLabel;
    Image4: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
