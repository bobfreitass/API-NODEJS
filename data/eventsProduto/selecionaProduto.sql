SELECT 
    trim(CP.CdChamada) AS CdChamada,
    P.*
FROM PRODUTO P (NOLOCK)
INNER JOIN CodigoProduto CP (NOLOCK) ON CP.IdProduto = P.IdProduto AND CP.StCodigoPrincipal = 'S'
WHERE P.IdProduto = @IdProduto OR CP.CdChamada = @IdProduto 