# Roadmap — Proyecto Python DevOps

> Estado y dirección del proyecto. Documento vivo.
> **Última actualización**: 2026-07-02

## Leyenda

- ✅ Hecho
- 🚧 En curso
- 📋 Planificado
- ⏸️ Diferido

## Visión

Ser un ejemplo educativo claro y completo de un flujo CI/CD moderno de punta a
punta: código en Python/Flask, contenerizado con Docker, con infraestructura
gestionada por Terraform y despliegue automático a AWS EC2 mediante GitHub Actions.

## Estado actual

- ✅ Aplicación Flask con rutas `/` y `/health`.
- ✅ Tests con Pytest.
- ✅ Contenerización con Docker y Docker Compose.
- ✅ Infraestructura con Terraform (EC2, Security Group, Key Pair).
- ✅ CI/CD con GitHub Actions (test + deploy por SSH a EC2).
- ✅ Documentación y gobernanza alineadas con la plantilla de proyectos.

## Próximos pasos

### Calidad

- 📋 Añadir linter/formateador (Ruff o Black + Flake8) y hacerlo bloqueante en CI.
- 📋 Reporte de cobertura de tests.

### Aplicación

- 📋 Devolver JSON en `/health` con estado y versión.
- 📋 Endpoint `/metrics` para observabilidad.

### Infraestructura / despliegue

- 📋 Servir la app detrás de un reverse proxy con HTTPS.
- 📋 Estrategia de rollback documentada y probada.

## Fuera de alcance

- Persistencia en base de datos (el proyecto es intencionalmente sin estado).
- Autenticación de usuarios.

## Cómo se actualiza este documento

- Revisar al cerrar cada versión/fase.
- Las decisiones que cambian el rumbo se registran como ADRs en [`../decisions/`](../decisions/README.md).
