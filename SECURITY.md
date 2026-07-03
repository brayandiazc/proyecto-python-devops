# Política de Seguridad

Este documento describe cómo reportar vulnerabilidades en **Proyecto Python DevOps** y qué prácticas de seguridad seguimos en el repositorio.

## Tabla de Contenidos

- [Reporte de Vulnerabilidades](#reporte-de-vulnerabilidades)
  - [Información a incluir](#información-a-incluir)
  - [Qué esperar](#qué-esperar)
- [Versiones Soportadas](#versiones-soportadas)
- [Alcance](#alcance)
- [Fuera de Alcance](#fuera-de-alcance)
- [Manejo de Secretos](#manejo-de-secretos)
- [Dependencias](#dependencias)
- [Prácticas de Desarrollo Seguro](#prácticas-de-desarrollo-seguro)
- [Respuesta a Incidentes](#respuesta-a-incidentes)
- [Reconocimientos](#reconocimientos)
- [Contacto](#contacto)

## Reporte de Vulnerabilidades

Si descubres una vulnerabilidad de seguridad, **no abras un issue público**. Repórtala de forma privada a través de uno de estos canales:

- **Email**: <brayandiazc@gmail.com> (preferido — usa un asunto que empiece con `Security:` para priorizarlo).
- **GitHub Security Advisories**: pestaña _Security_ del repositorio → _Report a vulnerability_.

### Información a incluir

Para poder triagear y responder rápido, incluye:

1. Descripción clara de la vulnerabilidad.
2. Pasos para reproducirla (PoC si es posible).
3. Impacto estimado (qué se puede comprometer).
4. Versión / commit afectado.
5. Sugerencia de mitigación (opcional).
6. Si quieres crédito público en la corrección, indica nombre y handle.

### Qué esperar

| Etapa                              | Tiempo objetivo             |
| ---------------------------------- | --------------------------- |
| Acuse de recibo                    | 48 horas hábiles            |
| Triage inicial y severidad         | 5 días hábiles              |
| Corrección de severidad crítica    | 7 días                      |
| Corrección de severidad alta       | 30 días                     |
| Corrección de severidad media/baja | próxima release planificada |

Nos comprometemos a confirmar la recepción, mantenerte informado del progreso, no tomar represalias legales contra reportes de buena fe y acreditarte en el changelog/advisory una vez publicada la corrección (si lo deseas).

## Versiones Soportadas

| Versión                 | Soporte de seguridad          |
| ----------------------- | ----------------------------- |
| `main` (rama principal) | Sí                            |
| `develop` (integración) | Sí                            |
| Releases / tags         | Solo la última versión mayor  |

## Alcance

Superficies **en alcance** para reportes de seguridad:

- Código fuente del repositorio (aplicación Flask en `app/`).
- Endpoints HTTP expuestos por el proyecto (`/`, `/health`).
- Infraestructura declarada en `terraform/` (EC2, Security Groups, Key Pair).
- Pipelines de CI/CD del repositorio (`.github/workflows/`).
- Imágenes/contenedores Docker publicados desde este repositorio.

Ejemplos de hallazgos de interés:

- Inyecciones (comandos, plantillas, deserialización).
- Cross-Site Scripting (XSS), CSRF, SSRF, clickjacking.
- Autenticación rota o bypass de autorización.
- Escalada de privilegios.
- Exposición de datos sensibles (claves SSH, secretos de CI/CD, credenciales de AWS).
- Configuraciones inseguras (Security Groups demasiado abiertos, puertos expuestos, TLS).
- Vulnerabilidades en dependencias con impacto demostrable.
- Path traversal, RCE, LFI/RFI.

## Fuera de Alcance

Los siguientes hallazgos **no califican** como vulnerabilidades:

- Reportes de scanners automáticos sin impacto demostrado.
- Ausencia de headers de seguridad sin un vector de explotación.
- Self-XSS, ingeniería social, phishing.
- Denegación de servicio (DoS / DDoS) por volumen de tráfico.
- Vulnerabilidades en dependencias sin vector de explotación en este proyecto.
- Divulgación de información ya pública.

> **Nota:** este es un proyecto **educativo**. La configuración por defecto (puerto 5000 sin TLS, `debug` de Flask, Security Group abierto a tu IP) está pensada para aprendizaje, no para producción real. No la uses tal cual para datos sensibles.

## Manejo de Secretos

- **Nunca** commitear secretos en texto plano (claves SSH privadas, credenciales de AWS, tokens, contraseñas, archivos `.env` con valores reales).
- Los secretos de despliegue (`EC2_HOST`, `EC2_USER`, `EC2_KEY_BASE64`) viven como **GitHub Actions Secrets** cifrados, nunca en el repositorio. Ver [`docs/conventions/secrets.md`](docs/conventions/secrets.md).
- Comparte las credenciales fuera de banda con nuevos colaboradores (nunca por git, email en texto plano ni chat público).
- Rota credenciales periódicamente (sugerido cada **90 días**) y de inmediato ante sospecha de compromiso.
- Si un secreto se commitea por error: **rota el secreto antes de limpiar la historia**. Reescribir la historia no es suficiente — asume que ya está comprometido.

## Dependencias

- Fija las versiones de dependencias en `requirements.txt`.
- Las actualizaciones automáticas se gestionan con **Dependabot** (`.github/dependabot.yml`) — PRs revisados por humanos antes del merge.
- Las vulnerabilidades críticas en dependencias se atienden con la misma prioridad que las del propio código.

## Prácticas de Desarrollo Seguro

### Infraestructura y acceso

- El acceso SSH a la instancia EC2 se restringe por IP mediante el Security Group (`terraform/`).
- La clave privada SSH nunca se versiona; se inyecta en CI como secreto base64.
- Aplica el principio de mínimo privilegio en los Security Groups y roles de AWS.

### Validación de Input

- Valida y normaliza el input en todos los bordes del sistema.
- Codifica el output según el contexto (HTML, atributo, URL, JS, CSS).
- Prefiere listas blancas sobre listas negras.

### Comunicación

- En un despliegue real, sirve la aplicación detrás de HTTPS (reverse proxy con TLS).
- Verifica la firma de los webhooks entrantes sobre el cuerpo crudo.

### Logging y Monitoreo

- No loguees secretos, contraseñas, tokens ni PII innecesaria.
- Monitorea errores y configura alertas para anomalías y picos de error.

### Code Review

- Toda PR requiere aprobación antes del merge (ver [CONTRIBUTING.md](CONTRIBUTING.md)).
- Los cambios sensibles (infraestructura, manejo de secretos, CI/CD) requieren revisión específica de seguridad.

## Respuesta a Incidentes

En caso de incidente de seguridad confirmado:

1. **Contener**: aislar el sistema afectado, revocar credenciales comprometidas.
2. **Comunicar internamente**: notificar al equipo responsable por el canal definido.
3. **Investigar**: identificar causa raíz, alcance y vectores de explotación.
4. **Remediar**: aplicar la corrección, redeploy, rotar todos los secretos potencialmente expuestos.
5. **Notificar a los afectados**: si hubo exposición de datos personales, según las obligaciones legales aplicables.
6. **Post-mortem**: documentar el incidente, lecciones aprendidas y acciones correctivas.

## Reconocimientos

Agradecemos a quienes reportan vulnerabilidades de forma responsable.

<!-- Orden cronológico inverso. Formato: - YYYY-MM-DD — Nombre/Handle — Resumen breve -->

- _Aún no hay reportes públicos._

## Contacto

- **Reportes de seguridad**: <brayandiazc@gmail.com> (asunto: `Security: …`)
- **Consultas generales**: <brayandiazc@gmail.com>

---

> Versión: 1.0 — Última actualización: 2026-07-02
