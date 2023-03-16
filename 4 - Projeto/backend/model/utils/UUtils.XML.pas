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
      procedure PreencheArquivoXML(const aJSON: TJSONObject);
      procedure CopularTNota(const aJSON: TJSONObject);

      destructor destroy; override;
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
  xJSONObjectAux: TJSONObject;
  xJSONArrayAux: TJSONArray;
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
        FNota := TNota.Create(xMemTableNota.FieldByName('dataEmissao').AsDateTime,
                              xMemTableNota.FieldByName('valorTotal').AsFloat,
                              xMemTableNota.FieldByName('statusNota').ToString,
                              xMemTableNota.FieldByName('chaveIdentificador').ToString,
                              nil,
                              nil);
    xMemTableNota.Next;
      end;
  finally
    FreeAndNil(xMemTableNota);
  end;

  xMemTablePrestador := TFDMemTable.Create(nil);
  try
    xMemTablePrestador.LoadFromJSON(aJSON.GetValue('prestador').ToString);
    while not xMemTablePrestador.Eof do
      begin
        FPrestador := TPrestador.Create(xMemTablePrestador.FieldByName('cnpj').ToString,
                                    xMemTablePrestador.FieldByName('cidade').ToString);
      xMemTablePrestador.Next;
      end;
  finally
    FreeAndNil(xMemTablePrestador);
  end;

  xMemTableCliente := TFDMemTable.Create(nil);
  try     
    xMemTableCliente.LoadFromJSON(aJSON.GetValue('cliente').ToString);
    while not xMemTableCliente.Eof do
      begin

        FCliente := TCliente.Create(xMemTableCliente.FieldByName('numero').AsInteger,
                                    xMemTableCliente.FieldByName('razaoSocial').ToString,
                                    xMemTableCliente.FieldByName('email').ToString,
                                    xMemTableCliente.FieldByName('cnpj').ToString,
                                    xMemTableCliente.FieldByName('nomeFantasia').toString,
                                    xMemTableCliente.FieldByName('logradoura').toString,
                                    xMemTableCliente.FieldByName('bairro').toString,
                                    xMemTableCliente.FieldByName('complemento').toString,
                                    xMemTableCliente.FieldByName('cidade').toString,
                                    xMemTableCliente.FieldByName('endInformado').toString,
                                    xMemTableCliente.FieldByName('inscEstadual').toString,
                                    xMemTableCliente.FieldByName('tipoCliente').toString);
        xMemTableCliente.Next;
      end;
  finally
    FreeAndNil(xMemTableCliente);
  end;

  xJSONArrayAux := TJSONArray.Create(aJSON.GetValue('Servicos'));
  xJSONObjectAux := TJSONObject.ParseJSONValue
        (TEncoding.ASCII.GetBytes(xJSONArrayAux[0].ToJSON), 0) as TJSONObject;

  xMemTableItemServico := TFDMemTable.Create(nil);
  try     
    xMemTableItemServico.LoadFromJSON(xJSONObjectAux.ToString);
    while not xMemTableCliente.Eof do
      begin
        FItemServico := TItemServico.Create(xMemTableItemServico.FieldByName('quantidade').AsInteger,
                                    nil,
                                    nil);
        xMemTableItemServico.Next;
      end;
  finally
    FreeAndNil(xMemTableItemServico);
  end;

  xMemTableServicos := TFDMemTable.Create(nil);
  try     
    xMemTableServicos.LoadFromJSON(xJSONObjectAux.GetValue('servico').ToString);
    while not xMemTableCliente.Eof do
      begin

        FServicos := TServico.Create(xMemTableServicos.FieldByName('situacaoTributaria').AsInteger,
                                    xMemTableServicos.FieldByName('descricao').ToString,
                                    xMemTableServicos.FieldByName('localPrestacao').ToString,
                                    xMemTableServicos.FieldByName('codigo').ToString,
                                    xMemTableServicos.FieldByName('tributacaoMunicipal').ToString,
                                    xMemTableServicos.FieldByName('valorUnitario').AsInteger,
                                    xMemTableServicos.FieldByName('aliquota').AsFloat);
        xMemTableServicos.Next;
      end;
  finally
    FreeAndNil(xMemTableServicos);
  end;

end;

destructor TXMLUtil.destroy;
begin
  FreeAndNil(FNota);
  FreeAndNil(FCliente);
  FreeAndNil(FItemServico);
  FreeAndNil(FServicos);
  FreeAndNil(FPrestador);
  FreeAndNil(XMLDocument1);
  
  inherited;
end;

procedure TXMLUtil.MontaArquivoXML;
begin
  XMLDocument1 := TXMLDocument.Create(nil); 
  
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

procedure TXMLUtil.PreencheArquivoXML;
begin
  xValorTotal.Text         := CurrToStr(Self.FNota.ValorTotal);
  xCnpjPrest.Text          := Self.FPrestador.CNPJ;
  xCidadePrestador.Text    := Self.FPrestador.CidadePrestador;
  xEnderecoInformado.Text  := Self.FCliente.EnderecoInformado;
  xTipoPessoa.Text         := Self.FCliente.TipoCliente;
  xCnpjTomador.Text        := Self.FCliente.CNPJ;
  xIE.Text                 := Self.FCliente.InscricaoEstadual;
  xRazaoSocial.Text        := Self.FCliente.RazaoSocial;
  xLogradouro.Text         := Self.FCliente.Logradouro;
  xEmail.Text              := Self.FCliente.Email;
  xNumeroResidencia.Text   := Self.FCliente.Numero.ToString;
  xComplemento.Text        := Self.FCliente.Complemento;
  xBairro.Text             := Self.FCliente.Bairro;
  xCidadeTomador.Text      := Self.FCliente.Cidade;
  xTributaMunicipio.Text   := Self.FServicos.TributacaoMunicipioPrestado;
  xCidadePrestacao.Text    := Self.FServicos.LocalPrestacaoServico;
  xCodServico.Text         := Self.FServicos.CodServico;
  xDescricaoServ.Text      := Self.FServicos.DescricaoServico;
  xAliquotaISS.Text        := Self.FServicos.AliquotaServico.ToString;
  xSituacaoTributaria.Text := Self.FServicos.SituacaoTributaria.ToString;
  xValorTributavel.Text    := (Self.FServicos.ValorUnitario *
                               Self.FItemServico.QuantidadeServicos).ToString;

  XMLDocument1.SaveToFile('arquivo.xml');
end;

end.
