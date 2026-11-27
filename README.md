# Gestor de Agenda · Taller 3

Aplicación Flutter (Android + Web) construida con **Clean Architecture**, base de datos **Neon (PostgreSQL serverless)** y flujo colaborativo **GitFlow** para un equipo de 5 aprendices.

> **Antes de escribir una sola línea, lee completo este README.** Explica qué hace cada persona, en qué rama y en qué orden, para que el historial de `main` y `develop` quede limpio.

## Despliegue

| Recurso | Link |
| --- | --- |
| Repositorio | https://github.com/Ryuksehen/Agenda |
| API (Swagger) | Pendiente · fase 2 |
| Web | Pendiente · fase 3 |
| APK | Pendiente · fase 3 (pestaña **Releases → v1.0.0**) |

---

## Equipo, ramas y archivos de cada uno

| Rol | Integrante | Rama | Archivos de los que es dueño |
| --- | --- | --- | --- |
| 1. Tech Lead / DevOps | Omar Meneses | `main`, `develop`, `release/*`, `feature/docs-readme` | `pubspec.yaml`, `analysis_options.yaml`, `android/`, `web/`, `.github/`, `README.md` |
| 2. Backend & Data Engineer | Samuel Marin | `feature/neon-datasource` | `database/`, `api/`, `tool/`, `lib/core/constants/`, `lib/core/network/`, `lib/core/errors/exceptions.dart`, `lib/features/planner/data/` |
| 3. Domain Architect | Erick Camargo | `feature/domain-layer` | `lib/core/errors/failures.dart`, `lib/features/planner/domain/`, `test/helpers/`, `test/features/` |
| 4. UI/UX & Core Widgets | Gabriel Mesa | `feature/ui-components` | `lib/core/theme/`, `lib/core/utils/`, `lib/features/planner/presentation/widgets/` |
| 5. State & Integration Dev | Alejandro Gomez | `feature/presentation-logic` | `lib/features/planner/presentation/bloc/`, `lib/features/planner/presentation/pages/`, `lib/injection_container.dart`, `lib/main.dart` |

**Regla de oro: cada quien solo edita los archivos de su fila.** Si necesitas un cambio en un archivo ajeno, pídeselo a su dueño. Así no hay conflictos de merge.

- **Nadie agrega paquetes.** Todas las dependencias (`dio`, `flutter_bloc`, `get_it`, `intl`, `table_calendar`, `flutter_localizations`) ya están en `pubspec.yaml`. No corras `flutter pub add`.
- **`lib/main.dart` es un placeholder** hasta la fase 3; solo Alejandro lo modifica.

---

## Modelo de ramas

```
main      ●───────────────●───────────────●───────────────●     (solo merges de release + tags)
           \             /v0.1.0         /v0.2.0         /v1.0.0
release/*   \     release/v0.1.0   release/v0.2.0   release/v1.0.0
             \         /                /                /
develop       ●──●──●──●──────●──●──●──●──────●──●──●──●          (1 commit squash por PR)
                 ↑  ↑  ↑      ↑  ↑  ↑  ↑      ↑  ↑  ↑
                 feature/*    feature/*       feature/*
```

| Rama | Nace de | Se fusiona en | Tipo de merge | Quién la crea |
| --- | --- | --- | --- | --- |
| `main` | — | — | — | Tech Lead (una sola vez) |
| `develop` | `main` | — | — | Tech Lead (una sola vez) |
| `feature/*` | `develop` | `develop` | **Squash and merge** | Cada integrante |
| `release/vX.Y.Z` | `develop` | `main` (y `develop` si tuvo arreglos) | **Create a merge commit** | Tech Lead |
| `fix/*` | `release/vX.Y.Z` | la misma `release/vX.Y.Z` | **Squash and merge** | Quien corrige el bug |

### Reglas obligatorias

1. **Prohibido hacer `push` directo a `main` o `develop`.** GitHub lo bloquea.
2. Toda funcionalidad nace de `develop` actualizado, con el formato `feature/nombre-tarea`.
3. Todo PR necesita **2 aprobaciones**, y una siempre es del **Tech Lead**.
4. Al terminar cada fase se crea `release/vX.Y.Z`, se prueba, se fusiona a `main` y se etiqueta con `git tag`.
5. Antes de abrir un PR: `flutter analyze` sin errores y `flutter test` en verde.
6. Mensajes de commit con prefijo: `feat:`, `fix:`, `test:`, `docs:`, `chore:`. Ejemplo: `feat(domain): casos de uso CRUD`.
7. **Cuando tu PR se fusiona, borras tu rama y la vuelves a crear desde `develop`** antes de seguir.

