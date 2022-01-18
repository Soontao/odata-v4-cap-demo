# CAP Demo for `cds-mysql`

[![node-test](https://github.com/Soontao/odata-v4-cap-demo/actions/workflows/nodejs.yml/badge.svg?branch=mysql)](https://github.com/Soontao/odata-v4-cap-demo/actions/workflows/nodejs.yml)

- [CAP Demo for `cds-mysql`](#cap-demo-for-cds-mysql)
  - [Development](#development)
  - [Deployment](#deployment)
  - [Database Configuration](#database-configuration)
    - [by VCAP_SERVICES (production)](#by-vcap_services-production)
    - [by `.env` file (local development only)](#by-env-file-local-development-only)
    - [by default-env.json (local development only)](#by-default-envjson-local-development-only)

## Development

1. create a `.env` file for development, fill the database connection information
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

create mysql service by [`cf cups`](http://cli.cloudfoundry.org/en-US/cf/create-user-provided-service.html) with following format

```bash
cf cups remote-mysql-service -t 'mysql' -p '{"host":"public.mysql.instance.com","user":"cds-user","password":"CdsUser123$","database":"cds-user","port":3306,"ssl":{"ca":"-----BEGIN CERTIFICATE-----\nMIIDTTCCAjWgAwIBAgIJALVMAbLStXbWMA0GCSqGSIb3DQEBCwUAMDwxFTATBgNV\nBAMMDHNjYWxlZ3JpZC5pbzEWMBQGA1UECgwNU2NhbGVncmlkLmlvLjELMAkGA1UE\nBhMCVVMwIBcNMjIwMTE0MTAyNDU4WhgPMjA3MTA0MjcxMDI0NThaMDwxFTATBgNV\nBAMMDHNjYWxlZ3JpZC5pbzEWMBQGA1UECgwNU2NhbGVncmlkLmlvLjELMAkGA1UE\nBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsguksTD4Yyh46\n3fH2+VzrOu11dvW5B6p9qykfWF5e1mEiyKl9PfEKDRRgwCqbizSxflBz717tXAOV\nemmyNlntv6d2FMN6/fog579RLIF3Bv5HELaHXWg3tqIN9ufa0dRYfAQuSQI+zvYK\nkNcoCPARvgm/07r72jtFb6fOaeDvLxTuaOuPQETwXSG9oQV7XnRtD0Y+qV96q55w\nhr0aaCmI8gsF5zW1LzWVdtFIvA0YSm5CGm1aEnvVpB4LZILcamTRfg1kw47SaPOS\nZjs6WqSDsUHm/Pj6hscKcufRN5wLOhnVgX28RWqF1kaE5kwv437e6m5135nSroBz\ny8aTYdldAgMBAAGjUDBOMB0GA1UdDgQWBBT7wlIqQ5va28mMD4orLFlqHMnwmzAf\nBgNVHSMEGDAWgBT7wlIqQ5va28mMD4orLFlqHMnwmzAMBgNVHRMEBTADAQH/MA0G\nCSqGSIb3DQEBCwUAA4IBAQCk0N/qv/PTfEoppNHwwHbjVRxMOMLFfPDpqJzKKF0o\nhg4UOAR/NObRxMP5JzDKo8uHqw5INt91+h962Cw+HNM9u6OtfeMHERri4HFrd+9O\ncoYUv+SBl8CVw2DqNXRbbBrZ79bHs0AHeSLqh4qWVPJdYMpjBV2eP8+xqTNmyHiQ\nCdvNgxi4r8+Dioypc9L1BNkUdNZaSpLXOR39n/8m2Sj9Fdlln6RWijktIbfa0Hz2\nz5JYGiswqCZtKnHqMqNeMgMt5Djlx9AxZdkiLjPm9OAQSqJXN8fZfay9iowErTXS\nJRzUD37qZEUWtCHVP6yPSTe1DWoywFTHKB8/eHCgR4tl\n-----END CERTIFICATE-----\n"}}'
```

you can convert PEM cert to json format with [this document](https://docs.vmware.com/en/Unified-Access-Gateway/2.9/com.vmware.access-point-29-deploy-config/GUID-870AF51F-AB37-4D6C-B9F5-4BFEB18F11E9.html), just run command

```bash
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' cert-name.pem
```

### by `.env` file (local development only)

> put database configuration into `system environment variables`, for development, just use the `.env` file.

`.env` file example

```bash
CDS_MYSQL_USER=cdstest
CDS_MYSQL_PASSWORD=cdstest
CDS_MYSQL_DATABASE=cdstest
CDS_MYSQL_HOST=mysql
CDS_MYSQL_PORT=3306
CDS_MYSQL_SSL_CA="DOUBLE QUOTED PEM CERT TEXT"
```

in cloud environment, just set the `environment variable` as local is ok (like `k8s`)

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
            "ca": "-----BEGIN CERTIFICATE-----\nMIIDTTCCAjWgAwIBAgIJALVMAbLStXbWMA0GCSqGSIb3DQEBCwUAMDwxFTATBgNV\nBAMMDHNjYWxlZ3JpZC5pbzEWMBQGA1UECgwNU2NhbGVncmlkLmlvLjELMAkGA1UE\nBhMCVVMwIBcNMjIwMTE0MTAyNDU4WhgPMjA3MTA0MjcxMDI0NThaMDwxFTATBgNV\nBAMMDHNjYWxlZ3JpZC5pbzEWMBQGA1UECgwNU2NhbGVncmlkLmlvLjELMAkGA1UE\nBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsguksTD4Yyh46\n3fH2+VzrOu11dvW5B6p9qykfWF5e1mEiyKl9PfEKDRRgwCqbizSxflBz717tXAOV\nemmyNlntv6d2FMN6/fog579RLIF3Bv5HELaHXWg3tqIN9ufa0dRYfAQuSQI+zvYK\nkNcoCPARvgm/07r72jtFb6fOaeDvLxTuaOuPQETwXSG9oQV7XnRtD0Y+qV96q55w\nhr0aaCmI8gsF5zW1LzWVdtFIvA0YSm5CGm1aEnvVpB4LZILcamTRfg1kw47SaPOS\nZjs6WqSDsUHm/Pj6hscKcufRN5wLOhnVgX28RWqF1kaE5kwv437e6m5135nSroBz\ny8aTYdldAgMBAAGjUDBOMB0GA1UdDgQWBBT7wlIqQ5va28mMD4orLFlqHMnwmzAf\nBgNVHSMEGDAWgBT7wlIqQ5va28mMD4orLFlqHMnwmzAMBgNVHRMEBTADAQH/MA0G\nCSqGSIb3DQEBCwUAA4IBAQCk0N/qv/PTfEoppNHwwHbjVRxMOMLFfPDpqJzKKF0o\nhg4UOAR/NObRxMP5JzDKo8uHqw5INt91+h962Cw+HNM9u6OtfeMHERri4HFrd+9O\ncoYUv+SBl8CVw2DqNXRbbBrZ79bHs0AHeSLqh4qWVPJdYMpjBV2eP8+xqTNmyHiQ\nCdvNgxi4r8+Dioypc9L1BNkUdNZaSpLXOR39n/8m2Sj9Fdlln6RWijktIbfa0Hz2\nz5JYGiswqCZtKnHqMqNeMgMt5Djlx9AxZdkiLjPm9OAQSqJXN8fZfay9iowErTXS\nJRzUD37qZEUWtCHVP6yPSTe1DWoywFTHKB8/eHCgR4tl\n-----END CERTIFICATE-----\n"
          }
        }
      }
    ]
  }
}
```
