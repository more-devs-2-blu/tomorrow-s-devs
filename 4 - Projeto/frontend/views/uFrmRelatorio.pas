unit uFrmRelatorio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMXTee.Engine,
  FMXTee.Series, FMXTee.Procs, FMXTee.Chart, FMX.Objects, FMX.ListBox,
  FMX.DateTimeCtrls;

type
  TTipoFiltros = (tfServMaisFaturado, tfServMenosFaturado, tfQtdNotasCanceladas, tfQtdNotasAutorizadas);
  TFrmRelatorio = class(TForm)
    dseRelatorioServico: TDataSource;
    qryRelatorioNota: TFDQuery;
    fdConect: TFDTransaction;
    tfdConectDataBase: TFDConnection;
    Chart1: TChart;
    btnCarregarDados: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cmbTipoFiltros: TComboBox;
    qryRelatorioServico: TFDQuery;
    DataSource1: TDataSource;
    dtDE: TDateEdit;
    dtATE: TDateEdit;
    procedure btnCarregarDadosClick(Sender: TObject);
  private
    { Private declarations }
  public
      procedure CarregaDadosRelatorioNota;
      procedure CarregaDadosRelatorioServico;
      procedure CarregaRelatorio;

    { Public declarations }
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.fmx}

procedure TFrmRelatorio.btnCarregarDadosClick(Sender: TObject);
begin
  Self.CarregaRelatorio;
end;

procedure TFrmRelatorio.CarregaDadosRelatorioNota;
begin
  qryRelatorioNota.close;
  qryRelatorioNota.SQL.Clear;
  qryRelatorioNota.SQL.Add('SELECT COUNT(1) AS TOTAL_NOTAS, DATA_EMISSAO, STATUS_NOTA FROM NOTA');
  qryRelatorioNota.SQL.Add('WHERE DATA_EMISSAO BETWEEN :DATE_DE AND :DATE_ATE ');

  if (cmbTipoFiltros.ItemIndex = 2) then
    qryRelatorioNota.SQL.Add('AND STATUS_NOTA = ''CANCELADA''')

  else if (cmbTipoFiltros.ItemIndex = 3) then
    qryRelatorioNota.SQL.Add('AND STATUS_NOTA = ''AUTORIZADA''');

  qryRelatorioNota.SQL.Add('GROUP BY DATA_EMISSAO, STATUS_NOTA');
  qryRelatorioNota.ParamByName('DATE_DE').AsDate := dtDE.Date;
  qryRelatorioNota.ParamByName('DATE_ATE').AsDate := dtATE.Date;
  qryRelatorioNota.Open;
end;

procedure TFrmRelatorio.CarregaDadosRelatorioServico;
begin
  qryRelatorioServico.close;
  qryRelatorioServico.SQL.Clear;
  qryRelatorioServico.SQL.Add('SELECT TOP 10 COUNT(1) AS QTD_SERVICOS, SERVICO.ID, SERVICO.DESCRICAO FROM NOTA');
  qryRelatorioServico.SQL.Add('INNER JOIN ITEM_SERVICO ON');
  qryRelatorioServico.SQL.Add('  ITEM_SERVICO.IDNOTA = NOTA.ID');
  qryRelatorioServico.SQL.Add('INNER JOIN SERVICO ON');
  qryRelatorioServico.SQL.Add('  ITEM_SERVICO.IDSERVICO = SERVICO.ID');
  qryRelatorioServico.SQL.Add('WHERE NOTA.DATA_EMISSAO BETWEEN :DATE_DE AND :DATE_ATE');
  qryRelatorioServico.SQL.Add('GROUP BY SERVICO.ID, SERVICO.DESCRICAO');

  if (cmbTipoFiltros.ItemIndex = 0) then
    qryRelatorioServico.SQL.Add('ORDER BY QTD_SERVICOS DESC')

  else if (cmbTipoFiltros.ItemIndex = 1) then
    qryRelatorioServico.SQL.Add('ORDER BY QTD_SERVICOS ASC');

  qryRelatorioServico.ParamByName('DATE_DE').AsDate := dtDE.Date;
  qryRelatorioServico.ParamByName('DATE_ATE').AsDate := dtATE.Date;
  qryRelatorioServico.Open;
