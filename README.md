# CAP Demo for `cds-mysql`

[![node-test](https://github.com/Soontao/odata-v4-cap-demo/actions/workflows/nodejs.yml/badge.svg?branch=mysql)](https://github.com/Soontao/odata-v4-cap-demo/actions/workflows/nodejs.yml)

- [CAP Demo for `cds-mysql`](#cap-demo-for-cds-mysql)
  - [Development](#development)
  - [Deployment](#deployment)
  - [Database Configuration](#database-configuration)
    - [by VCAP_SERVICES (production)](#by-vcap_services-production)
    - [by default-env.json (local development only)](#by-default-envjson-local-development-only)

## Development

1. create a `default-env.json` file for development, fill the database connection information
2. execute `npm run deploy` to deploy the database schema to database
3. execute `npm start` to start the server
4. execute `npm run test` to perform unit test

## Deployment

1. convert mysql to cloud foundry user-provided service
2. change the resource name in `mta.yaml`
3. `mbt build`
4. `cf deploy mta_archives/cap-demo_1.0.0.mtar`

## Database Configuration

### by VCAP_SERVICES (production)

> if you want to run cds-mysql on cloud foundry

create mysql service by [`cf cups`](http://cli.cloudfoundry.org/en-US/cf/create-user-provided-service.html) with following format

```bash
cf cups remote-mysql-service -t 'mysql' -p '{"host":"public.mysql.instance.com","user":"cds-user","password":"CdsUser123$","database":"cds-user","port":3306,"ssl":{"ca":"-----BEGIN CERTIFICATE-----\n ......\n-----END CERTIFICATE-----\n"}}'
```

you can convert PEM cert to json format with [this document](https://docs.vmware.com/en/Unified-Access-Gateway/2.9/com.vmware.access-point-29-deploy-config/GUID-870AF51F-AB37-4D6C-B9F5-4BFEB18F11E9.html), just run command

```bash
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' cert-name.pem
```

### by default-env.json (local development only)

put a `default-env.json` file into the project root

```json
{
  "VCAP_SERVICES": {
    "user-provided": [
      {
        "label": "user-provided",
        "name": "remote-mysql-service",
        "tags": [
          "mysql"
        ],
        "credentials": {
          "host": "public.mysql.instance.com",
          "user": "cds-user",
          "password": "CdsUser123$",
          "database": "cds-user",
          "port": 3306,
          "ssl": {
            "ca": "-----BEGIN CERTIFICATE-----\n ... ... \n-----END CERTIFICATE-----\n"
          }
        }
      }
    ]
  }
}
```
