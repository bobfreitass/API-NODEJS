SELECT 
    P.IdProduto
    ,TRIM(CP.CdChamada) AS CdChamada
    ,P.NmProduto
    ,PC.AlRateio
FROM Produto_Composicao PC (NOLOCK)
INNER JOIN PRODUTO P (NOLOCK) ON P.IdProduto = PC.IdProdutoIntegrante
LEFT JOIN ProdutoAplicacao PA (NOLOCK) ON PA.IdProduto = P.IdProduto
INNER JOIN CodigoProduto CP (NOLOCK) ON CP.IdProduto = P.IdProduto AND CP.StCodigoPrincipal = 'S'
INNER JOIN CodigoProduto CPK (NOLOCK) ON CPK.IdProduto = PC.IdProduto AND CPK.StCodigoPrincipal = 'S'
WHERE PC.IdProduto = @IdProduto OR CPK.CdChamada = @IdProduto
ORDER BY CP.CdChamada