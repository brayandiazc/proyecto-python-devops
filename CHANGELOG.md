# Changelog

Todos los cambios notables de este proyecto se documentan en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [Unreleased]

### Changed

- Actualiza la imagen base de Docker de Python 3.11-slim a 3.14-slim (Dependabot).
- Actualiza `actions/checkout` de v3 a v7 y `actions/setup-python` de v4 a v6 (Dependabot).
- Alinea la versión de Python del CI y de la documentación a 3.14.

## [1.0.0] - 2026-07-02

### Added

- Aplicación Flask con las rutas `/` (bienvenida) y `/health` (health check).
- Suite de tests con Pytest (`tests/test_app.py`).
- Contenerización con `Dockerfile` y `docker-compose.yml`.
- Infraestructura como código con Terraform (`terraform/`): instancia EC2, Security Group y Key Pair.
- Pipeline de CI/CD con GitHub Actions (`.github/workflows/deploy.yml`): tests en cada push/PR y despliegue automático a EC2 por SSH desde `main`.
- Estructura de documentación basada en la plantilla `project-starter-template-es`:
  - Documentos de gobernanza: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CHANGELOG.md`.
  - Documentación técnica en `docs/` (arquitectura, stack, API, convenciones, decisiones, roadmap y glosario).
  - Configuración de repositorio en `.github/` (FUNDING, dependabot, labeler, LABELS, scripts de labels y formato).
  - Higiene del repo: `.editorconfig` y `.env.example`.

<!--
Enlaces de comparación entre versiones:
[Unreleased]: https://github.com/brayandiazc/proyecto-python-devops/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/brayandiazc/proyecto-python-devops/releases/tag/v1.0.0
-->

[Unreleased]: https://github.com/brayandiazc/proyecto-python-devops/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/brayandiazc/proyecto-python-devops/releases/tag/v1.0.0
