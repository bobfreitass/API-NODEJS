'use strict';

const utils = require('./utils');
const config = require('../config');
const sql = require('mssql');
const info = require('../info');


const getHelp = async () => {

            return info.htmlInfo();

}
 

const getListarEmpresa = async () => {
    try {
            let pool = await sql.connect(config.sql);
            const sqlQueries = await utils.loadSqlQueries('eventsEmpresa');
            const listEmpresas = await pool.request().query(sqlQueries.listarEmpresa);
            return listEmpresas.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionaEmpresa = async (IdEmpresa) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsEmpresa');
        const oneEvent = await pool.request()
                                .input('IdEmpresa',sql.Char, IdEmpresa)
                                .query(sqlQueries.selecionarEmpresa);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
    }
}


const getListarPDV = async (dt1,dt2) => {
    try {
            let pool = await sql.connect(config.sql);
            const sqlQueries = await utils.loadSqlQueries('eventsPDV');
            const listPedidoDeVendas = await pool.request()
                                                .input('dt1',sql.Char, dt1)
                                                .input('dt2',sql.Char, dt2)
                                                .query(sqlQueries.listarPedidoDeVenda);
            return listPedidoDeVendas.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionar = async (IdPDV) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsPDV');
        const oneEvent = await pool.request()
                                .input('IdPDV',sql.Char, IdPDV)
                                .query(sqlQueries.selecionarPedidoDeVenda);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionarItem = async (IdPDV) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsPDV');
        const oneEvent = await pool.request()
                                .input('IdPDV',sql.Char, IdPDV)
                                .query(sqlQueries.selecionarPedidoDeVendaItem);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionarPagamento = async (IdPDV) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsPDV');
        const oneEvent = await pool.request()
                                .input('IdPDV',sql.Char, IdPDV)
                                .query(sqlQueries.selecionarPedidoDeVendaPagamento);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionarPDVItemEmpresa = async (IdPDV) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsPDV');
        const oneEvent = await pool.request()
                                .input('IdPDV',sql.Char, IdPDV)
                                .query(sqlQueries.selecionarPedidoDeVendaItemEmpresa);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
    }
}





const getListarClientes = async () => {
    try {
            let pool = await sql.connect(config.sql);
            const sqlQueries = await utils.loadSqlQueries('eventsClient');
            const listPedidoDeVendas = await pool.request().query(sqlQueries.listarClientes);
            return listPedidoDeVendas.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionaCliente = async (IdClient) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsClient');
        const oneEvent = await pool.request()
                                .input('IdClient',sql.Char, IdClient)
                                .query(sqlQueries.selecionaCliente);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
    }
}

const getSelecionaEnderecoCliente = async (IdClient) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('eventsClient');
        const oneEvent = await pool.request()
                                .input('IdClient',sql.Char, IdClient)
                                .query(sqlQueries.selecionaEndereco);

        return oneEvent.recordset;

    } catch (error) {
        return error.message;
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
    getSelecionaEnderecoCliente
}