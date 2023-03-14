unit UUtils.Constants;

interface

const
  URL_BASE_CLIENTES        = 'http://localhost:9000/v1/clientes';
  URL_BASE_CLIENTE         = 'http://localhost:9000/v1/cliente';

  URL_BASE_SERVICOS        = 'http://localhost:9000/v1/servicos';
  URL_BASE_SERVICO         = 'http://localhost:9000/v1/servico';

  URL_BASE_PRESTADORES     = 'http://localhost:9000/v1/prestadores';
  URL_BASE_PRESTADORE      = 'http://localhost:9000/v1/prestador';

  URL_BASE_ITENS_SERVICOS  = 'http://localhost:9000/v1/itensServicos';
  URL_BASE_ITEM_SERVICO    = 'http://localhost:9000/v1/itemServico';

  URL_BASE_NOTAS_FISCAIS   = 'http://localhost:9000/v1/notasFiscais';
  URL_BASE_NOTA_FISCAL     = 'http://localhost:9000/v1/notaFiscal';

  URL_ENVIAR_NOTA_PREFEITURA = 'https://homologacao.atende.net/?pg=rest&service=WNERestServiceNFSe&cidade=integracoes';

  API_SUCESSO              = 200;
  API_CRIADO               = 201;
  API_SUCESSO_SEM_RETORNO  = 204;
  API_NAO_AUTORIZADO       = 401;

implementation

end.
