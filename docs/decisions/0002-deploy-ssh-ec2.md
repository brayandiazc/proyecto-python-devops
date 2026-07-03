# 0002. Desplegar por SSH a una instancia EC2

- **Estado**: Aceptada
- **Fecha**: 2026-07-02
- **Decisores**: Brayan Diaz C

## Contexto y problema

El proyecto es educativo: su objetivo es que el estudiante entienda, de forma
transparente, cómo se lleva código desde un `git push` hasta un servidor en
producción. Necesitábamos un mecanismo de despliegue simple, barato y observable.

## Opciones consideradas

- **PaaS (Heroku / Fly.io / Render)** — despliegue trivial, pero oculta los pasos
  intermedios y no enseña la operación del servidor.
- **Contenedores gestionados (ECS / Kubernetes)** — más cercano a producción real,
  pero con una curva de aprendizaje alta para un ejemplo introductorio.
- **SSH a EC2 + Docker Compose** — el pipeline se conecta por SSH y ejecuta
  `git pull` + `docker-compose up -d --build`.

## Decisión

Elegimos **desplegar por SSH a una instancia EC2** con Docker Compose, orquestado
por GitHub Actions. La clave privada se inyecta en CI como secreto base64.

## Consecuencias

**Positivas:**

- El flujo de despliegue es explícito y fácil de razonar.
- Bajo costo y sin dependencias de PaaS.

**Negativas / costos:**

- Sin _blue/green_ ni orquestación: hay un breve downtime durante el rebuild.
- La operación del servidor (parches, TLS) queda a cargo del usuario.

**Neutras / a vigilar:**

- La superficie de acceso SSH debe restringirse por IP (Security Group).

## Referencias

- [`../conventions/deploy.md`](../conventions/deploy.md)
- [`../conventions/secrets.md`](../conventions/secrets.md)
