SELECT 
     EERP.NmEmpresaCurto
    ,USR.NmLogin
    ,(SELECT NmPessoa FROM PESSOA (NOLOCK) WHERE IDPESSOA IN ( SELECT MAX(IDPESSOA) FROM DocumentoItemRepasse (NOLOCK) WHERE IdDocumentoItem IN ( SELECT MAX(IDDOCUMENTOITEM) FROM DOCUMENTOITEM (NOLOCK) WHERE IDDOCUMENTO =  DOC.IdDocumento) ) ) AS Representante
    ,FORMAT(PDV.DtEmissao, 'dd/MM/yyyy') AS DtEmissao 
    ,PDV.CdChamada AS NrPedido
    ,DOC.NrDocumento
    ,DOC.CdEspecie
    ,PSS.NmPessoa AS Cliente
    ,DOC.StDocumentoCancelado
    ,DOC.StDocumentoImpresso
    ,CASE
        WHEN DOC.DtDevolucao IS NULL THEN 'N'
        ELSE 'S'
    END AS StDocumentoDevolvido
 
    ,CAST(SUM(DOCP.VlTitulo) AS DECIMAL(10,2)) AS VlDocumento
    ,PDV.AlDesconto
    ,CAST( (SELECT SUM(VlDescontoRateado) FROM PEDIDODEVENDAITEM (NOLOCK) WHERE IdPedidoDeVenda = PDV.IdPedidoDeVenda )  AS DECIMAL(10,2)) AS VlDesconto
 
  

FROM Documento DOC (NOLOCK)
INNER JOIN PedidoDeVenda PDV (NOLOCK) ON PDV.IdPedidoDeVenda = DOC.IdEntidadeOrigem
INNER JOIN DocumentoPagamento DOCP (NOLOCK) ON DOCP.IdDocumento = DOC.IdDocumento
INNER JOIN EmpresaERP EERP (NOLOCK) ON EERP.CdEmpresa = PDV.CdEmpresa
INNER JOIN PESSOA PSS (NOLOCK) ON PSS.IdPessoa = DOC.IdPessoa
INNER JOIN Usuario USR (NOLOCK) ON USR.IdUsuario = PDV.IdUsuario


WHERE DOC.NmEntidadeOrigem = 'PEDIDODEVENDA'
AND DOC.DtEmissao BETWEEN '2020-01-01' AND GETDATE()
 



GROUP BY   
     EERP.NmEmpresaCurto
    ,USR.NmLogin
    ,PDV.DtEmissao 
    ,PDV.CdChamada
    ,PDV.IdPedidoDeVenda 
    ,PSS.NmPessoa
    ,DOC.NrDocumento
    ,DOC.IDDOCUMENTO
    ,DOC.CdEspecie
    ,DOC.StDocumentoCancelado
    ,DOC.StDocumentoImpresso
    ,DOC.DtDevolucao
    ,PDV.AlDesconto
 