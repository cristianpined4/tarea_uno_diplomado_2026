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
- `sql-init/v1_20260323_indexes.sql`: define índices secundarios en `fecha` y `tecnico_id` de la tabla `reportes_fallos` para optimizar el rendimiento de lectura.
- `sql-init/v3_20260323_insert_data.sql`: inserta datos iniciales de prueba.
- `sql-init/v1_20260323_querys_data.sql`: ejecuta consultas básicas de verificación (`SELECT *`) sobre las tablas.

## Orden de ejecución SQL

El archivo `main.sql` ejecuta este orden:

1. `v1_20260323_create_database.sql`
2. `v1_20260323_create_schema.sql`
3. `v2_20260323_create_tables.sql`
4. `v1_20260323_create_functions_and_triggers.sql`
5. `v1_20260323_indexes.sql`
6. `v3_20260323_insert_data.sql`
7. `v1_20260323_querys_data.sql`

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

## Optimización mediante Índices (Diseño Físico)

Se han creado dos índices secundarios en la tabla `reportes_fallos` para mejorar el rendimiento de consultas:

### Índices creados:

1. **idx_reportes_fallos_fecha**: Índice B-tree en la columna `fecha`.
   - Optimiza búsquedas por rango temporal (`WHERE fecha BETWEEN ... AND ...`).
   - Mejora consultas con `ORDER BY fecha`.
   - Reduce I/O de disco favoreciendo acceso en O(log n) vs. table scan en O(n).

2. **idx_reportes_fallos_tecnico_id**: Índice B-tree en la columna `tecnico_id`.
   - Optimiza JOINs con tablas `tecnicos`.
   - Acelera búsquedas de reportes por técnico asignado.
   - Mejora agregaciones y análisis de carga de trabajo.

### Balance: Rendimiento de Lectura vs. Costo de Escritura

(Referencia: de Marqués, Capítulo 1.5 y 8.1.2)

**Ventajas:**

- Consultas SELECT más rápidas gracias a búsquedas en O(log n).
- Reducción de CPU y I/O innecesarios.
- Mejor experiencia en reportes y dashboards.

**Costos:**

- Todo INSERT/UPDATE en `reportes_fallos` requiere actualizar los índices (overhead O(log n)).
- Almacenamiento adicional en disco (~20-30% según cardinalidad).
- Mantenimiento de coherencia entre tabla e índices.

**Decisión:** Para este escenario es aceptable el balance porque `reportes_fallos` es tabla de lectura frecuente y escritura ocasional (no es OLTP masivo). Si la carga de escritura superara 1000 operaciones/segundo, se debería evaluar particionamiento temporal o tabla staging.

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
