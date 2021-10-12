# CAP Demo for `cds-mysql`

[![node-test](https://github.com/Soontao/odata-v4-cap-demo/actions/workflows/nodejs.yml/badge.svg?branch=mysql)](https://github.com/Soontao/odata-v4-cap-demo/actions/workflows/nodejs.yml)

## Setup

1. create a `.env` file for development, fill the database connection information
2. execute `npm run deploy` to deploy the database schema to database
3. execute `npm start` to start the server
4. execute `npm run test` to perform unit test

## Environment

* CDS_MYSQL_USER
* CDS_MYSQL_PASSWORD
* CDS_MYSQL_DATABASE
* CDS_MYSQL_HOST
* CDS_MYSQL_PORT


`.env` file example

```
CDS_MYSQL_USER=cdstest
CDS_MYSQL_PASSWORD=cdstest
CDS_MYSQL_DATABASE=cdstest
CDS_MYSQL_HOST=mysql
CDS_MYSQL_PORT=3306
```