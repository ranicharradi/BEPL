# BEPL (Apache ODE + BPEL processes)

This repo contains 3 BPEL processes (Store / Manufacturer / Shipper) deployed on **Apache ODE** running inside **Tomcat**, packaged via **Docker Compose**.

## Prerequisites

- Git
- Docker Desktop (includes Docker Compose)

## Clone

```bash
git clone https://github.com/ranicharradi/BEPL.git
cd BEPL
```

## Run (Docker)

```bash
docker compose up --build
```

Open:

- ODE UI: `http://localhost:8080/ode/`
- SOAP endpoints:
  - Store: `http://localhost:8080/ode/processes/StoreService`
  - Manufacturer: `http://localhost:8080/ode/processes/ManufacturerService`
  - Shipper: `http://localhost:8080/ode/processes/ShipperService`

Stop:

```bash
docker compose down
```

## Send a test SOAP request

The file `startRestock.soap.xml` contains a sample `startRestock` request for the Store service.

### curl

```bash
curl -X POST "http://localhost:8080/ode/processes/StoreService" ^
  -H "Content-Type: text/xml; charset=utf-8" ^
  -H "SOAPAction: startRestock" ^
  --data-binary "@startRestock.soap.xml"
```

### PowerShell

```powershell
Invoke-WebRequest `
  -Method Post `
  -Uri "http://localhost:8080/ode/processes/StoreService" `
  -ContentType "text/xml; charset=utf-8" `
  -Headers @{ SOAPAction = "startRestock" } `
  -InFile "startRestock.soap.xml"
```

## How deployment works

- `docker-compose.yml` mounts `./deploy` into Tomcat at `.../ode/WEB-INF/processes`.
- The `deploy/logistique` folder contains the BPEL/WSDL bundle; restarting the container reloads it.

