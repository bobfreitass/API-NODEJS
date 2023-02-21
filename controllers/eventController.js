'use strict';

const eventData = require('../data');



const getHelp = async (req, res, next) => {

    try {
            const events = await eventData.getHelp();
            res.send(events);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getListarEmpresa = async (req, res, next) => {

    try {
                const events = await eventData.getListarEmpresa();
                res.send(events);
        } catch (error) {
            res.status(400).send(error.message);
            
        }

}

const getSelecionaEmpresa = async (req, res, next) => {

    try {
        const IdEmpresa = req.params.id;
        const oneEvent = await eventData.getSelecionaEmpresa(IdEmpresa);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getListarPDV = async (req, res, next) => {

    try {
            const dt1 = req.params.dt1;
            const dt2 = req.params.dt2;

            const events = await eventData.getListarPDV(dt1,dt2);
            res.send(events);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}
const getSelecionar = async (req, res, next) => {

    try {
        const IdPedidoDeVenda = req.params.id;
        const oneEvent = await eventData.getSelecionar(IdPedidoDeVenda);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getSelecionarItem = async (req, res, next) => {

    try {
        const IdPedidoDeVenda = req.params.id;
        const oneEvent = await eventData.getSelecionarItem(IdPedidoDeVenda);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getSelecionarPDVItemEmpresa = async (req, res, next) => {

    try {
        const IdPDV = req.params.id;
        const oneEvent = await eventData.getSelecionarPDVItemEmpresa(IdPDV);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}


const getSelecionarPagamento = async (req, res, next) => {

    try {
        const IdPedidoDeVenda = req.params.id;
        const oneEvent = await eventData.getSelecionarPagamento(IdPedidoDeVenda);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}


const getListarClientes = async (req, res, next) => {

    try {
            const events = await eventData.getListarClientes();
            res.send(events);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}
const getSelecionaCliente = async (req, res, next) => {

    try {
        const IdClient = req.params.id;
        const oneEvent = await eventData.getSelecionaCliente(IdClient);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getSelecionaEnderecoCliente = async (req, res, next) => {

    try {
        const IdClient = req.params.id;
        const oneEvent = await eventData.getSelecionaEnderecoCliente(IdClient);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getListarUsuarios = async (req, res, next) => {

    try {
            const events = await eventData.getListarUsuarios();
            res.send(events);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}


const getSelecionaUsuario = async (req, res, next) => {

    try {
        const IdUser = req.params.id;
        const oneEvent = await eventData.getSelecionaUsuario(IdUser);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getSelecionaEnderecoUsuario = async (req, res, next) => {

    try {
        const IdUser = req.params.id;
        const oneEvent = await eventData.getSelecionaEnderecoUsuario(IdUser);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getListarProdutos = async (req, res, next) => {

    try {
            const events = await eventData.getListarProdutos();
            res.send(events);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getSelecionaProduto = async (req, res, next) => {

    try {
        const IdProduto = req.params.id;
        const oneEvent = await eventData.getSelecionaProduto(IdProduto);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getListarProdutosKit = async (req, res, next) => {

    try {
        const IdProduto = req.params.id;
        const oneEvent = await eventData.getListarProdutosKit(IdProduto);
        res.send(oneEvent);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}

const getSelecionaProdutoSaldo = async (req, res, next) => {

    try {
            const IdProduto = req.params.id1;
            const IdPreco   = req.params.id2;

            const events = await eventData.getSelecionaProdutoSaldo(IdProduto, IdPreco);
           // const events = await eventData.getListarProdutosKit(IdProduto);

            res.send(events);
    } catch (error) {
        res.status(400).send(error.message);
        
    }

}


module.exports = {
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
    getSelecionaEnderecoUsuario,

    getListarProdutos,
    getSelecionaProduto,
    getListarProdutosKit,
    getSelecionaProdutoSaldo

};