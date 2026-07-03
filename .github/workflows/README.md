# Workflows de CI/CD

Esta carpeta contiene los workflows de [GitHub Actions](https://docs.github.com/actions)
del proyecto.

## Workflows incluidos

| Workflow                     | Propósito                                                                 |
| ---------------------------- | ------------------------------------------------------------------------ |
| [`deploy.yml`](deploy.yml)   | Ejecuta los tests (`pytest`) en cada push/PR y, si la rama es `main` y pasan, despliega por SSH a la instancia EC2. |

### Detalle de `deploy.yml`

- **Disparadores**: `push` a `main`/`develop` y `pull_request` hacia `develop`.
- **Job `test`**: instala dependencias y corre `pytest tests/`.
- **Job `deploy`**: solo en `main` y tras pasar los tests; se conecta por SSH a la
  EC2 y ejecuta `git pull` + `docker-compose up -d --build`.

## Secrets

Define en **Settings → Secrets and variables → Actions** los secretos que necesita
el despliegue: `EC2_HOST`, `EC2_USER`, `EC2_KEY_BASE64`. Ver
[`../../docs/conventions/secrets.md`](../../docs/conventions/secrets.md).

## Labels automáticos

Los labels de PR se pueden gestionar con el script
[`../scripts/setup-labels.sh`](../scripts/setup-labels.sh) y las reglas de
[`../labeler.yml`](../labeler.yml).
