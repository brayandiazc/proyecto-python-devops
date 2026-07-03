# Convenciones

Esta carpeta documenta **cómo trabajamos** en Proyecto Python DevOps: reglas y
estándares transversales que aplican al día a día, independientes de cualquier
feature concreta.

> Diferencia con `docs/architecture/`: aquí van las **reglas** ("cómo desplegamos");
> en `architecture/` va **este** proyecto en concreto ("cuál es nuestra arquitectura").

## Convenciones incluidas

| Convención                               | Tema                              |
| ---------------------------------------- | --------------------------------- |
| [deploy.md](deploy.md)                   | Despliegue y operaciones          |
| [testing.md](testing.md)                 | Estrategia y estándares de testing |
| [secrets.md](secrets.md)                 | Manejo de secretos y credenciales |
| [quality-tooling.md](quality-tooling.md) | Linters, formato y git hooks      |

## Agregar una convención

Copia [`_template.md`](_template.md), renómbralo en `kebab-case` y documenta el
nuevo tema. Añádelo a la tabla de arriba.
