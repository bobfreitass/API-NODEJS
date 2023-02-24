
BEGIN 

    DECLARE @D1 VARCHAR(10)
    DECLARE @D2 VARCHAR(10)
    DECLARE @CdEmpresa VARCHAR(2)

    SET @D1 = @dt1
    SET @D2 = @dt2
    SET @CdEmpresa = @Loja

    SELECT 
    
        PDV.IdPedidoDeVenda         /* GERADO PELO SISTEMA */
        ,PDV.CdChamada              /* GERADO PELO SISTEMA */
        ,PDV.CdEmpresa              /* LOJA DE VENDA, EXEMPLO: 10 */
        ,PDV.CdEmpresaEstoque       /* LOJA DE VENDA, EXEMPLO: 10 */
        ,PDV.CdEmpresaFinanceiro    /* LOJA DE VENDA, EXEMPLO: 10 */
        ,PDV.IdSetor                /* ID SETOR PRINCIPAL DA LOJA DE VENDA */
        ,FORMAT(PDV.DtEmissao, 'dd/MM/yyyy') AS DtEmissao             /* DATA DE LANCAMENTO */
        ,FORMAT(PDV.DtEntrada, 'dd/MM/yyyy') AS DtEntrada             /* DATA DE LANCAMENTO */
        ,FORMAT(PDV.DtEntrega, 'dd/MM/yyyy') AS DtEntrega             /* DATA DE LANCAMENTO */
        ,PDV.StPedidoDeVenda        /* [A - ABERTO, C, T, L - PEDIDO , R, D] */
        ,PDV.TpPedidoDeVenda        /* [P - PEDIDO | O - ORÇAMENTO         ] */
        ,PDV.IdPessoaCliente        /* Id DO CLIENTE */
        ,PDV.IdPessoaEntrega        /* Id DO CLIENTE */
        ,PDV.CdEnderecoPrincipal    /* Id Endereço selecionado do Cliente */
        ,PDV.CdEnderecoCobranca     /* Id Endereço selecionado do Cliente */
        ,PDV.CdEnderecoEntrega      /* Id Endereço selecionado do Cliente */
        ,PDV.IdOperacao             /* ??? AB50000011 */
        ,PDV.IdOperacaoOE           /* ??? AB5000000E */
        ,PDV.IdPreco                /* RETORNAR ID TABELA PRECO */
        ,PDV.IdPrazo
        ,PDV.IdPessoaTransportador          /*  ID PESSOA LOJA DE VENDA  - TpFretePorConta = D | OU NULL - TpFretePorConta = E */
        ,PDV.IdPessoaTransportadorRedesp    /*  ID PESSOA LOJA DE VENDA  - TpFretePorConta = D | OU NULL - TpFretePorConta = E */
        ,PDV.TpFretePorConta                /* D */
        ,PDV.IdUsuario                      /* ID PESSOA USUARIO */
        ,PDV.IdUsuarioCancelamento          /* ID PESSOA USUARIO, QUANDO CANCELADO | OU NULL */
        ,PDV.StFaturamentoParcial           /* N */
        ,PDV.StMontagem                     /* N */
        ,PDV.TpDesconto                     /* V */
        ,FORMAT(PDV.DtReferenciaPagamento, 'yyyy-MM-dd')  AS DtReferenciaPagamento         /* DT CADASTRO */
        ,FORMAT(PDV.DtReabertura         , 'yyyy-MM-dd')  AS DtReabertura         /* DT CADASTRO */
        ,PDV.AlAcrescimo                    /* */
        ,PDV.AlDesconto                     /* */
        ,PDV.IdSistema                      /* 0000000026 */
        ,PDV.DsVolumes                      /* 0.00 - VOLUME CADASTRADO NO CADASTRO DE PRODUTOS */
        ,PDV.TpIndAtendimentoPresencial     /* 1 */
        ,PDV.NrDiasPrazoMedio               /* EXTRAIR DA TABELA PRAZO*/
        ,PDV.StRetiradaEstabelecimento      /* 0 ? */
        ,PDV.CdPedidoDeCompraCliente              /* PARA CASO CLIENTE TENHA UM PEDIDO DE COMPRA */



        ,CASE
            WHEN PDV.TpFretePorConta = 'D' THEN    FORMAT(CAST(sum(  (isnull(B.VlItem,0) + isnull(B.VlFreteRateado,0)  + isnull(B.VlAcrescimoRateado,0) ) - isnull(B.VlDescontoRateado,0) ) AS DECIMAL(10,2))  , 'C', 'pt-br')  
            WHEN PDV.TpFretePorConta = 'E' THEN    FORMAT(CAST(sum(  (isnull(B.VlItem,0) + isnull(B.VlAcrescimoRateado,0) ) - isnull(B.VlDescontoRateado,0)   ) AS DECIMAL(10,2))  , 'C', 'pt-br')
        END  AS  VlLiquido
        
        ,FORMAT(sum(B.VlUnitario * B.QtPedida) , 'C', 'pt-br') AS VlBruto
        ,UPPER(CLI.NmPessoa) AS NmCliente

        ,FORMAT(ISNULL(sum(B.VlFreteRateado),'0.00'), 'C', 'pt-br') AS  VlFrete
        ,FORMAT(ISNULL(sum((isnull(B.VlAcrescimoRateado,0) ) ),'0.00'), 'C', 'pt-br') AS  VlAcrecimo
        ,FORMAT(ISNULL(sum((isnull(B.VlDescontoRateado,0) )),'0.00'), 'C', 'pt-br') AS  VlDesconto

        
                    
        , ISNULL(LDOC.NrDocumento ,DOC.NrDocumento) AS NrDocumento
        , CASE
                WHEN DOC.CdEspecie IS NULL THEN 
                                        CASE
                                            WHEN PDV.StPedidoDeVenda = 'L'                                                                                                                                              THEN  CONCAT('Pedido Liberado', ' - Aguardando Gerente Eletronico')
                                            WHEN PDV.StPedidoDeVenda = 'T' AND CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200)) IS NULL  AND LDOC.CdEspecie = 'NFe'  AND LDOC.NrProtocoloNFEletronica IS NULL             THEN  CONCAT(trim(LDOC.CdEspecie), ' - Aguardando NFEasy')
                                            WHEN PDV.StPedidoDeVenda = 'T' AND CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200)) IS NULL  AND LDOC.CdEspecie = 'OE'   AND LDOC.StDocumentoImpresso = 'N'                   THEN  CONCAT(trim(LDOC.CdEspecie), ' - Aguardando Impressao De Documento')
                                            WHEN PDV.StPedidoDeVenda = 'T' AND CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200)) IS NULL  AND LDOC.CdEspecie = 'OE'   AND LDOC.StDocumentoImpresso = 'S'                   THEN  CONCAT(trim(LDOC.CdEspecie), ' - Aguardando Liberador de Estoque')
                                            WHEN PDV.StPedidoDeVenda = 'T' AND CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200)) IS NOT NULL                                                                               THEN  CONCAT(trim(LDOC.CdEspecie), ' - ',  CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200) ) )
                                            WHEN PDV.StPedidoDeVenda = 'A'  THEN 'ORCAMENTO'
                                            WHEN PDV.StPedidoDeVenda = 'T' AND IsNull(LDOC.CdEspecie,'C') = 'C' THEN 'DOC EXCLUIDO'
                                                        ELSE CONCAT(trim(LDOC.CdEspecie), ' Processando...' )                                                                                                        
                                            END

                WHEN DOC.StDocumentoCancelado = 'S' THEN CONCAT(DOC.CdEspecie, ' - CANCELADO')
                ELSE 
                                        CASE
                                            WHEN PDV.StPedidoDeVenda = 'T' AND CAST(DOC.DsErroNFEletronica AS NVARCHAR(200)) IS NOT NULL                                                                               THEN CONCAT(trim(DOC.CdEspecie), ' - ',  CAST(DOC.DsErroNFEletronica AS NVARCHAR(200) ) )
                                            WHEN PDV.StPedidoDeVenda = 'T' AND IsNull(DOC.CdEspecie,'C') = 'C'                                                                                                         THEN 'DOC EXCLUIDO'
                                            ELSE DOC.CdEspecie
                                            END
        END AS CdEspecie 
        , IsNull(DOC.StDocumentoCancelado, 'N')  AS StDocumentoCancelado
        , UPPER(U.NmLogin) AS NmLogin
        , CASE
                WHEN MAX(HC.DsLinhaDigitavel) IS NOT NULL THEN 1 
                WHEN ( MAX(AR.IdHistoricoCarteiraAtual) IS NOT NULL  AND  MAX(HC.DsLinhaDigitavel) IS NULL)  THEN 4
                ELSE 0 
                END AS ImprimeBoleto

        , CASE
                WHEN PDV.StPedidoDeVenda = 'A' AND PDV.DtEmissao > getdate()-7  THEN 'S'
                ELSE 'N'
                END AS StEdicao
        , CASE
                WHEN DOC.StDocumentoCancelado = 'S' THEN 'C'
                WHEN IsNull(DOC.StDocumentoCancelado, 'N') = 'N' AND CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200)) IS NOT NULL  THEN 'E'
                WHEN CAST(DOC.DsErroNFEletronica AS NVARCHAR(200)) IS NOT NULL  THEN 'E'
                WHEN PDV.StPedidoDeVenda = 'T' AND IsNull(LDOC.CdEspecie,IsNull(DOC.CdEspecie,'C')) = 'C' THEN 'C'

                ELSE NULL
                END AS StPedido             


        , (
            SELECT TOP 1 PESS.NmCurto
            FROM DocumentoItem  DOCI  (NOLOCK)
            LEFT JOIN DocumentoItemRepasse DOCIR (NOLOCK) ON DOCIR.IdDocumentoItem = DOCI.IdDocumentoItem
            LEFT JOIN Pessoa PESS (NOLOCK) ON PESS.IdPessoa = DOCIR.IdPessoa
            WHERE DOCI.IdDocumento = IsNull( MAX(LDOC.IdDocumento), MAX(DOC.IdDocumento))
            ) AS NmRepresentante
                
                
        

    FROM PedidoDeVenda PDV          (NOLOCK)
    INNER JOIN PedidoDeVendaItem B  (NOLOCK) ON B.IdPedidoDeVenda = PDV.IdPedidoDeVenda
    LEFT JOIN Documento DOC         (NOLOCK) ON DOC.IdDocumento = ( select max(IdDocumento) from DocumentoItem (NOLOCK) WHERE  IdDocumentoItem  IN ( select IdDocumentoItem from PedidoDeVendaItem_DocumentoItem (NOLOCK) WHERE IdPedidoDeVenda = b.IdPedidoDeVenda) )  
    LEFT JOIN LoteDoc LDOC          (NOLOCK) ON LDOC.IdDocumento =  ( select max(IdDocumento) from LoteDocItem (NOLOCK) WHERE  IdDocumentoItem  IN ( select IdDocumentoItem from PedidoDeVendaItem_DocumentoItem (NOLOCK) WHERE IdPedidoDeVenda = b.IdPedidoDeVenda) )  
    INNER JOIN Pessoa CLI           (NOLOCK) ON CLI.IdPessoa = PDV.IdPessoaCliente 
    INNER JOIN Usuario U            (NOLOCK) ON U.IdUsuario = PDV.IdUsuario

    LEFT JOIN FormaPagamento FP (NOLOCK) ON FP.IdFormaPagamento IN (SELECT IdFormaPagamento  FROM DocumentoPagamento (NOLOCK) WHERE IdDocumento = DOC.IdDocumento ) AND DsFormaPagamento like '%Boleto%' 
    LEFT JOIN AReceber AR (NOLOCK) on  AR.IdEntidadeOrigem = ( SELECT MAX(IdDocumentoPagamento) FROM DocumentoPagamento DOCP (NOLOCK) WHERE DOCP.IdDocumento = DOC.IdDocumento)  AND AR.idformapagamento = '00A0000003'
    LEFT JOIN HistoricoCarteira   HC (NOLOCK) ON HC.IdHistoricoCarteira = AR.IdHistoricoCarteiraAtual


    WHERE PDV.DtEmissao BETWEEN @D1 AND @D2
    AND   PDV.CdEmpresa = @CdEmpresa
    

    GROUP BY 
    PDV.IdPedidoDeVenda         /* GERADO PELO SISTEMA */
    ,PDV.CdChamada              /* GERADO PELO SISTEMA */
    ,PDV.CdEmpresa              /* LOJA DE VENDA, EXEMPLO: 10 */
    ,PDV.CdEmpresaEstoque       /* LOJA DE VENDA, EXEMPLO: 10 */
    ,PDV.CdEmpresaFinanceiro    /* LOJA DE VENDA, EXEMPLO: 10 */
    ,PDV.IdSetor                /* ID SETOR PRINCIPAL DA LOJA DE VENDA */
    ,PDV.DtEmissao              /* DATA DE LANCAMENTO */
    ,PDV.DtEntrada              /* DATA DE LANCAMENTO */
    ,PDV.DtEntrega              /* DATA DE LANCAMENTO */
    ,PDV.StPedidoDeVenda        /* [A - ABERTO, C, T, L - PEDIDO , R, D] */
    ,PDV.TpPedidoDeVenda        /* [P - PEDIDO | O - ORÇAMENTO         ] */
    ,PDV.IdPessoaCliente        /* Id DO CLIENTE */
    ,PDV.IdPessoaEntrega        /* Id DO CLIENTE */
    ,PDV.CdEnderecoPrincipal    /* Id Endereço selecionado do Cliente */
    ,PDV.CdEnderecoCobranca     /* Id Endereço selecionado do Cliente */
    ,PDV.CdEnderecoEntrega      /* Id Endereço selecionado do Cliente */
    ,PDV.IdOperacao             /* ??? AB50000011 */
    ,PDV.IdOperacaoOE           /* ??? AB5000000E */
    ,PDV.IdPreco                /* RETORNAR ID TABELA PRECO */
    ,PDV.IdPrazo
    ,PDV.IdPessoaTransportador          /*  ID PESSOA LOJA DE VENDA  - TpFretePorConta = D | OU NULL - TpFretePorConta = E */
    ,PDV.IdPessoaTransportadorRedesp    /*  ID PESSOA LOJA DE VENDA  - TpFretePorConta = D | OU NULL - TpFretePorConta = E */
    ,PDV.TpFretePorConta                /* D */
    ,PDV.IdUsuario                      /* ID PESSOA USUARIO */
    ,PDV.IdUsuarioCancelamento          /* ID PESSOA USUARIO, QUANDO CANCELADO | OU NULL */
    ,PDV.StFaturamentoParcial           /* N */
    ,PDV.StMontagem                     /* N */
    ,PDV.TpDesconto                     /* V */
    ,PDV.DtReferenciaPagamento          /* DT CADASTRO */
    ,PDV.DtReabertura                   /* DT CADASTRO */
    ,PDV.AlAcrescimo                    /* */
    ,PDV.AlDesconto                     /* */
    ,PDV.IdSistema                      /* 0000000026 */
    ,PDV.DsVolumes                      /* 0.00 - VOLUME CADASTRADO NO CADASTRO DE PRODUTOS */
    ,PDV.TpIndAtendimentoPresencial     /* 1 */
    ,PDV.NrDiasPrazoMedio               /* EXTRAIR DA TABELA PRAZO*/
    ,PDV.StRetiradaEstabelecimento      /* 0 ? */
    ,PDV.CdPedidoDeCompraCliente        /* PARA CASO CLIENTE TENHA UM PEDIDO DE COMPRA */    
    ,CLI.NmPessoa                       

    ,DOC.CdEspecie
    ,DOC.StDocumentoCancelado
    ,U.NmLogin
    
    ,LDOC.NrDocumento ,DOC.NrDocumento
    , DOC.CdEspecie, LDOC.CdEspecie
    ,LDOC.NrProtocoloNFEletronica 
    ,LDOC.StDocumentoImpresso 
    ,CAST(LDOC.DsErroNFEletronica AS NVARCHAR(200))
    ,CAST(DOC.DsErroNFEletronica AS NVARCHAR(200))
    
    
    ORDER BY PDV.CdChamada  DESC

    
END         