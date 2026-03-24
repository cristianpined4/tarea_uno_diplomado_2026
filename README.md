# Tarea 1 - Entorno PostgreSQL con Docker

Este proyecto levanta un entorno local con **PostgreSQL 17** y **pgAdmin 4** usando Docker Compose.
Al iniciar por primera vez, se ejecutan scripts SQL para crear la base de datos y sus tablas.

## Estructura del proyecto

- `docker-compose.yml`: define los servicios de PostgreSQL y pgAdmin.
- `sql-init/main.sql`: script principal que ejecuta los scripts de inicialización.
- `sql-init/v1_20260323_create_database.sql`: crea la base de datos `midb`.
- `sql-init/v1_20260323_create_schema.sql`: crea el esquema `mantenimiento_pizarras`.
- `sql-init/v1_20260323_create_tables.sql`: crea las tablas `pizarras`, `tecnicos` y `reportes_fallos`.

## Requisitos

- Docker Desktop instalado y en ejecución.
- Docker Compose habilitado.

## Cómo usar el proyecto

1. Abre una terminal en la carpeta del proyecto.
2. Levanta los servicios:

```bash
docker compose up -d
```

3. Verifica que ambos contenedores estén activos:

```bash
docker ps
```

## Acceso a los servicios

### PostgreSQL

- Host: `localhost`
- Puerto: `5434`
- Usuario: `postgres`
- Contraseña: `admin123`
- Base de datos: `midb`

### pgAdmin

- URL: `http://localhost:5050`
- Email: `admin@admin.com`
- Contraseña: `admin123`

## Reiniciar la base de datos desde cero

Si deseas volver a ejecutar los scripts de inicialización, elimina los contenedores y el volumen:

```bash
docker compose down -v
docker compose up -d
```

> Nota: los scripts en `sql-init/` se ejecutan automáticamente solo cuando el volumen de datos es nuevo.

## Autores

- CRISTIAN ALBERTO PINEDA BLANCO - PB20002
- ANDRÉS ISAI VÁSQUEZ VÁSQUEZ - VV18009
