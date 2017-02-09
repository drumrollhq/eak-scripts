'use strict';

const program = require('commander');
const axios = require('axios');
const BASE_URL = process.env.BASE_URL || 'http://localhost:3000';

program
  .version('0.0.1')
  .usage('--offset <n> --number <n>')
  .option('-o, --offset <n>', 'ID to start from', parseInt)
  .option('-n, --number <n>', 'No of accounts to create', parseInt)
  .option('-p, --prefix <s>', 'Username prefix')
  .parse(process.argv);

if(undefined === program.offset || undefined === program.number) {
    program.help();
}

for(var i = program.offset; i < program.offset + program.number; i++) 
{
    createAccount(i)
        .then((id, cookie) => updateAccount(id, cookie))
        .then(response => console.log('Created: ', response))
        .catch(error => console.log(error));
}

function createAccount(id) 
{
    const prefix = program.prefix || 'user';
    const userData = {
        assumeAdult: false,
        password: `Password123!`,
        email: `${prefix}${id}@drumrollhq.com`
    };
    
    return new Promise((resolve, reject) => {
        axios
            .post(`${BASE_URL}/v1/auth/register`, userData) 
            .then(response => resolve({id: response.data.id, cookie: response.headers['set-cookie']}))
            .catch(error => reject(error.response.data));
    });
}

function updateAccount(params) 
{
    const updateData = {
        status: 'active',
	    purchased: true
    };
    
    return new Promise((resolve, reject) => {
        axios
            .post(`${BASE_URL}/v1/users/${params.id}/update`, updateData, {headers: {'cookie': params.cookie.join(';')}})
            .then(response => resolve(response.data))
            .catch(error => reject(error.response.data));
    });
}