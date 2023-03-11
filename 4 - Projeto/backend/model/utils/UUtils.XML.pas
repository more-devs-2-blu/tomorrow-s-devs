unit UUtils.XML;

interface

uses
  xml.XMLDoc, xml.XMLIntf, xml.xmldom;

type
  TXMLUtil = class
    XMLDocument1: TXMLDocument;
    private

    public
      procedure MontaArquivoXML;
  end;

implementation

{ TXMLUtil }

procedure TXMLUtil.MontaArquivoXML;
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

  XMLDocument1.SaveToFile('arquivo.xml');

end;

end.
