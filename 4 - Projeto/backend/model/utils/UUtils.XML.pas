unit UUtils.XML;

interface

uses
  xml.XMLDoc, xml.XMLIntf, xml.xmldom, System.JSON, UEntity.Nota,
  UEntity.Cliente, UEntity.ItemServico, UEntity.Prestador, UEntity.Servico,
  DataSet.Serialize;

type
  TXMLUtil = class
    private
      FNota : TNota;
      FPrestador: TPrestador;
      FCliente: TCliente;
      FItemServico: TItemServico;
      FServicos  : TServico;
      XMLDocument1: TXMLDocument;
    public
      procedure MontaArquivoXML;
      procedure PreencheArquivoXML(const xNota: TNota);
      procedure CopularTNota(const aJSON: TJSONObject);
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils;

{ TXMLUtil }
var
  xNfse: IXMLNode;
  xNf: IXMLNode;
  xValorTotal: IXMLNode;
  xPrestador: IXMLNode;
  xCnpjPrest: IXMLNode;
  xCidadePrestador: IXMLNode;
  xTomador: IXMLNode;
  xEnderecoInformado: IXMLNode;
  xTipoPessoa: IXMLNode;
  xCnpjTomador: IXMLNode;
  xIE: IXMLNode;
  xRazaoSocial: IXMLNode;
  xLogradouro: IXMLNode;
  xEmail: IXMLNode;
  xNumeroResidencia: IXMLNode;
  xComplemento: IXMLNode;
  xBairro: IXMLNode;
  xCidadeTomador: IXMLNode;
  xItens: IXMLNode;
  xLista: IXMLNode;
  xTributaMunicipio: IXMLNode;
  xCidadePrestacao: IXMLNode;
  xCodServico: IXMLNode;
  xDescricaoServ: IXMLNode;
  xAliquotaISS: IXMLNode;
  xSituacaoTributaria: IXMLNode;
  xValorTributavel: IXMLNode;

procedure TXMLUtil.CopularTNota(const aJSON: TJSONObject);
var
  xMemTableNota: TFDMemTable;
  xMemTablePrestador: TFDMemTable;
  xMemTableCliente: TFDMemTable;
  xMemTableItemServico: TFDMemTable;
  xMemTableServicos: TFDMemTable;
begin
  FNota := nil;
  FPrestador := nil;
  FCliente := nil;
  FItemServico := nil;
  FServicos := nil;

  xMemTableNota := TFDMemTable.Create(nil);

  try
    xMemTableNota.LoadFromJSON(aJson);

    while not xMemTableNota.Eof do
      begin
        FCliente.Create()

        FNota.Create();


        xMemTableNota.Next;
      end;
  finally
    FreeAndNil(xMemTableNota);
  end;
end;

procedure TXMLUtil.MontaArquivoXML;
begin

  XMLDocument1.Active := true;

  xNfse := XMLDocument1.AddChild('nfse');
  xNfse.SetAttributeNS('xmlns:ds','', 'http://www.w3.org/2000/09/xmldsig');

  xNf         := xNfse.AddChild('nf');
  xValorTotal := xNf.AddChild('valor_total');

  xPrestador            := xNfse.AddChild('prestador');
  xCnpjPrest            := xPrestador.AddChild('cpfcnpj');
  xCidadePrestador      := xPrestador.AddChild('cidade');

  xTomador           := xNfse.AddChild('tomador');
  xEnderecoInformado := xTomador.AddChild('endereco_informado');
  xTipoPessoa        := xTomador.AddChild('tipo');
  xCnpjTomador       := xTomador.AddChild('cpfcnpj');
  xIE                := xTomador.AddChild('ie');
  xRazaoSocial       := xTomador.AddChild('nome_razao_social');
  xLogradouro        := xTomador.AddChild('logradouro');
  xEmail             := xTomador.AddChild('email');
  xNumeroResidencia  := xTomador.AddChild('numero_residencia');
  xComplemento       := xTomador.AddChild('complemento');
  xBairro            := xTomador.AddChild('bairro');
  xCidadeTomador     := xTomador.AddChild('cidade');

  xItens := xNfse.AddChild('itens');
  xlista := xItens.AddChild('lista');
  xTributaMunicipio   := xLista.AddChild('tributa_municipio_prestador');
  xCidadePrestacao    := xLista.AddChild('codigo_local_prestacao_servico');
  xCodServico         := xLista.AddChild('codigo_item_lista_servico');
  xDescricaoServ      := xLista.AddChild('descritivo');
  xAliquotaISS        := xLista.AddChild('aliquota_item_lista_servico');
  xSituacaoTributaria := xLista.AddChild('situacao_tributaria');
  xValorTributavel    := xLista.AddChild('valor_tributavel');
end;

procedure TXMLUtil.PreencheArquivoXML(const xNota: TNota);
var
  xMemTable :TFDMemtable;

begin
  xValorTotal.Text         := aJSON.GetValue('valorTotal').ToString;
  xCnpjPrest.Text          := aJSON.get;
  xCidadePrestador.Text    := '';


  xEnderecoInformado.Text  := '';
  xTipoPessoa.Text         := '';
  xCnpjTomador.Text        := '';
  xIE.Text                 := '';
  xRazaoSocial.Text        := '';
  xLogradouro.Text         := '';
  xEmail.Text              := '';
  xNumeroResidencia.Text   := '';
  xComplemento.Text        := '';
  xBairro.Text             := '';
  xCidadeTomador.Text      := '';
  xTributaMunicipio.Text   := '';
  xCidadePrestacao.Text    := '';
  xCodServico.Text         := '';
  xDescricaoServ.Text      := '';
  xAliquotaISS.Text        := '';
  xSituacaoTributaria.Text := '';
  xValorTributavel.Text    := '';

  XMLDocument1.SaveToFile('arquivo.xml');
end;

end.
