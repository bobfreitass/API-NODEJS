SELECT 
     U.IdUsuario
    ,P.CdChamada
    ,PE.*
FROM USUARIO AS U (NOLOCK)
LEFT JOIN PESSOA AS P (NOLOCK) ON P.IdPessoa = U.IdPessoaCorrespondente
LEFT JOIN PessoaEndereco AS PE (NOLOCK) ON PE.IdPessoa = P.IdPessoa
WHERE U.IdUsuario = @IdUsuario OR U.NmLogin = @IdUsuario