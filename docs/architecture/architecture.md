# Proyecto Python DevOps — Arquitectura

> Vista de alto nivel de cómo está construido el sistema y cómo se reparten las
> responsabilidades. Para el stack real (versiones, librerías) ver
> [`stack.md`](stack.md). Para el contrato HTTP ver [`api.md`](api.md).
>
> **Última actualización**: 2026-07-02

## Diagrama

```mermaid
graph TD
    subgraph Local
        Dev[Desarrollador]
    end
    subgraph GitHub
        Repo[Repositorio]
        Actions[GitHub Actions]
    end
    subgraph "AWS (EC2)"
        Docker[Docker + docker-compose]
        Flask[App Flask :5000]
    end
    subgraph IaC
        TF[Terraform]
    end

    Dev -->|git push| Repo
    Repo --> Actions
    Actions -->|pytest| Actions
    Actions -->|SSH deploy| Docker
    Docker --> Flask
    TF -->|provisiona| Docker
    Cliente[Cliente HTTP] -->|GET /| Flask
    Cliente -->|GET /health| Flask
```

## Componentes

| Componente          | Responsabilidad                                             | Tecnología                |
| ------------------- | ---------------------------------------------------------- | ------------------------- |
| Aplicación web      | Servir las rutas `/` y `/health` sobre HTTP.               | Python 3.11 + Flask       |
| Contenedor          | Empaquetar la app y sus dependencias de forma reproducible. | Docker + Docker Compose   |
| Pipeline CI/CD      | Ejecutar tests y desplegar a EC2 en cada push a `main`.    | GitHub Actions            |
| Infraestructura     | Provisionar la instancia EC2, Security Group y Key Pair.   | Terraform                 |
| Cómputo             | Alojar el contenedor en la nube.                           | AWS EC2 (Ubuntu)          |

## Decisiones clave

| Decisión                               | Razón                                                         |
| -------------------------------------- | ------------------------------------------------------------ |
| Flask como framework web               | Mínimo, ideal para un ejemplo educativo de una API pequeña.  |
| Despliegue por SSH a EC2               | Muestra un flujo CI/CD simple y transparente sin PaaS.       |
| Terraform para la infraestructura      | Infraestructura reproducible y versionada (IaC).             |
| Docker Compose en el servidor          | Un solo comando (`up -d --build`) para levantar/actualizar.  |

> El detalle y las alternativas de cada decisión relevante se registran como
> ADRs en [`../decisions/`](../decisions/README.md).

## Reglas no negociables

- Solo se despliega a producción (EC2) desde la rama `main`, y solo si los tests pasan.
- Las claves y secretos nunca se versionan: viven como GitHub Actions Secrets.
- Cada cambio funcional se acompaña de un test.

## Flujo principal (CI/CD)

```mermaid
sequenceDiagram
    actor Dev as Desarrollador
    participant GH as GitHub
    participant GA as GitHub Actions
    participant EC2 as EC2
    Dev->>GH: push a main
    GH->>GA: dispara workflow
    GA->>GA: pytest
    alt tests OK y rama main
        GA->>EC2: SSH + git pull + docker-compose up -d --build
        EC2-->>GA: contenedor actualizado
    else tests fallan
        GA-->>Dev: pipeline en rojo (sin deploy)
    end
```

## Referencias

- [`stack.md`](stack.md) — stack tecnológico y versiones.
- [`api.md`](api.md) — contrato de API.
- [`../conventions/deploy.md`](../conventions/deploy.md) — cómo se despliega y opera.
- [`../conventions/`](../conventions/README.md) — convenciones de trabajo.
