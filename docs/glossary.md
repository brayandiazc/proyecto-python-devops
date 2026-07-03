# Glosario

Vocabulario compartido del dominio y del proyecto. Mantén las definiciones cortas
y sin ambigüedad para que todo el equipo use los términos de la misma forma.

| Término        | Definición                                                                                     |
| -------------- | ---------------------------------------------------------------------------------------------- |
| ADR            | _Architecture Decision Record_: documento corto que registra una decisión de arquitectura.     |
| CI/CD          | Integración y Entrega/Despliegue continuos: automatización de tests y despliegue.              |
| Docker Compose | Herramienta para definir y levantar contenedores con un solo comando.                          |
| EC2            | _Elastic Compute Cloud_: servicio de máquinas virtuales de AWS donde corre la aplicación.      |
| Health check   | Endpoint (`/health`) que confirma que el servicio está operativo.                              |
| IaC            | _Infrastructure as Code_: gestionar infraestructura con archivos versionados (aquí, Terraform). |
| Key Pair       | Par de claves SSH usado para autenticar el acceso a la instancia EC2.                          |
| Security Group | Firewall virtual de AWS que controla el tráfico entrante/saliente de la instancia EC2.          |
| Workflow       | Definición de un pipeline de GitHub Actions (`.github/workflows/deploy.yml`).                   |

> Convención: ordena los términos alfabéticamente y enlaza al documento donde se
> detalla cada concepto cuando aplique.
