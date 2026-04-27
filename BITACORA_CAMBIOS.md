# Bitácora de Cambios - Entorno de Prueba

## Fecha: 27/04/2026

---

### Cambio #1 - Bugfix: Horarios con disponibilidad 0

**Archivo modificado:** `server.js`

**Problema:** 
El operador `||` convertía valores `0` en `4`, lo que permitía asignar partidos a horarios con Canchas=0 como si tuvieran 4 canchas disponibles.

**Cambios realizados:**

| Línea | Antes | Después |
|-------|-------|---------|
| 902 | `parseInt(h.Canchas) \|\| 4` | `parseInt(h.Canchas) ?? 4` |
| 758 | `horarios.find(h => h.id === id)?.cupo \|\| 4` | `horarios.find(h => h.id === id)?.cupo ?? 4` |

**Explicación:**
El operador `??` (nullish coalescing) solo usa el valor por defecto (4) cuando el valor es `null` o `undefined`, pero no cuando es `0`. Ahora:
- `Canchas = 0` → `cupo = 0` (el horario queda disponible pero no se usa para partidos)
- `Canchas = null` → `cupo = 4` (default)
- `Canchas = 3` → `cupo = 3` (funciona normalmente)

---

### Notas

- Este cambio afecta solo al algoritmo de armado de grupos
- Los horarios con Canchas=0 aparecen en la disponibilidad del jugador pero no se usan para asignar partidos
- No rompe ninguna funcionalidad existente (si `cupo = 0`, la condición `uso <cupo` siempre es falsa)

---

### Cambio #2 - Nueva funcionalidad: Segunda leyenda en Agenda de Playoffs

**Archivos modificados:** `server.js`, `admin-datos.html`, `ver-grupos-partidos.js`, `editar-grupos.js`

**Problema:**
La agenda de playoffs solo tenía un campo de "leyenda" para identificar cada reserva. El usuario necesitaba dos campos para mostrar información más completa (ej: "Cuartos de final 1 - Cancha 1").

**Requisito previo:**
- Base de datos: Se agregó columna `leyendados VARCHAR(150)` a la tabla `agenda_playoffs` (realizado por el usuario)

**Cambios realizados:**

| Archivo | Cambio |
|---------|--------|
| **server.js** | Agregado `a.leyendados` en 2 SELECTs (GET público y GET admin), en INSERT y en UPDATE |
| **admin-datos.html** | Input adicional para leyendados, muestra ambas leyendas separadas por " - ", edición con dos prompt |
| **ver-grupos-partidos.js** | Ambas leyendas se muestran unidas por " - " |
| **editar-grupos.js** | Ambas leyendas se muestran unidas por " - " |

**Explicación:**
- El nuevo campo `leyendados` es opcional
- Cuando se muestra, las dos leyendas se unen con " - " (ej: "Cuartos de final 1 - Cancha 1")
- Si solo hay una leyenda, se muestra normalmente
- La edición permite actualizar o borrar la segunda leyenda (envía `null` para borrar)

**Corrección posterior (27/04/2026):**
- En `ver-grupos-partidos.js` y `editar-grupos.js`: Ahora se muestra **izquierda = leyenda1**, **derecha = leyendados** (antes ambas eran iguales)
- En `admin-datos.html` se mantiene el formato original (ambas juntas)

---

### Cambio #3 - Mejora: Día de la semana automático en creación de horarios de playoffs

**Archivo modificado:** `llave-eliminacion.html`

**Problema:**
Al crear horarios de playoffs, el usuario debía seleccionar manualmente el día de la semana y la fecha por separado. Esto podía generar inconsistencias visuales (ej: seleccionar "Martes" con fecha que caía en "Lunes").

**Cambios realizados:**

| Cambio | Descripción |
|--------|-------------|
| HTML | Eliminado el select `horario-dia` (selección manual del día) |
| JS | Agregada función `getDiaSemana(fecha)` que calcula el día automáticamente |
| JS | Modificada función `crearHorario()` para usar el día calculado automáticamente |

**Explicación:**
- Ahora el usuario solo selecciona la fecha
- El día de la semana se calcula automáticamente usando JavaScript
- Se usa el mismo algoritmo que en `gestionar-horarios.html` para mantener consistencia
- El agrupamiento de partidos funciona por fecha+hora, por lo que este cambio no afecta la lógica de asignación

---

### Cambio #4 - Gestionar horarios: edición inline y permitir Canchas=0

**Archivos modificados:** `server.js`, `gestionar-horarios.html`

**Problema:**
1. No se podían crear horarios con Canchas=0 (el input tenía min="1")
2. No había forma de editar un horario existente (solo eliminar si no estaba en uso)

**Cambios realizados:**

| Archivo | Cambio |
|---------|--------|
| **server.js** | Agregado PUT `/api/horarios/:id` para editar Canchas y lugar |
| **server.js** | Agregado campo `puede_editar` en GET horarios-admin |
| **gestionar-horarios.html** | Input canchas: min="1" → min="0" |
| **gestionar-horarios.html** | Tabla: celdas de Canchas y Lugar editables con double-click |
| **gestionar-horarios.html** | Estilos CSS para celdas editables (verde al hover) |

**Explicación:**
- Ahora se pueden crear horarios con 0 canchas (para bloquear ese horario)
- Double-click en celda de Canchas o Lugar abre prompt para editar
- Todos los horarios son editables (sin importar si están en uso)
- La edición solo permite cambiar Canchas y lugar, no fecha ni hora

**Cambio adicional (27/04/2026):**
- Se eliminó la restricción `puede_editar` - antes solo los horarios sin uso eran editables, ahora todos son editables

---

### Cambio #5 - Mejora: Agregar acceso a Gestionar Horarios cuando no hay grupos

**Archivo modificado:** `editar-grupos.html`

**Problema:**
Cuando no había grupos generados, el menú completo se ocultaba y solo aparecía un mensaje de advertencia con botón para ir a generar grupos. El usuario no podía acceder a "Gestionar Horarios" sin antes generar grupos.

**Cambio realizado:**
- En el mensaje de advertencia (cuando no hay grupos), se agregaron dos botones:
  - "🚀 Ir a Generar Grupos" (ya existía)
  - "📅 Gestionar Horarios" (nuevo)
- Ahora el usuario puede gestionar horarios aunque no haya generado grupos todavía

---

*Bitácora actualizada el 27/04/2026*