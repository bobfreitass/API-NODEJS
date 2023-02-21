 

BEGIN

    DECLARE @VlPrecoProduto DECIMAL(10,2)
    DECLARE @DATAX VARCHAR(10)

    DECLARE @AlDescontoCm FLOAT


    
    SET @DATAX = FORMAT(GETDATE(),'yyyy-MM-dd')
    




    SELECT TOP 1
        @AlDescontoCm = RC.AlDesconto
    FROM
        RegraComercializacao RC (NOLOCK)
        INNER JOIN RegraComercializacaoEmpresa RCE (NOLOCK) ON (RCE.IdRegraComercializacao = RC.IdRegraComercializacao)
        INNER JOIN RegraComercializacaoTipoComercializacao RCTC (NOLOCK) ON (RCTC.IdRegraComercializacao = RC.IdRegraComercializacao)
    WHERE
        (RCE.CdEmpresa = '10')
        AND ( @DATAX BETWEEN RC.DtVigenciaInicial AND RC.DtVigenciaFinal)
        AND (RCTC.IdTipoComercializacao = 1)

    SET @VlPrecoProduto = (@VlPrecoProduto - (@VlPrecoProduto * (isnull(@AlDescontoCm,0) / 100) ) )


    if object_id('tempdb..#SALDO_PRODUTOS_X_EMPRESA') is not null
        drop table #SALDO_PRODUTOS_X_EMPRESA


    CREATE TABLE #SALDO_PRODUTOS_X_EMPRESA(
        IdProduto CHAR(10)
        ,CdChamada CHAR(6)
        ,NmProduto VARCHAR(500)
        ,CdEmpresa INT
        ,NmEmpresaCurto VARCHAR(250)
        ,NmSetor VARCHAR(500)
        ,QtEstoque INT
        ,DsLocalizacao VARCHAR(250)
        ,VlProduto FLOAT

    )

    INSERT INTO #SALDO_PRODUTOS_X_EMPRESA
    SELECT
        P.IdProduto
        ,CP.CdChamada
        ,P.NmProduto
        ,EERP.CdEmpresa
        ,EERP.NmEmpresaCurto
        ,ISNULL(SS.NmSetor,0) AS NmSetor
        ,CASE
            WHEN  MIN(PC.IdProdutoIntegrante) IS NOT NULL 
            THEN  ( ISNULL(MIN(SPC.QtEstoque),0) - ( ISNULL(MAX(PCS.QtPedidoVenda),0) + ISNULL(MAX(PCS.QtProcessamento),0) + ISNULL(MAX(PCS.QtRequisitada),0) )) 
            ELSE  ( ISNULL(S.QtEstoque,0)        - ( ISNULL(PS.QtPedidoVenda,0) + ISNULL(PS.QtProcessamento,0) + ISNULL(PS.QtRequisitada,0) ))
            END AS QtEstoque

        ,ISNULL(PE.DsLocalizacao,IsNull(PS.DsLocalizacao,'')) AS DsLocalizacao
        ,max(0.00) AS VlProduto





    FROM Produto P (NOLOCK)
    LEFT JOIN CodigoProduto CP (NOLOCK) ON CP.IdProduto = P.IdProduto AND CP.StCodigoPrincipal = 'S'
    LEFT JOIN EmpresaERP EERP (NOLOCK) ON EERP.CdEmpresa IS NOT NULL  AND EERP.stAtivo = 'S'
    LEFT JOIN EstoqueSetor S (NOLOCK) ON S.IdProduto = P.IdProduto 
                                        AND S.IdSetor IN ( SELECT IdSetor FROM Setor WHERE StSetorDistribuicao = 'S' AND CdEmpresa = EERP.CdEmpresa )
                                        AND S.DtReferencia = ( SELECT MAX(DtReferencia) FROM EstoqueSetor WHERE IdSetor = S.IdSetor AND IdProduto = S.IdProduto)
    LEFT JOIN Setor SS (NOLOCK) ON SS.IdSetor = S.IdSetor
    LEFT JOIN Produto_Setor PS (NOLOCK) ON PS.IdProduto = P.IdProduto AND PS.IdSetor = SS.IdSetor 
    LEFT JOIN Produto_Empresa PE (NOLOCK) ON PE.IdProduto = P.IdProduto AND PE.CdEmpresa = SS.CdEmpresa 
    



    LEFT JOIN Produto_Composicao PC (NOLOCK) ON PC.IdProduto = P.IdProduto
    LEFT JOIN EstoqueSetor SPC (NOLOCK) ON SPC.IdProduto = PC.IdProdutoIntegrante 
                                        AND SPC.IdSetor IN ( SELECT IdSetor FROM Setor WHERE StSetorDistribuicao = 'S' AND CdEmpresa = EERP.CdEmpresa )
                                        AND SPC.DtReferencia = ( SELECT MAX(DtReferencia) FROM EstoqueSetor WHERE IdSetor = SPC.IdSetor AND IdProduto = SPC.IdProduto)
    LEFT JOIN Produto_Setor PCS (NOLOCK) ON PCS.IdSetor = SPC.IdSetor 
                                            AND  PCS.IdProduto  = (


                                                                    SELECT TOP 1 IdProdutoIntegrante 
                                                                    FROM Produto_Composicao A
                                                                    WHERE A.IdProduto = P.IdProduto 
                                                                    AND A.IdProdutoIntegrante  = (
                                                                                                    SELECT TOP 1 IdProduto
                                                                                                    FROM EstoqueSetor
                                                                                                    WHERE IdProduto = A.IdProdutoIntegrante
                                                                                                    ORDER BY QtEstoque DESC
                                                                    )   
                                            )
    
    


    WHERE P.StAtivo = 'S'
    AND P.StServico = 'N'
    AND P.IdProduto = @IdProduto

    GROUP BY 
        P.IdProduto
        ,CP.CdChamada
        ,P.NmProduto
        ,EERP.CdEmpresa
        ,EERP.NmEmpresaCurto
        ,SS.NmSetor
        ,S.QtEstoque
        ,PS.QtPedidoVenda 
        ,PS.QtProcessamento
        ,PS.QtRequisitada
        ,PS.DsLocalizacao
        ,PE.DsLocalizacao
    

    


    ORDER BY p.IdProduto,  EERP.CdEmpresa DESC








    Set NoCount On
    Declare @CdEmpresa Identificador
    Declare @VlProduto FLOAT
    Declare Cursor_SALDO_PRODUTOS_X_EMPRESA Cursor Fast_Forward Read_Only For

    SELECT CdEmpresa  FROM #SALDO_PRODUTOS_X_EMPRESA

    Open Cursor_SALDO_PRODUTOS_X_EMPRESA

    Fetch Next From Cursor_SALDO_PRODUTOS_X_EMPRESA
    Into
        @CdEmpresa 

    While @@Fetch_Status = 0
    Begin

        EXEC sp_CalculaPreco  @DATAX  , @IdProduto  , @IdPreco  , @CdEmpresa  ,@VlProduto OUTPUT


        UPDATE  #SALDO_PRODUTOS_X_EMPRESA SET VlProduto = isnull(@VlProduto,0) where CdEmpresa = @CdEmpresa 

        Fetch Next From Cursor_SALDO_PRODUTOS_X_EMPRESA
        Into  @CdEmpresa 

    End




    Close Cursor_SALDO_PRODUTOS_X_EMPRESA
    Deallocate Cursor_SALDO_PRODUTOS_X_EMPRESA
    Set NoCount Off

        
    
    SELECT * FROM #SALDO_PRODUTOS_X_EMPRESA

    DROP TABLE #SALDO_PRODUTOS_X_EMPRESA


END

 