### ¿Por qué squash y por qué recrear la rama?

- **Squash and merge** convierte todos los commits de tu rama en **un solo commit** en `develop`, aunque hayas hecho 20.
- El squash crea un commit nuevo, así que Git ya no reconoce tus commits viejos como fusionados. Si reusas la rama, tu siguiente PR mostrará otra vez cambios que ya entraron y aparecerán conflictos. Por eso: **rama fusionada = rama que se borra y se vuelve a crear**.
- Los PR `release → main` usan **merge commit**, así `main` tiene exactamente un commit por versión, con su tag.

---

## Configuración inicial (cada integrante, una sola vez)

1. Acepta la invitación al repositorio que llega a tu correo de GitHub.
2. **Borra cualquier copia vieja** del repositorio anterior que tengas en tu PC.
3. Actualiza Flutter (el proyecto exige Dart 3.13 o superior):

```powershell
flutter upgrade
```

4. Configura tu identidad en Git (si nunca lo hiciste):

```powershell
git config --global user.name "Tu Nombre"
```

```powershell
git config --global user.email "tu-correo-de-github@ejemplo.com"
```

5. Clona el repositorio y descarga las dependencias:

```powershell
git clone https://github.com/Ryuksehen/Agenda.git
```

```powershell
cd Agenda
```

```powershell
flutter pub get
```

---

## Ciclo de trabajo de una feature (Samuel, Erick, Gabriel y Alejandro)

Reemplaza `MI-RAMA` por la tuya: `neon-datasource`, `domain-layer`, `ui-components` o `presentation-logic`.

### 1. Empezar (al inicio de cada fase o tarea)

```powershell
git checkout develop
```

```powershell
git pull origin develop
```

Solo si tu rama ya existía de la fase anterior (si dice que no existe, ignóralo):

```powershell
git branch -D feature/MI-RAMA
```

```powershell
git checkout -b feature/MI-RAMA
```

### 2. Trabajar y guardar avances

Commits pequeños y frecuentes. Antes de `git add .`, revisa con `git status` que solo aparezcan archivos de tus carpetas.

```powershell
git add .
```

```powershell
git commit -m "feat(data): EventoModel con fromJson y toJson"
```

**Nunca subas `.env` ni la cadena de conexión de Neon.**

### 3. Traer lo que otros ya fusionaron

```powershell
git fetch origin
```

```powershell
git merge origin/develop
```

Si hay conflicto en un archivo tuyo, resuélvelo en el editor, luego `git add .` y `git commit`. Si el conflicto es en un archivo ajeno, **pide ayuda al Tech Lead** en lugar de adivinar.

### 4. Verificar

```powershell
flutter analyze
```

```powershell
flutter test
```

### 5. Subir y abrir el Pull Request

```powershell
git push -u origin feature/MI-RAMA
```

En GitHub pulsa **Compare & pull request** y revisa:

- **base:** `develop` ← **compare:** `feature/MI-RAMA` (nunca `main`)
- **Título:** en formato de commit, porque será el mensaje del squash. Ej.: `feat(domain): entidades y casos de uso CRUD`
- **Descripción:** completa la plantilla
- **Reviewers:** el Tech Lead y tu segundo revisor (tabla de abajo)

### 6. Durante la revisión

- Si te piden cambios: corrige en la misma rama, `git commit` y `git push`. El PR se actualiza solo. Las aprobaciones anteriores se anulan y deben aprobar otra vez.
- Responde y marca como resueltas todas las conversaciones: GitHub no deja fusionar con conversaciones abiertas.

### 7. Fusión

Con 2 aprobaciones, el **Tech Lead** pulsa **Squash and merge**. GitHub borra la rama remota automáticamente. Para tu siguiente tarea vuelves al paso 1.

---

## Quién revisa a quién

| Autor del PR | Revisor 1 (obligatorio) | Revisor 2 |
| --- | --- | --- |
| Samuel (datos) | Omar (Tech Lead) | Erick |
| Erick (dominio) | Omar (Tech Lead) | Alejandro |
| Gabriel (widgets) | Omar (Tech Lead) | Alejandro |
| Alejandro (estado y páginas) | Omar (Tech Lead) | Gabriel |
| Omar (release y README) | Samuel | Erick |

**Qué revisar en un PR:** que la base sea `develop`, que solo toque archivos de su dueño, que el CI esté en verde, que los nombres de clases coincidan con los que usan las otras capas, y que no haya contraseñas ni URLs de Neon en el código.

---

## Qué hace cada persona en cada fase

