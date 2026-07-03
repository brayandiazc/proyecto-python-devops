# Convenciones de despliegue

> Operaciones de Proyecto Python DevOps. Fuente de verdad de cómo se despliega,
> se hace rollback y se opera el sistema.
> **Última actualización**: 2026-07-02

## Stack de infraestructura

- **Hosting / cómputo**: AWS EC2 (Ubuntu).
- **Contenedores**: Docker + Docker Compose.
- **CI/CD**: GitHub Actions (`.github/workflows/deploy.yml`).
- **Infraestructura**: Terraform (`terraform/`).

## Ambientes

| Ambiente   | URL                        | Rama   | Deploy                    |
| ---------- | -------------------------- | ------ | ------------------------- |
| Producción | `http://<IP_PUBLICA>:5000` | `main` | Automático (push a `main`) |

> Es un proyecto educativo con un único ambiente. La rama `develop` se usa para
> integración y solo ejecuta tests (no despliega).

## Reglas

- Solo se despliega a producción desde `main`, y solo si los tests pasan.
- Cada deploy debe ser reproducible: la imagen se reconstruye desde el `Dockerfile`.
- Las variables de entorno y secretos se gestionan según [`secrets.md`](secrets.md).
- Verificar el health check tras cada deploy.

## Provisión de infraestructura (una vez)

```bash
cd terraform
terraform init
terraform apply
terraform output   # obtiene la IP pública de la EC2
```

## Procedimiento de deploy

El deploy es **automático** en cada push a `main`. El workflow:

1. Ejecuta `pytest`.
2. Si pasa y la rama es `main`, se conecta por SSH a la EC2 y ejecuta:

```bash
cd /home/ubuntu/proyecto-python-devops
git pull origin main
docker-compose down
docker-compose up -d --build
```

### Deploy manual (desde la instancia)

```bash
ssh -i ~/.ssh/id_rsa ubuntu@<IP_PUBLICA>
cd proyecto-python-devops
docker-compose up -d --build
```

## Rollback

```bash
# En la instancia EC2
cd proyecto-python-devops
git checkout <commit_estable>
docker-compose up -d --build
```

## Health checks y monitoreo

- Endpoint de salud: `GET /health` → `200 OK`.

```bash
curl http://<IP_PUBLICA>:5000/health
```

## Referencias

- [`../decisions/0002-deploy-ssh-ec2.md`](../decisions/0002-deploy-ssh-ec2.md)
- [`../decisions/0003-terraform-iac.md`](../decisions/0003-terraform-iac.md)
- [`secrets.md`](secrets.md) — secretos del pipeline.
