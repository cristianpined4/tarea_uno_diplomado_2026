# Tarea 1 - Entorno PostgreSQL con Docker

Este proyecto levanta un entorno local con **PostgreSQL 17** y **pgAdmin 4** usando Docker Compose.
Al iniciar por primera vez, se ejecutan scripts SQL para crear la base de datos, tablas, trigger de automatización y datos de prueba.

## Estructura del proyecto

- `docker-compose.yml`: define los servicios de PostgreSQL y pgAdmin.
- `sql-init/main.sql`: script principal que ejecuta los scripts de inicialización.
- `sql-init/v1_20260323_create_database.sql`: crea la base de datos `midb`.
- `sql-init/v1_20260323_create_schema.sql`: crea el esquema `mantenimiento_pizarras`.
- `sql-init/v2_20260323_create_tables.sql`: crea las tablas `pizarras`, `tecnicos` y `reportes_fallos` con llaves foráneas.
- `sql-init/v1_20260323_create_functions_and_triggers.sql`: crea la función y trigger para actualizar el estado de la pizarra al registrar un fallo.
- `sql-init/v2_20260323_insert_data.sql`: inserta datos iniciales de prueba.
- `sql-init/v1_20260323_querys_data.sql`: ejecuta consultas básicas de verificación (`SELECT *`) sobre las tablas.

## Orden de ejecución SQL

El archivo `main.sql` ejecuta este orden:

1. `v1_20260323_create_database.sql`
2. `v1_20260323_create_schema.sql`
3. `v2_20260323_create_tables.sql`
4. `v1_20260323_create_functions_and_triggers.sql`
5. `v2_20260323_insert_data.sql`
6. `v1_20260323_querys_data.sql`

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

## Automatización implementada

Se incluye un trigger `AFTER INSERT` sobre `reportes_fallos` que ejecuta la función `fn_actualizar_estado_pizarra()`.

- Si se inserta un reporte con `pizarra_id`, la tabla `pizarras` se actualiza automáticamente a estado `'En Reparación'`.
- El trigger es `FOR EACH ROW` para procesar cada reporte insertado individualmente.

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
- ANDRÉS ISAÍ VÁSQUEZ VÁSQUEZ - VV18009