El número de **Orden** es el orden en que se fusionan los PR. Si un PR importa archivos de otro, el otro debe estar fusionado primero.

### Fase 1 · Infraestructura, Neon y dominio → tag `v0.1.0`

| Orden | Quién | Rama | Entrega |
| --- | --- | --- | --- |
| 0 | Omar | commit inicial (antes de proteger las ramas) | Proyecto Flutter (Android + Web), encarpetado, dependencias, `analysis_options.yaml`, CI, plantilla de PR, este README. Crea `main` y `develop` y activa la protección |
| 1 | Samuel | `feature/neon-datasource` | `database/schema.sql`: tablas `usuarios`, `categorias` y `eventos` con llaves foráneas, `NOT NULL`, `CHECK` y `TIMESTAMP`, más datos iniciales |
| 2 | Erick | `feature/domain-layer` | `failures.dart`, entidades `Evento` y `Categoria`, contrato `AgendaRepository`, casos de uso (`CrearEvento`, `ActualizarEvento`, `EliminarEvento`, `ListarEventos`, `ObtenerCategorias`), `FakeAgendaRepository` y pruebas unitarias |
| 3 | Gabriel | `feature/ui-components` | `app_theme.dart`, `formatters.dart`, `validators.dart`, `CustomInput`, `EmptyState` |
| — | Alejandro | (sin PR) | Revisa los PR de Erick y Gabriel; empieza en local los eventos y estados del Bloc |
| 4 | Omar | `release/v0.1.0` | Ejecuta `schema.sql` en Neon, prueba, PR a `main`, tag `v0.1.0` |

### Fase 2 · Capa de datos e integración con Neon → tag `v0.2.0`

| Orden | Quién | Rama | Entrega |
| --- | --- | --- | --- |
| 1 | Samuel | `feature/neon-datasource` (recreada) | API FastAPI en `api/`, `exceptions.dart`, `api_constants.dart`, `dio_client.dart`, `EventoModel`, `CategoriaModel`, datasource remoto, `AgendaRepositoryImpl`, prueba del modelo, `tool/prueba_neon.dart` |
| 2 | Gabriel | `feature/ui-components` (recreada) | `EventCard`, `PrioridadChip`, `AgendaCalendar`, `FiltrosBar`, `DateTimeField` |
| 3 | Alejandro | `feature/presentation-logic` | `AgendaBloc` (eventos y estados) e `injection_container.dart` con `get_it` |
| 4 | Erick | `feature/domain-layer` (recreada) | Pruebas de `AgendaRepositoryImpl` |
| 5 | Omar | `release/v0.2.0` | Despliega la API en Render, corre `tool/prueba_neon.dart`, PR a `main`, tag `v0.2.0` |

### Fase 3 · Interfaz, estado y despliegue → tag `v1.0.0`

| Orden | Quién | Rama | Entrega |
| --- | --- | --- | --- |
| 1 | Alejandro | `feature/presentation-logic` (recreada) | `AgendaPage`, `EventoFormPage`, `main.dart` con `BlocProvider` |
| 2 | Gabriel | `feature/ui-components` (recreada) | Ajustes visuales tras ver las pantallas reales |
| 3 | Erick | `feature/domain-layer` (recreada) | Pruebas del `AgendaBloc` |
| 4 | Omar | `feature/docs-readme` | README final con los links de API y Web |
| 5 | Todos | `fix/*` desde `release/v1.0.0` | Corrección de los bugs encontrados al probar |
| 6 | Omar | `release/v1.0.0` | PR a `main`, tag `v1.0.0`, PR de vuelta a `develop`, APK y web publicados |

---

## Procedimiento de release (solo Tech Lead)

Se repite al final de cada fase cambiando el número (`v0.1.0`, `v0.2.0`, `v1.0.0`).

**1. Crear la rama release desde `develop` actualizado:**

```powershell
git checkout develop
```

```powershell
git pull origin develop
```

```powershell
git checkout -b release/v0.1.0
```

```powershell
git push -u origin release/v0.1.0
```

**2. Pruebas de integración en la rama release:** `flutter analyze`, `flutter test` y `flutter run`. Si aparece un bug, quien lo corrige crea `fix/descripcion` **desde `release/v0.1.0`** y abre el PR **hacia `release/v0.1.0`**, no hacia `develop`.

**3. PR `release/v0.1.0 → main`:** base `main`, 2 aprobaciones, fusionar con **Create a merge commit** (no squash).

**4. Etiquetar la versión en `main`:**

```powershell
git checkout main
```

```powershell
git pull origin main
```

