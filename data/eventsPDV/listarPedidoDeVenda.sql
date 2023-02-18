SELECT 

    PDV.IdPedidoDeVenda,
    TRIM(PDV.CdChamada) AS CdChamada,
    PDV.DtEmissao,
    EERP.NmEmpresaCurto,
    U.NmUsuario AS Vendedor,
    CLI.NmPessoa AS Cliente,
    PDV.STPEDIDODEVENDA,
    PDV.TPPEDIDODEVENDA,

 
    (SELECT CAST(SUM(PDVI.VlItem) AS DECIMAL(10,2)) FROM PEDIDODEVENDAITEM AS PDVI WHERE PDVI.IdPedidoDeVenda = PDV.IdPedidoDeVenda) AS VlPedidoDeVenda

FROM PedidoDeVenda AS PDV (NOLOCK)
INNER JOIN EmpresaERP AS EERP (NOLOCK) ON EERP.CdEmpresa = PDV.CdEmpresa
INNER JOIN Usuario U (NOLOCK) ON U.IdUsuario = PDV.IdUsuario
INNER JOIN PESSOA CLI (NOLOCK) ON CLI.IdPessoa = PDV.IdPessoaCliente

WHERE DtEmissao BETWEEN @dt1 AND @dt2
