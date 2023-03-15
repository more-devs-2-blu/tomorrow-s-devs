unit UfrmDigitacaoNota;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Objects,
  FMX.ComboEdit, UEntity.Cliente, Generics.Collections;

type
  TfrmDigitacaoNota = class(TForm)
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
    ComboEdit1: TComboEdit;
    procedure rect_encerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rect_excluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure registrarNota;
    procedure preencherClientes;
    function ListarClientes : TList<TCliente>;
  public
    { Public declarations }
  end;

var
  frmDigitacaoNota: TfrmDigitacaoNota;

implementation

uses
  UService.Intf, UEntity.Prestador, UEntity.Nota,
  UService.Cliente, UService.Prestador, UService.NotaFiscal,
  UEntity.ItemServico, UService.ItemServico;

{$R *.fmx}


procedure TfrmDigitacaoNota.FormCreate(Sender: TObject);
begin
  Self.preencherClientes;
end;

function TfrmDigitacaoNota.ListarClientes: TList<TCliente>;
var
  xClientes : TList<TCliente>;
  xServiceItemServico: IService;
  xItemServico : TItemServico;
begin
  xClientes := TList<TCliente>.Create;

  xServiceItemServico := TServiceItemServico.Create;
  xServiceItemServico.Listar;
  for xItemServico in TServiceItemServico(xServiceItemServico).ItemServicos do
  begin
    xClientes.Add(xItemServico.Nota.Cliente);
  end;
  Result := xClientes;
end;

procedure TfrmDigitacaoNota.preencherClientes;
var
  xClientes : TList<TCliente>;
  I : Integer;
begin
  xClientes := TList<TCliente>.Create;
  xClientes := ListarClientes;

  for I := 0 to xClientes.Count-1 do
    ComboEdit1.Items.Add(xClientes[I].NomeFantasia);

    ComboEdit1.ItemIndex := 0;
end;

procedure TfrmDigitacaoNota.rect_encerrarClick(Sender: TObject);
begin
  Self.registrarNota;
end;

procedure TfrmDigitacaoNota.rect_excluirClick(Sender: TObject);
var
  xClientes : TList<TCliente>;
begin
  xClientes := TList<TCliente>.Create;
  xClientes := ListarClientes;
  Edit2.Text := xClientes[ComboEdit1.ItemIndex].NomeFantasia;
end;

procedure TfrmDigitacaoNota.RegistrarNota;
var
  xServiceNota: IService;
  xServiceCliente: IService;
  xServicePrestador: IService;
  xCliente: TCliente;
  xPrestador: TPrestador;
  xNota : TNota;
begin
  xCliente := TCliente.Create( 1,'cliente@teste.com', '806800181', 'Junior Sistemas ME',
  'Junior Sistemas', 'R. Rio de Janeiro',
  'Konder Victor', '', '1318', '8147' , 'J', 'SS');
  xServiceCliente := TServiceCliente.Create(xCliente);

  xPrestador := TPrestador.Create('2582000152', '8357');
  xServicePrestador := TServicePrestador.Create(xPrestador);

  xNota := TNota.Create( Now, 2.9,'F','2134',xCliente,xPrestador);
  xServiceNota := TServiceNotaFiscal.Create(xNota);

  xServiceCliente.Registrar;
  xServicePrestador.Registrar;
  xServiceNota.Registrar;
  ShowMessage('Olhe o Banco');
end;

end.
