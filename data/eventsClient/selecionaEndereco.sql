SELECT 

    IdPessoa
    ,CdEndereco
    ,StEnderecoPrincipal
    ,StEnderecoEntrega
    ,StEnderecoCobranca
    ,StEnderecoResidencial
    ,StEnderecoComercial
    ,StEnderecoCorrespondencia
    ,CdSUFRAMA
    ,NrInscricaoEstadual
    ,NmLogradouro
    ,NrLogradouro
    ,DsComplemento
    ,NrInscricaoMunicipal
    ,TpLogradouro
    ,CdCEP
    ,IdBairro
    ,CdCPF_CGC
    ,IdCidade
    ,IdUF
    ,NmPessoa
    ,DsObservacao
    ,StAtivo
    ,StCalculoSUFRAMA
    ,stttcalculosuframa
    ,IdPais
    ,DsDistanciaEntregaPorEmpresa
    ,TpContribuicaoICMS

FROM PessoaEndereco
WHERE IdPessoa = @IdClient
