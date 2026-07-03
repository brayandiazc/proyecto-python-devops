# Referencia de API

> Endpoints y convenciones de la API de **Proyecto Python DevOps**.
>
> **Última actualización**: 2026-07-02

## Convenciones generales

- **URL base (local)**: `http://localhost:5000`
- **URL base (EC2)**: `http://<IP_PUBLICA>:5000`
- **Formato**: texto plano (la API actual no devuelve JSON).

## Endpoints

### `GET /`

Ruta de bienvenida.

```http
GET /
```

**Respuesta:** `200 OK`

```text
Bienvenido al proyecto DevOps educativo con cambios
```

### `GET /health`

Health check usado para verificar que el servicio está arriba (por el propio
despliegue y por monitoreo básico).

```http
GET /health
```

**Respuesta:** `200 OK`

```text
OK, están probando la ruta web
```

**Ejemplo:**

```bash
curl http://localhost:5000/health
```

## Manejo de errores

La aplicación es mínima y no define aún un formato de error estándar. Las rutas no
declaradas devuelven el `404` por defecto de Flask.

## Changelog de la API

- **v1.0.0** — Rutas iniciales `/` y `/health`.
