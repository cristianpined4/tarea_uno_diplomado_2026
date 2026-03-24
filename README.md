# Tarea 1 - PostgreSQL + pgAdmin con Docker

Proyecto para levantar rápido una base PostgreSQL con datos de ejemplo y scripts de apoyo (triggers, índices, mantenimiento y metadatos).

## Qué trae

- PostgreSQL 17
- pgAdmin 4
- creación de BD, esquema y tablas
- trigger para actualizar estado de pizarras al reportar fallo
- índices para mejorar consultas
- comentarios de catálogo (`COMMENT ON`)
- script de mantenimiento (`VACUUM ANALYZE`)

## Requisitos

- Docker Desktop
- Docker Compose

## Levantar el entorno

```bash
docker compose up -d
docker ps
```

## Acceso

### PostgreSQL

- Host: `localhost`
- Puerto: `5434`
- Usuario: `postgres`
- Password: `admin123`
- DB: `midb`

### pgAdmin

- URL: `http://localhost:5050`
- Email: `admin@admin.com`
- Password: `admin123`

## Orden real de ejecución (main.sql)

1. `v1_20260323_create_database.sql`
2. `v1_20260323_create_schema.sql`
3. `v2_20260323_create_tables.sql`
4. `v1_20260323_create_functions_and_triggers.sql`
5. `v1_20260323_alter_tables.sql`
6. `v1_20260323_indexes.sql`
7. `v3_20260323_insert_data.sql`
8. `v1_20260323_comments_metadata.sql`
9. `v1_20260323_maintenance.sql`
10. `v3_20260323_querys_data.sql`

## Notas rápidas

- Trigger: al insertar en `reportes_fallos`, la `pizarra` pasa a `En Reparación`.
- Índices: en `fecha` y `tecnico_id` para que las consultas no se pongan lentas.
- Mantenimiento: `VACUUM ANALYZE reportes_fallos;` para limpiar tuplas muertas y refrescar estadísticas.

## Reset completo

```bash
docker compose down -v
docker compose up -d
```

## Autores

- CRISTIAN ALBERTO PINEDA BLANCO - PB20002
- ANDRÉS ISAÍ VÁSQUEZ VÁSQUEZ - VV18009
