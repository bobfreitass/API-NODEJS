SELECT 
                
    P.IdProduto
    ,TRIM(CP.CdChamada) AS CdChamada
    ,UPPER(TRIM(P.NmProduto)) AS NmProduto
    ,UPPER(TRIM(B.NmFamiliaProduto)) AS NmFamilia
    ,TRIM(P.CdClassificacao) AS CdClassificacao
    ,P.IdImagem
    ,PA.DsAplicacao

FROM produto P (NOLOCK)
INNER JOIN CodigoProduto CP (NOLOCK) ON CP.IdProduto = P.IdProduto AND CP.StCodigoPrincipal = 'S'
LEFT JOIN Imagem A (NOLOCK) ON A.IdImagem = P.IdImagem 
INNER JOIN FamiliaProduto B (NOLOCK) ON B.IdFamiliaProduto = P.IdFamiliaProduto
LEFT JOIN ProdutoAplicacao PA (NOLOCK) ON PA.IdProduto = P.IdProduto
WHERE P.StAtivo = 'S'
AND P.TpProduto = 'C'
AND CP.CdChamada is not null

ORDER BY  CP.CdChamada, NmProduto