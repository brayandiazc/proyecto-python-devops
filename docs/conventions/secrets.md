# Convenciones de secretos y credenciales

> Cómo gestionamos secretos en Proyecto Python DevOps.
> **Última actualización**: 2026-07-02

## Filosofía

- Los secretos **nunca** se commitean en texto plano.
- Separación clara entre **configuración** (no sensible) y **secretos** (sensible).

## Dónde vive cada cosa

| Tipo                         | Dónde                                                   |
| ---------------------------- | ------------------------------------------------------- |
| Secretos de CI/CD (deploy)   | GitHub Actions Secrets (`Settings > Secrets > Actions`) |
| Clave privada SSH            | Solo en tu máquina y como secreto base64 en CI          |
| Variables de infraestructura | `terraform/variables.tf` o `TF_VAR_*` (sin valores reales versionados) |
| Configuración local          | `.env` local (ignorado por git); plantilla en `.env.example` |

## Secretos del pipeline de despliegue

El workflow `.github/workflows/deploy.yml` requiere estos secretos:

| Nombre           | Valor                                                                  |
| ---------------- | ---------------------------------------------------------------------- |
| `EC2_HOST`       | IP pública de la instancia EC2 (output de Terraform).                  |
| `EC2_USER`       | Usuario SSH de la instancia (p. ej. `ubuntu`).                         |
| `EC2_KEY_BASE64` | Clave privada SSH en base64: `base64 -i ~/.ssh/id_rsa` (una sola línea). |

## Reglas

- El archivo `.env` está en `.gitignore`; solo se versiona `.env.example` (sin valores).
- Comparte secretos con nuevos colaboradores **fuera de banda** (nunca por git, email plano ni chat público).
- Rota credenciales periódicamente (sugerido cada 90 días) y de inmediato ante sospecha de fuga.
- Si un secreto se commitea por error: **rota el secreto primero**, luego limpia la historia.
- No versiones el archivo de estado de Terraform si contiene datos sensibles.

## Ejemplos

```bash
# Copiar la plantilla de variables
cp .env.example .env
# Codificar la clave privada para el secreto de CI
base64 -i ~/.ssh/id_rsa
```

## Referencias

- [SECURITY.md](../../SECURITY.md) — política de seguridad.
- [GitHub Actions Secrets](https://docs.github.com/actions/security-guides/encrypted-secrets)
