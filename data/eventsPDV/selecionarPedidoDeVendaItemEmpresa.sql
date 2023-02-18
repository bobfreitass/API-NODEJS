SELECT 
    PDVI.IdProduto 
    ,PDVIE.QtPedida
    ,PDVIE.CdEmpresa
FROM PedidoDeVendaItemEmpresa AS PDVIE (NOLOCK)
INNER JOIN PedidoDeVendaItem AS PDVI (NOLOCK) ON PDVI.IdPedidoDeVendaItem = PDVIE.IdPedidoDeVendaItem
WHERE PDVI.IdPedidoDeVenda = @IdPDV