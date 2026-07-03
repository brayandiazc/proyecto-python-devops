# Documentación de Proyecto Python DevOps

Mapa de la documentación del proyecto. Empieza por aquí para saber qué documento
responde cada pregunta.

| Documento                                                      | Pregunta que responde                | Cuándo leerlo                   |
| -------------------------------------------------------------- | ------------------------------------ | ------------------------------- |
| [`architecture/architecture.md`](architecture/architecture.md) | ¿Cómo está construido el sistema?    | Al entender el panorama general |
| [`architecture/stack.md`](architecture/stack.md)               | ¿Con qué tecnologías y versiones?    | Al configurar el entorno        |
| [`architecture/api.md`](architecture/api.md)                   | ¿Qué endpoints expone?               | Al integrar o consumir la API   |
| [`product/roadmap.md`](product/roadmap.md)                     | ¿Hacia dónde va?                     | Para conocer prioridades        |
| [`decisions/`](decisions/README.md)                            | ¿Por qué tomamos cada decisión?      | Antes de re-debatir algo        |
| [`conventions/`](conventions/README.md)                        | ¿Cómo trabajamos en este repo?       | Antes de escribir código        |
| [`glossary.md`](glossary.md)                                   | ¿Qué significa cada término?         | Ante vocabulario desconocido    |

## Sobre la distinción `architecture/` vs `conventions/`

- **`architecture/`** describe **este** proyecto en concreto (su arquitectura, su
  stack, su API).
- **`conventions/`** describe **reglas reusables** de cómo trabajamos
  (cómo desplegamos, cómo testeamos, cómo manejamos secretos) — transversales a
  cualquier feature.

## Cómo mantener esta documentación

- Actualiza la línea **"Última actualización"** al editar un documento.
- Registra las decisiones relevantes como [ADRs](decisions/README.md).
- Mantén este índice al día si agregas o quitas documentos.
