SELECT 

     P.IdPessoa
    ,TRIM(P.CdChamada) AS CdChamada
    ,TRIM(UPPER(P.NmPessoa)) AS NmPessoa
    ,TRIM(UPPER(P.NmCurto)) AS NmCurto
    ,TRIM(P.CdCPF_CGC) AS CdCPF_CGC
    ,P.TpPessoa
    ,PEC.NrInscricaoEstadual
    ,PEC.NrInscricaoMunicipal
    ,ISNULL(C.AlDesconto,0) AS AlDesconto
    ,C.IdOperacao
    ,PFP.IdFormaPagamento
    ,TRIM(FP.DsFormaPagamento) AS DsFormaPagamento
    ,C.IdPrazo
    ,TRIM(PRZ.DsPrazo) AS DsPrazo

FROM CLIENTE AS C (NOLOCK)
INNER JOIN PESSOA AS P (NOLOCK) ON C.IdPessoaCliente = P.IdPessoa
INNER JOIN PessoaEndereco AS PEC (NOLOCK) ON PEC.IdPessoa = P.IdPessoa
LEFT  JOIN Prazo_FormaPagamento AS PFP (NOLOCK) ON PFP.IdPrazo = C.idPrazo
LEFT  JOIN FormaPagamento AS FP (NOLOCK) ON FP.IdFormaPagamento = PFP.IdFormaPagamento 
LEFT  JOIN Prazo AS PRZ (NOLOCK) ON PRZ.IdPrazo = C.IdPrazo 