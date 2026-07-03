# Convenciones de testing

> Cómo escribimos y ejecutamos tests en Proyecto Python DevOps.
> **Última actualización**: 2026-07-02

## Stack

- **Framework de tests**: Pytest.
- **Cliente de pruebas**: `app.test_client()` de Flask.

## Tipos de test

| Tipo      | Qué cubre                       | Carpeta  |
| --------- | ------------------------------- | -------- |
| Unitarios | Rutas y funciones de la app     | `tests/` |

## Reglas

- Todo cambio funcional se acompaña de tests.
- Estructura **Arrange-Act-Assert** (AAA): preparar, ejecutar, verificar.
- Un test verifica **una** cosa; nombres descriptivos del comportamiento esperado.
- Los tests deben ser deterministas (sin dependencia de red, reloj o orden).
- Los tests son un check **bloqueante** en CI: si fallan, no hay deploy.

## Ejemplo

```python
from app.app import app

def test_health_check():
    client = app.test_client()          # Arrange
    response = client.get("/health")    # Act
    assert response.status_code == 200  # Assert
    assert b"OK" in response.data
```

## Comandos útiles

```bash
pytest                    # Ejecutar todos los tests
pytest -v                 # Modo verboso
export PYTHONPATH="$(pwd)" && pytest tests/   # Como corre en CI
```

## Referencias

- [Documentación de Pytest](https://docs.pytest.org/)
- [Testing en Flask](https://flask.palletsprojects.com/en/stable/testing/)
