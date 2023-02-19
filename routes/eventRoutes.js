'use strict';

const express = require('express');
const eventController = require('../controllers/eventController');
const router = express.Router();

const   { 
                getHelp, 
                getListarEmpresa, 
                getSelecionaEmpresa, 
                getListarPDV, 
                getSelecionar, 
                getSelecionarItem, 
                getSelecionarPagamento, 
                getSelecionarPDVItemEmpresa, 
                getListarClientes, 
                getSelecionaCliente, 
                getSelecionaEnderecoCliente, 
                getListarUsuarios, 
                getSelecionaUsuario,
                getSelecionaEnderecoUsuario
        } = eventController;

router.get('', getHelp ); 
router.get('/apiEmpresas/listar', getListarEmpresa ); 
router.get('/apiEmpresas/selecionar/:id', getSelecionaEmpresa ); 

router.get('/apiPDV/listar/:dt1/:dt2', getListarPDV ); 

router.get('/apiPDV/selecionar/:id', getSelecionar ); 
router.get('/apiPDV/selecionarItem/:id', getSelecionarItem ); 
router.get('/apiPDV/selecionarPagamento/:id', getSelecionarPagamento ); 
router.get('/apiPDV/selecionarItemEmpresa/:id', getSelecionarPDVItemEmpresa ); 


router.get('/apiClientes/listar', getListarClientes ); 
router.get('/apiClientes/selecionar/:id', getSelecionaCliente ); 
router.get('/apiClientes/selecionarEndereco/:id', getSelecionaEnderecoCliente ); 

router.get('/apiUsuarios/listar', getListarUsuarios); 
router.get('/ApiUsuarios/selecionar/:id', getSelecionaUsuario ); 
router.get('/ApiUsuarios/selecionarEndereco/:id', getSelecionaEnderecoUsuario ); 



module.exports = { 
        routes: router 
}