end;

procedure TFrmRelatorio.CarregaRelatorio;
var
  xSerieGraficoPizza: TPieSeries;
begin
  Chart1.SeriesList.ClearValues;
  Chart1.SeriesList.Clear;
  Chart1.View3D := True;
//  Chart1.View3DWalls := True;
//  Chart1.Legend.Hide; // Esconde a legenda
  Chart1.Chart3DPercent := 100; // Define grossura da pizza

  Chart1.Title.Text.Text:='Data Faturamento';
  Chart1.Title.Font.Size:= 20;
  Chart1.Legend.Title.Caption := 'Qtd NF - Data';
//  Chart1.Legend.CheckBoxes := true;

//Via fonte
  xSerieGraficoPizza := TPieSeries(Chart1.AddSeries(TPieSeries));

  xSerieGraficoPizza.Marks.Font.Size := 10;
  xSerieGraficoPizza.Marks.Style := smsLabelValue; // Tipo da legenda
  xSerieGraficoPizza.Marks.MultiLine := True;
//  xGraficoPizza.Marks.

  xSerieGraficoPizza.Marks.Brush.Clear;
  xSerieGraficoPizza.Marks.Brush.Style := TBrushKind.Solid;
  xSerieGraficoPizza.Marks.Brush.Color := talphacolors.White;
  xSerieGraficoPizza.Marks.Clip := False;
  xSerieGraficoPizza.CustomXRadius:=100;
  xSerieGraficoPizza.Legend.Visible := True;
  xSerieGraficoPizza.Legend.Text := 'Teste';

  case TTipoFiltros(cmbTipoFiltros.ItemIndex) of
  tfServMaisFaturado:
    begin
      self.CarregaDadosRelatorioServico;
      Chart1.Legend.Title.Caption := 'QTD - SERVIÇO';
      while not qryRelatorioServico.Eof do
      begin
        xSerieGraficoPizza.AddPie(qryRelatorioServico.FieldByName('QTD_SERVICOS').AsInteger,
                                  copy(qryRelatorioServico.FieldByName('DESCRICAO').AsString, 1, 30));

        qryRelatorioServico.Next;
      end;
    end;

  tfServMenosFaturado:
    begin
      self.CarregaDadosRelatorioServico;
      Chart1.Legend.Title.Caption := 'QTD - SERVIÇO';
      while not qryRelatorioServico.Eof do
      begin
        xSerieGraficoPizza.AddPie(qryRelatorioServico.FieldByName('QTD_SERVICOS').AsInteger,
                                  copy(qryRelatorioServico.FieldByName('DESCRICAO').AsString, 1, 30));

        qryRelatorioServico.Next;
      end;
    end;

  tfQtdNotasCanceladas:
    begin
      self.CarregaDadosRelatorioNota;
      Chart1.Legend.Title.Caption := 'QTD NF - DATA';
      while not qryRelatorioNota.Eof do
      begin
        xSerieGraficoPizza.AddPie(qryRelatorioNota.FieldByName('TOTAL_NOTAS').AsInteger,
                                  qryRelatorioNota.FieldByName('DATA_EMISSAO').AsString);

        qryRelatorioNota.Next;
      end;
    end;

  tfQtdNotasAutorizadas:
    begin
      self.CarregaDadosRelatorioNota;
      Chart1.Legend.Title.Caption := 'QTD NF - DATA';
      while not qryRelatorioNota.Eof do
      begin
        xSerieGraficoPizza.AddPie(qryRelatorioNota.FieldByName('TOTAL_NOTAS').AsInteger,
                                  qryRelatorioNota.FieldByName('DATA_EMISSAO').AsString);

        qryRelatorioNota.Next;
      end;
    end;
  end;
end;

end.