```powershell
git tag -a v0.1.0 -m "Fase 1: infraestructura, Neon y dominio"
```

```powershell
git push origin v0.1.0
```

**5. Devolver arreglos a `develop`:** si la rama release recibió commits de `fix/*`, abre un PR `release/v0.1.0 → develop` con **Create a merge commit**. Si no tuvo cambios, este paso no hace falta.

**6. Solo en `v1.0.0`:** compilar y publicar.

```powershell
flutter build apk --release
```

```powershell
flutter build web --release
```

El APK queda en `build/app/outputs/flutter-apk/app-release.apk` y se adjunta en **Releases → Draft a new release → tag v1.0.0**. La carpeta `build/web` se sube a Netlify.

### Así debe verse `main` al final

```
*   Merge pull request: release/v1.0.0   (tag v1.0.0)
*   Merge pull request: release/v0.2.0   (tag v0.2.0)
*   Merge pull request: release/v0.1.0   (tag v0.1.0)
*   chore: estructura base Clean Architecture
```

---

## Configuración de GitHub (Tech Lead, una sola vez)

El repositorio debe ser **público**: en cuentas gratuitas la protección de ramas no se aplica a repos privados.

1. **Settings → Collaborators:** agregar a Samuel, Erick, Gabriel y Alejandro con permiso *Write*.
2. **Settings → General → Default branch:** `develop`.
3. **Settings → General → Pull Requests:** activar *Allow squash merging* y *Allow merge commits*; desactivar *Allow rebase merging*; activar *Automatically delete head branches*.
4. **Settings → Branches → Add classic branch protection rule**, una para `main` y otra para `develop`:
   - *Require a pull request before merging* → *Require approvals: 2*
   - *Dismiss stale pull request approvals when new commits are pushed*
   - *Require conversation resolution before merging*
   - *Do not allow bypassing the above settings*
   - Sin marcar: *Allow force pushes* y *Allow deletions*

---

## Arquitectura

```
lib/
├── core/
│   ├── constants/        # URL de la API
│   ├── errors/           # exceptions.dart (data) y failures.dart (dominio)
│   ├── network/          # Cliente Dio
│   ├── theme/            # ThemeData
│   └── utils/            # Formateadores de fecha, validadores
├── features/planner/
│   ├── data/             # Modelos JSON, datasource remoto, AgendaRepositoryImpl
│   ├── domain/           # Entidades, contrato AgendaRepository, casos de uso (Dart puro)
│   └── presentation/     # Bloc, páginas y widgets
├── injection_container.dart   # get_it
└── main.dart
api/        # FastAPI: única pieza que conoce la cadena de conexión de Neon
database/   # schema.sql
tool/       # prueba_neon.dart (prueba real de lectura y escritura)
```

Flujo de un clic: botón → evento del Bloc → caso de uso → repositorio → datasource (Dio) → API → Neon → nuevo estado → SnackBar.

## Cómo correr el proyecto

```powershell
flutter pub get
```

```powershell
flutter run
```

```powershell
flutter test
```

Para usar una API local desde el emulador Android: `flutter run --dart-define=API_URL=http://10.0.2.2:8000`.

---

## Problemas frecuentes de Git

| Situación | Qué hacer |
| --- | --- |
| `git push` a `develop` o `main` es rechazado | Es correcto: trabaja en tu `feature/*` y abre un PR |
| Hice commits en `develop` local por error | `git checkout -b feature/MI-RAMA` (se lleva los commits), luego `git checkout develop` y `git reset --hard origin/develop` |
| Mi PR muestra cambios que ya estaban fusionados | Reusaste la rama tras un squash: crea una rama nueva desde `develop` y copia solo tus cambios nuevos |
| Conflicto en `pubspec.yaml` | Solo el Tech Lead edita ese archivo: descarta tu cambio y pídeselo a él |
| Abrí el PR contra `main` | En el PR pulsa **Edit** junto al título y cambia la base a `develop` |
| Subí la cadena de conexión de Neon por error | Avisa al Tech Lead de inmediato para cambiar la contraseña en Neon; borrarla del código no basta porque queda en el historial |
| `Because gestor_agenda requires SDK version ^3.13...` | Tu Flutter está desactualizado: `flutter upgrade` |

## Versiones

| Tag | Contenido |
| --- | --- |
| `v0.1.0` | Esquema SQL en Neon y capa de dominio con pruebas unitarias |
| `v0.2.0` | API, capa de datos e inyección de dependencias; lectura y escritura reales en Neon |
| `v1.0.0` | Interfaz completa, gestión de estado, APK y web publicados |
