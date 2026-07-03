# 0003. Gestionar la infraestructura con Terraform

- **Estado**: Aceptada
- **Fecha**: 2026-07-02
- **Decisores**: Brayan Diaz C

## Contexto y problema

La aplicación necesita una instancia EC2, un Security Group que restrinja el acceso
y un Key Pair para SSH. Crear estos recursos a mano en la consola de AWS no es
reproducible ni versionable, y dificulta enseñar el "estado deseado" de la infra.

## Opciones consideradas

- **Consola de AWS (click-ops)** — rápido de empezar, imposible de versionar y
  propenso a configuraciones no documentadas.
- **AWS CloudFormation** — nativo de AWS pero más verboso y atado al proveedor.
- **Terraform** — IaC declarativo, versionable y ampliamente usado en la industria.

## Decisión

Adoptamos **Terraform** para declarar la infraestructura en `terraform/`
(`main.tf`, `variables.tf`, `outputs.tf`). El estado deseado queda versionado junto
al código.

## Consecuencias

**Positivas:**

- Infraestructura reproducible con `terraform apply`.
- La IP pública se obtiene como output (`terraform output`).

**Negativas / costos:**

- Hay que gestionar el archivo de estado de Terraform con cuidado (no versionarlo con secretos).

**Neutras / a vigilar:**

- Mantener las variables sensibles (`my_ip`, `public_key_path`) fuera del control de versiones.

## Referencias

- [`../conventions/deploy.md`](../conventions/deploy.md)
- [Documentación de Terraform](https://developer.hashicorp.com/terraform)
