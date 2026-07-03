# Stack Tecnológico

> Fuente de verdad de las tecnologías y versiones del proyecto.
> **Última actualización**: 2026-07-02

## Backend

| Categoría | Tecnología | Versión | Por qué                                             |
| --------- | ---------- | ------- | --------------------------------------------------- |
| Runtime   | Python     | 3.11    | Versión estable y ampliamente soportada.            |
| Framework | Flask      | latest  | Micro-framework mínimo, ideal para una API pequeña. |

## DevOps & Herramientas

| Categoría    | Tecnología                    |
| ------------ | ----------------------------- |
| CI/CD        | GitHub Actions                |
| Contenedores | Docker + Docker Compose       |
| Infra (IaC)  | Terraform (EC2, SG, Key Pair) |
| Cómputo      | AWS EC2 (Ubuntu)              |
| Despliegue   | SSH desde GitHub Actions      |
| Testing      | Pytest                        |

## Servicios externos

| Servicio | Uso                                   | Credenciales necesarias               |
| -------- | ------------------------------------- | ------------------------------------- |
| AWS EC2  | Alojar el contenedor de la aplicación | Clave SSH (`EC2_KEY_BASE64`), Terraform |
| GitHub   | Repositorio y ejecución de CI/CD      | Secrets de Actions                    |

## Justificación de elecciones

| Tecnología elegida | Alternativa descartada  | Razón                                                    |
| ------------------ | ----------------------- | -------------------------------------------------------- |
| Flask              | Django / FastAPI        | Un ejemplo educativo no necesita ORM ni tipado async.    |
| EC2 + SSH          | ECS / Heroku / Fly.io   | Enseña el flujo de deploy "a mano" de forma transparente. |
| Terraform          | Consola de AWS manual   | Infraestructura reproducible y versionada.               |

## Versiones mínimas soportadas

- Python >= 3.11
- Docker >= 20.x y Docker Compose
- Terraform >= 1.x
