'use strict';
const express = require('express');
const config = require('./config');
const cors = require('cors');
const bodyParser = require('body-parser');
const eventRoutes = require('./routes/eventRoutes');

const app = express();

app.use(cors());
app.use(bodyParser.json());


app.use('/', eventRoutes.routes);
app.listen( parseInt(config.port) , () => console.log('Server is listening on http://localhost:' + config.port));
