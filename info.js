'use strict';


const htmlInfo = async () => {
  

    let html = `
    
                    <!doctype html>
                    <html lang="en">
                    <head>
                        <meta charset="utf-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <title>Bootstrap demo</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
                    </head>
                    <body>
                        <h1> <center> Bem vindo a Central de APIs Alterdata/Bimer by Robert Freitas </center>  </h1>
                        
                        <ul>
                            <li> <span  class='h4' > ApiEmpresas </span>
                                <ul> /ApiEmpresas/listar </ul>
                                <ul> /ApiEmpresas/selecionar/$IdEmpresa </ul>
                            </li>
                            <li>  <span  class='h4' > ApiUsuarios </span> 
                                <ul> /ApiUsuarios/listar </ul>
                                <ul> /ApiUsuarios/selecionar/$IdUsuario </ul>
                                <ul> /ApiUsuarios/selecionarEndereco/$IdUsuario </ul>
                            </li>
                            <li><span  class='h4' > ApiCliente </span></li>
                                <ul> /ApiClientes/listar </ul>
                                <ul> /ApiClientes/selecionar/$IdCliente </ul>
                                <ul> /ApiClientes/selecionarEndereco/$IdCliente </ul>
                            <li><span  class='h4' > ApiProdutos </span>
                                <ul> /ApiProdutos/listar/$IdProduto </ul>
                                <ul> /ApiProdutos/listarProdutosKit/$IdProduto </ul>
                                <ul> /ApiProdutos/selecionar/$IdProduto </ul>
                                <ul> /ApiProdutos/listarSaldos/$IdProduto/$IdPreco </ul>
                            </li>
                            <li><span  class='h4' > ApiPDV </span>
                                <ul> /ApiPDV/listar/$DtInicial/$DtFinal </ul>
                                <ul> /ApiPDV/selecionar/$IdPDV </ul>
                                <ul> /ApiPDV/selecionarItem/$IdPDV </ul>
                                <ul> /ApiPDV/selecionarItemEmpresa/$IdPDV </ul>
                                <ul> /ApiPDV/selecionarPagamento/$IdPDV </ul>
                            </li>
                            <li>ApiDocumentos</li>
                            <li>ApiCotacao</li>
                            <li>ApiPDC</li>
                            <li>ApiCD</li>
                        </ul>
                    
                        

                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
                    </body>
                    </html>

                `;


    return html;


    html += '<h1></h1>';
    html += '<h3> <center> ApiEmpresas </center> </h3>';
    html += '<h3> <center> ApiUsuarios</center> </h3>';
    html += '<h3> <center> ApiCliente </center> </h3>';
    html += '<h3> <center> ApiProdutos </center> </h3>';
    html += '<h3> <center> ApiPDV </center> </h3>';
    html += '<h3> <center> ApiDocumentos </center> </h3>';
    html += '<h3> <center> ApiCotacao </center> </h3>';
    html += '<h3> <center> ApiPDC </center> </h3>';
    html += '<h3> <center> ApiCD </center> </h3>';

}

module.exports = {
 htmlInfo
}
 