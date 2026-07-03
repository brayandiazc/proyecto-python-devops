# Convenciones de calidad y tooling

> Linters, formato, análisis estático y git hooks de Proyecto Python DevOps.
> **Última actualización**: 2026-07-02

## Stack

- **Estilo base**: [PEP 8](https://peps.python.org/pep-0008/) (líneas ≤ 88, estilo Black).
- **Editor**: reglas comunes vía [`.editorconfig`](../../.editorconfig).
- **Linter / formateador**: _recomendado_ (aún no configurado) — Ruff o Black + Flake8. Ver [roadmap](../product/roadmap.md).
- **Auditoría de dependencias**: Dependabot (`.github/dependabot.yml`).

## Git hooks (sugerido)

Estrategia: hooks baratos y rápidos en `pre-commit`, los más costosos en
`pre-push`. CI ejecuta todo de nuevo en el servidor.

### pre-commit

- Formato automático (Black/Ruff) sobre los archivos cambiados.
- Verificación de trailing whitespace y fin de archivo.

### pre-push

- `pytest` (o un subconjunto rápido).

## Reglas

- El código debe pasar los tests antes del merge.
- Los checks de calidad (tests) son **bloqueantes** en CI.
- Cuando se añada linter/formateador, también será bloqueante.

## Comandos útiles

```bash
pytest                     # Tests
# Recomendado a futuro:
# ruff check .             # Lint
# black .                  # Formato
```

## Referencias

- [`../../.editorconfig`](../../.editorconfig)
- [PEP 8](https://peps.python.org/pep-0008/)
