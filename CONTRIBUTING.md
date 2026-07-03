# Guía de Contribución

¡Gracias por tu interés en contribuir a **Proyecto Python DevOps**! Esta guía describe el flujo de trabajo, los estándares de código y el proceso de Pull Requests.

## Tabla de Contenidos

- [Configuración del Entorno](#configuración-del-entorno)
- [Flujo de Trabajo](#flujo-de-trabajo)
- [Estándares de Código](#estándares-de-código)
- [Commits y Mensajes](#commits-y-mensajes)
- [Pull Requests](#pull-requests)
- [Revisión de Código](#revisión-de-código)
- [Testing](#testing)

## Configuración del Entorno

Sigue las instrucciones de instalación del [README](README.md#instalación). Asegúrate de que los tests pasen localmente (`pytest`) antes de empezar a trabajar.

## Flujo de Trabajo

Usamos un flujo **Git Flow** simplificado.

### Estrategia de Branching

| Rama       | Propósito                                        | Origen    | Destino            |
| ---------- | ------------------------------------------------ | --------- | ------------------ |
| `main`     | Código en producción. Siempre estable.           | —         | —                  |
| `develop`  | Integración de funcionalidades. Pre-release.     | `main`    | `main`             |
| `feat/*`   | Nueva funcionalidad.                             | `develop` | `develop`          |
| `fix/*`    | Corrección de bug no urgente.                    | `develop` | `develop`          |
| `hotfix/*` | Corrección urgente en producción.                | `main`    | `main` y `develop` |
| `docs/*`   | Cambios solo de documentación.                   | `develop` | `develop`          |
| `chore/*`  | Tareas de mantenimiento, tooling, configuración. | `develop` | `develop`          |

```mermaid
gitGraph
    commit
    branch develop
    checkout develop
    commit
    branch feat/nueva-funcionalidad
    checkout feat/nueva-funcionalidad
    commit
    commit
    checkout develop
    merge feat/nueva-funcionalidad
    checkout main
    merge develop tag: "v1.0.0"
```

### Flujo de una funcionalidad

```bash
# 1. Parte de develop actualizado
git checkout develop
git pull origin develop

# 2. Crea tu rama
git checkout -b feat/nombre-descriptivo

# 3. Trabaja y commitea (ver formato abajo)
git add .
git commit -m "feat: agrega X"

# 4. Sube tu rama y abre un PR hacia develop
git push origin feat/nombre-descriptivo
```

### Flujo de hotfix

Los hotfix parten de `main`, se mergean a `main` y luego se sincronizan a `develop`.

```bash
git checkout main
git pull origin main
git checkout -b hotfix/descripcion-del-fix
# ... fix + commit ...
git push origin hotfix/descripcion-del-fix
```

### Nombrado de ramas

- En minúsculas, con prefijo de tipo y descripción en `kebab-case`: `feat/ruta-metrics`, `fix/health-status`, `docs/actualizar-readme`.

### Políticas de ramas

- `main` y `develop` están protegidas: no se permite push directo, solo vía PR aprobado.
- Un `push` a `main` dispara el pipeline de despliegue a EC2 (ver [`docs/conventions/deploy.md`](docs/conventions/deploy.md)).
- Mantén tu rama actualizada con `develop` (rebase o merge) antes de abrir el PR.

## Estándares de Código

### Formato

- Indentación y estilo definidos por [`.editorconfig`](.editorconfig).
- Sigue [PEP 8](https://peps.python.org/pep-0008/); líneas de máximo 88 caracteres (estilo Black).
- Codificación UTF-8, finales de línea LF, 4 espacios de indentación en Python.

### Nombrado

- Sigue las convenciones idiomáticas de Python: `snake_case` para funciones y variables, `PascalCase` para clases, `MAYÚSCULAS` para constantes.
- Nombres descriptivos; evita abreviaturas crípticas.

### Comentarios

- Comenta el _por qué_, no el _qué_. El código debe explicarse solo.
- Documenta las decisiones no obvias y enlaza al ADR correspondiente cuando aplique.

## Commits y Mensajes

Usamos [Conventional Commits](https://www.conventionalcommits.org/es/v1.0.0/):

```
<tipo>(<ámbito opcional>): <descripción breve en imperativo>

<cuerpo opcional>

<footer opcional: BREAKING CHANGE, Closes #123>
```

Tipos comunes: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`.

Ejemplos:

```
feat(app): agrega endpoint /metrics
fix(health): corrige el mensaje de la ruta de salud
ci: actualiza la versión de setup-python
docs: actualiza la guía de despliegue
```

## Pull Requests

- Usa la [plantilla de PR](.github/PULL_REQUEST_TEMPLATE.md) (se carga automáticamente).
- Un PR por cambio lógico; mantenlos pequeños y enfocados.
- Vincula los issues relacionados (`Closes #123`).
- Asegúrate de que CI pase (tests con `pytest`).

## Revisión de Código

**Como autor:**

- Haz una auto-revisión antes de pedir review.
- Responde a los comentarios y marca las conversaciones resueltas.

**Como revisor:**

- Sé respetuoso y específico; sugiere, no impongas.
- Verifica correctitud, legibilidad, tests y posibles regresiones.

## Testing

- Acompaña cada cambio funcional con tests.
- Ejecuta la suite completa antes de abrir el PR (`pytest`).
- Sigue las [convenciones de testing](docs/conventions/testing.md).
