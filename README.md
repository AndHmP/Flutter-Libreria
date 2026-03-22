# Flutter UI Lib — Inmobiler

Libreria completa de componentes UI para Flutter, lista para produccion.
Todos los componentes usan el prefijo `Int` (de Inmobiler). Soporta **modo claro y oscuro** de forma automatica.

---

## Tabla de contenidos

- [Instalacion](#instalacion)
- [Tema y colores](#tema-y-colores)
- [Componentes](#componentes)
  - [Logos](#logos)
  - [Botones](#botones)
  - [Formularios](#formularios)
  - [Tarjetas](#tarjetas)
  - [Listas](#listas)
  - [Tablas](#tablas)
  - [Alertas](#alertas)
  - [Modales y Dialogos](#modales-y-dialogos)
  - [Carrusel](#carrusel)
  - [Pasos y Miga de Pan](#pasos-y-miga-de-pan)
  - [Vista de Arbol](#vista-de-arbol)
- [Referencia de tokens](#referencia-de-tokens)
- [Referencia de parametros](#referencia-de-parametros)

---

## Instalacion

### Desde ruta local

```yaml
dependencies:
  flutter_ui_lib:
    path: ../flutter_ui_lib
```

### Desde Git (GitLab / GitHub)

```yaml
dependencies:
  flutter_ui_lib:
    git:
      url: https://gitlab.com/tu-usuario/flutter_ui_lib.git
      ref: main
```

### Configuracion del tema

```dart
import 'package:flutter_ui_lib/flutter_ui_lib.dart';

MaterialApp(
  theme: IntTema.light,
  darkTheme: IntTema.dark,
  themeMode: ThemeMode.system, // o ThemeMode.light / ThemeMode.dark
  home: MiApp(),
)
```

---

## Tema y colores

### Cambiar el color primario globalmente

Modifica las constantes en `int_colores.dart`:

```dart
static const Color primary      = Color(0xFFE91E63); // Tu color
static const Color primaryLight = Color(0xFFF48FB1);
static const Color primaryDark  = Color(0xFFC2185B);
```

Esto cambia automaticamente **todos** los componentes (inputs, botones, switches, etc.).

### Por tema — sobreescribir en el ThemeData

Ideal cuando 2 proyectos usan la misma libreria pero con colores diferentes:

```dart
MaterialApp(
  theme: IntTema.light.copyWith(
    colorScheme: IntTema.light.colorScheme.copyWith(
      primary: Color(0xFFE91E63),
    ),
    inputDecorationTheme: IntTema.light.inputDecorationTheme.copyWith(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(IntRadio.md),
        borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
      ),
    ),
  ),
);
```

### Por componente — usar `activeColor`

```dart
IntCasilla(value: v, onChanged: fn, activeColor: Colors.green);
IntInterruptor(value: v, onChanged: fn, activeColor: Colors.orange);
IntCampoOtp(activeColor: Colors.purple, length: 6);
```

---

## Componentes

---

### Logos

Logos SVG optimizados de la plataforma Inmobiler. Requiere `flutter_svg`.

```dart
// Logo de supervisores
IntLogo(tipo: IntLogoTipo.supervisores, width: 120)

// Logo de vendedores con alto fijo
IntLogo(tipo: IntLogoTipo.vendedores, height: 80)

// Logo de transportistas
IntLogo(tipo: IntLogoTipo.transportistas, width: 150)

// Con filtro de color personalizado
IntLogo(
  tipo: IntLogoTipo.supervisores,
  width: 100,
  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
)
```

**Resultado:** Muestra el logo SVG correspondiente con soporte para redimensionar y aplicar filtros de color.

---

### Botones

#### IntBoton — Boton principal

```dart
// Relleno (por defecto)
IntBoton(label: 'Guardar', onPressed: () {})

// Con tooltip y borde personalizado
IntBoton(
  label: 'Guardar',
  onPressed: () {},
  tooltip: 'Guardar cambios',
  borderRadius: 16,
)
```

#### Variantes

```dart
// Contorno
IntBoton(label: 'Cancelar', variant: IntBotonVariante.outlined, onPressed: () {})

// Ghost (transparente)
IntBoton(label: 'Saltar', variant: IntBotonVariante.ghost, onPressed: () {})
```

#### Con icono, estado de carga y long press

```dart
IntBoton(
  label: 'Enviar',
  leadingIcon: Icons.send,
  isLoading: _cargando,
  isFullWidth: true,
  onPressed: _enviar,
  onLongPress: _enviarConOpciones,
  focusNode: _focusBoton,
  autofocus: true,
)
```

#### Tamanos

```dart
IntBoton(label: 'Pequeno', size: IntBotonTamano.sm, onPressed: () {})
IntBoton(label: 'Mediano', size: IntBotonTamano.md, onPressed: () {})  // defecto
IntBoton(label: 'Grande',  size: IntBotonTamano.lg, onPressed: () {})
```

#### IntBotonIcono — Boton de icono

```dart
IntBotonIcono(icon: Icons.edit, onPressed: () {}, tooltip: 'Editar')

// Con color de fondo personalizado
IntBotonIcono(
  icon: Icons.delete,
  onPressed: _eliminar,
  onLongPress: _eliminarTodos,
  backgroundColor: Colors.red.shade50,
  focusNode: _focusIcono,
)
```

#### IntBotonFab — Boton flotante

```dart
IntBotonFab(
  icon: Icons.add,
  label: 'Nuevo',
  onPressed: () {},
  tooltip: 'Crear nuevo registro',
  heroTag: 'fab_nuevo',
  elevation: 6,
)
```

**Resultado:** Botones con animacion de carga, tooltip, variantes visuales (relleno, contorno, ghost), 3 tamanos, long press y soporte para focus.

---

### Formularios

#### IntCampoTexto — Campo de texto

```dart
// Basico
IntCampoTexto(
  label: 'Email',
  hint: 'usuario@ejemplo.com',
  prefixIcon: Icons.email_outlined,
  keyboardType: TextInputType.emailAddress,
)

// Con validacion y autovalidacion
IntCampoTexto(
  label: 'Nombre',
  hint: 'Tu nombre completo',
  validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  onSaved: (v) => _nombre = v,
  textCapitalization: TextCapitalization.words,
)

// Multilinea con minimo de lineas
IntCampoTexto(
  label: 'Descripcion',
  maxLines: 5,
  minLines: 3,
  textAlign: TextAlign.start,
  contentPadding: EdgeInsets.all(16),
)

// Solo lectura y deshabilitado
IntCampoTexto(label: 'ID', readOnly: true, controller: _idCtrl)
IntCampoTexto(label: 'Bloqueado', enabled: false)
```

#### IntCampoClave — Campo de contrasena

```dart
IntCampoClave(
  label: 'Contrasena',
  hint: 'Min. 8 caracteres',
  showStrengthIndicator: true,
  maxLength: 32,
  validator: (v) => v != null && v.length >= 8 ? null : 'Minimo 8 caracteres',
  onSaved: (v) => _password = v,
)
```

**Resultado:** Campo con toggle de visibilidad (ojo), indicador de fuerza con colores, validacion y limite de caracteres.

#### IntCampoOtp — Codigo de verificacion

```dart
// Codigo OTP de 6 digitos
IntCampoOtp(
  length: 6,
  onCompleted: (codigo) => verificar(codigo),
  onChanged: (valor) => print(valor),
)

// PIN enmascarado con bordes redondeados y espaciado
IntCampoOtp(
  length: 4,
  obscure: true,
  borderRadius: 12,
  spacing: 16,
)

// Deshabilitado / solo lectura
IntCampoOtp(length: 6, enabled: false)
IntCampoOtp(length: 6, readOnly: true)

// Con color personalizado
IntCampoOtp(length: 6, activeColor: Colors.purple)
```

**Resultado:** Inputs individuales por digito con auto-avance, soporte para pegar codigos, animacion al enfocar, y opcion de deshabilitar.

#### IntCampoBusqueda — Campo de busqueda

```dart
IntCampoBusqueda(
  hint: 'Buscar productos...',
  onChanged: (texto) => _filtrar(texto),
  focusNode: _focusBusqueda,
  enabled: true,
  readOnly: false,
)
```

#### IntDesplegable — Selector desplegable

```dart
// Basico con validacion
IntDesplegable<String>(
  label: 'Pais',
  items: ['Peru', 'Colombia', 'Mexico'],
  itemLabel: (s) => s,
  value: _pais,
  onChanged: (v) => setState(() => _pais = v),
  prefixIcon: Icons.flag_outlined,
  validator: (v) => v == null ? 'Selecciona un pais' : null,
)

// Solo lectura (muestra valor pero no permite cambiar)
IntDesplegable<String>(
  label: 'Pais asignado',
  items: ['Peru'],
  itemLabel: (s) => s,
  value: 'Peru',
  readOnly: true,
  onChanged: (_) {},
)

// Con objetos personalizados y busqueda
IntDesplegable<Usuario>(
  label: 'Responsable',
  items: _usuarios,
  itemLabel: (u) => u.nombre,
  value: _seleccionado,
  onChanged: (v) => setState(() => _seleccionado = v),
  searchable: true,
  focusNode: _focusDesplegable,
)
```

#### IntCasilla — Checkbox

```dart
// Con error de validacion
IntCasilla(
  value: _aceptado,
  label: 'Acepto los terminos y condiciones',
  onChanged: (v) => setState(() => _aceptado = v ?? false),
  errorText: !_aceptado ? 'Debes aceptar los terminos' : null,
)
```

#### IntGrupoCasillas — Grupo de checkboxes

```dart
IntGrupoCasillas<String>(
  label: 'Notificaciones',
  options: ['Email', 'SMS', 'Push'],
  optionLabel: (s) => s,
  values: _seleccionados,
  onChanged: (v) => setState(() => _seleccionados = v),
  enabled: true,
  errorText: _seleccionados.isEmpty ? 'Selecciona al menos uno' : null,
)
```

**Resultado:** Lista de checkboxes con titulo de grupo, validacion y opcion de deshabilitar todo el grupo.

#### IntGrupoRadio — Grupo de radio buttons

```dart
IntGrupoRadio<String>(
  label: 'Plan de pago',
  options: ['Semanal', 'Mensual', 'Anual'],
  optionLabel: (s) => s,
  value: _plan,
  onChanged: (v) => setState(() => _plan = v),
  enabled: true,
  errorText: _plan == null ? 'Selecciona un plan' : null,
)
```

**Resultado:** Lista de radio buttons con titulo, validacion y opcion de deshabilitar.

#### IntInterruptor — Switch

```dart
// Con focus y autofocus
IntInterruptor(
  value: _notificaciones,
  label: 'Notificaciones',
  onChanged: (v) => setState(() => _notificaciones = v),
  focusNode: _focusSwitch,
  autofocus: false,
)

// Tamano pequeno con color personalizado
IntInterruptor(
  value: _modoOscuro,
  label: 'Modo oscuro',
  size: IntInterruptorTamano.sm,
  activeColor: Colors.green,
  onChanged: (v) => setState(() => _modoOscuro = v),
)
```

#### IntSelectorFecha — Selector de fecha

```dart
// Con formato personalizado y validacion
IntSelectorFecha(
  label: 'Fecha de nacimiento',
  onDateSelected: (fecha) => setState(() => _fecha = fecha),
  dateFormat: 'dd/MM/yyyy',
  enabled: true,
  errorText: _fecha == null ? 'Selecciona una fecha' : null,
  validator: (v) => v == null || v.isEmpty ? 'Fecha requerida' : null,
  controller: _fechaCtrl,
)
```

**Resultado:** Campo con date picker, formato configurable, validacion y opcion de deshabilitar.

---

### Tarjetas

#### IntTarjeta — Tarjeta basica

```dart
// Basica
IntTarjeta(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Contenido'),
  ),
)

// Con gradiente y margen
IntTarjeta(
  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
  margin: EdgeInsets.all(8),
  clipBehavior: Clip.antiAlias,
  child: Text('Tarjeta con gradiente'),
)

// Sin sombra
IntTarjeta(child: Text('Plana'), elevation: 0)
```

#### IntTarjetaInfo — Tarjeta informativa

```dart
IntTarjetaInfo(
  title: 'Proyecto Alpha',
  subtitle: 'Ingenieria',
  description: 'Rediseno del flujo de checkout.',
  leading: Icon(Icons.rocket_launch),
  badge: Chip(label: Text('Activo')),
  elevation: 4,
  onLongPress: () => _verOpciones(),
  contentPadding: EdgeInsets.all(20),
)
```

#### IntTarjetaEstadisticas — Tarjeta de metricas

```dart
// Con prefijo/sufijo y estado de carga
IntTarjetaEstadisticas(
  label: 'Ingresos',
  value: '48,295',
  prefix: '\$',
  suffix: 'USD',
  change: '+12.5%',
  changePositive: true,
  icon: Icons.attach_money,
  iconColor: IntColores.success,
  isLoading: _cargandoDatos,
)
```

**Resultado:** Tarjeta con valor, prefijo/sufijo, estado de carga (shimmer), y porcentaje de cambio.

#### IntTarjetaAccion — Tarjeta con acciones

```dart
IntTarjetaAccion(
  title: 'Respaldo de BD',
  icon: Icons.storage,
  elevation: 2,
  enabled: _puedeRespaldar,
  actions: [
    IntBoton(label: 'Ejecutar', size: IntBotonTamano.sm, onPressed: () {}),
  ],
)
```

---

### Listas

#### IntElementoLista — Elemento de lista

```dart
// Con color de fondo y habilitado/deshabilitado
IntElementoLista(
  title: 'Juan Perez',
  subtitle: 'juan@ejemplo.com',
  leading: CircleAvatar(child: Text('JP')),
  trailing: Icon(Icons.chevron_right),
  onTap: () => _verDetalle(),
  enabled: true,
  tileColor: Colors.blue.shade50,
)

// Deshabilitado
IntElementoLista(
  title: 'Item bloqueado',
  enabled: false,
  onTap: () {},  // no se ejecutara
)
```

#### IntVistaLista — Lista con estados y pull-to-refresh

```dart
IntVistaLista<Usuario>(
  items: _usuarios,
  isLoading: _cargando,
  hasError: _hayError,
  controller: _scrollCtrl,
  scrollDirection: Axis.vertical,
  onRefresh: () async => await _recargarUsuarios(),
  errorBuilder: (ctx) => Center(child: Text('Error al cargar')),
  itemBuilder: (ctx, usuario, index) => IntElementoLista(
    title: usuario.nombre,
    subtitle: usuario.email,
    leading: CircleAvatar(child: Text(usuario.iniciales)),
    onTap: () => _verUsuario(usuario),
  ),
)
```

**Resultado:** Lista con pull-to-refresh, estados de carga/error/vacio, scroll programatico y direccion configurable.

#### IntElementoDeslizable — Elemento con swipe y confirmacion

```dart
IntElementoDeslizable(
  enabled: _puedeEliminar,
  confirmDismiss: (direction) async {
    return await IntDialogo.confirm(
      context,
      title: 'Eliminar?',
      message: 'Seguro que quieres eliminar este elemento?',
    );
  },
  onDismissed: () => _eliminar(item),
  child: IntElementoLista(
    title: 'Desliza para eliminar',
    subtitle: 'Pide confirmacion antes de eliminar',
  ),
)
```

**Resultado:** Swipe con confirmacion antes de eliminar, y opcion de deshabilitar el deslizamiento.

---

### Tablas

#### IntTabla — Tabla con seleccion y scroll horizontal

```dart
IntTabla<Map<String, String>>(
  columns: [
    IntColumnaTabla(
      key: 'nombre',
      label: 'NOMBRE',
      cellBuilder: (row) => Text(row['nombre']!),
    ),
    IntColumnaTabla(
      key: 'email',
      label: 'EMAIL',
      cellBuilder: (row) => Text(row['email']!),
    ),
    IntColumnaTabla(
      key: 'rol',
      label: 'ROL',
      cellBuilder: (row) => Chip(label: Text(row['rol']!)),
    ),
  ],
  rows: _datos,
  dense: true,                    // filas compactas
  horizontalScroll: true,         // scroll horizontal para tablas anchas
  selectable: true,               // checkboxes de seleccion por fila
  selectedRows: _filasSeleccionadas,
  onRowSelected: (index, selected) {
    setState(() {
      if (selected) _filasSeleccionadas.add(index);
      else _filasSeleccionadas.remove(index);
    });
  },
)
```

#### IntTablaOrdenable — Tabla con ordenamiento predeterminado

```dart
IntTablaOrdenable<Usuario>(
  columns: [
    IntColumnaTabla(
      key: 'nombre',
      label: 'NOMBRE',
      sortable: true,
      cellBuilder: (u) => Text(u.nombre),
    ),
    IntColumnaTabla(
      key: 'email',
      label: 'EMAIL',
      cellBuilder: (u) => Text(u.email),
    ),
  ],
  rows: _usuarios,
  defaultSortKey: 'nombre',       // ordenar por nombre al inicio
  defaultSortAscending: true,     // orden ascendente
  sortRow: (a, b, key, asc) {
    final r = a.nombre.compareTo(b.nombre);
    return asc ? r : -r;
  },
)
```

**Resultado:** Tablas con filas compactas, seleccion por checkbox, scroll horizontal, y ordenamiento predeterminado.

---

### Alertas

#### IntSnackbar — Notificacion inferior

```dart
IntSnackbar.success(context, 'Guardado correctamente!');
IntSnackbar.error(context, 'Ocurrio un error.');
IntSnackbar.warning(context, 'Tu sesion esta por expirar.');
IntSnackbar.info(context, 'Nuevo mensaje recibido.');
```

**Resultado:** Barra inferior con icono y color segun el tipo (verde, rojo, amarillo, azul).

#### IntBanner — Banner inline

```dart
IntBanner(
  type: IntTipoAlerta.warning,
  title: 'Aviso importante',
  message: 'Tu suscripcion vence en 3 dias.',
)
```

**Resultado:** Banner con borde lateral de color, icono, titulo y mensaje.

#### IntToast — Notificacion flotante

```dart
IntToast.show(
  context,
  message: 'Operacion completada!',
  type: IntTipoAlerta.success,
)
```

**Resultado:** Notificacion que aparece en la parte superior y desaparece automaticamente.

---

### Modales y Dialogos

#### IntDialogo — Dialogo personalizado

```dart
// Dialogo scrollable con padding personalizado
IntDialogo.show(
  context,
  title: 'Nuevo usuario',
  content: 'Completa el formulario.',
  scrollable: true,
  contentPadding: EdgeInsets.all(24),
  icon: Icons.person_add,
  actions: [
    IntBoton(
      label: 'Cancelar',
      variant: IntBotonVariante.ghost,
      onPressed: () => Navigator.pop(context),
    ),
    IntBoton(label: 'Crear', onPressed: _crearUsuario),
  ],
)
```

#### Dialogo de confirmacion

```dart
final confirmado = await IntDialogo.confirm(
  context,
  title: 'Eliminar registro?',
  message: 'Esta accion no se puede deshacer.',
  destructive: true,
);
if (confirmado == true) _eliminar();
```

#### IntHojaInferior — Bottom Sheet

```dart
IntHojaInferior.show(
  context,
  title: 'Opciones',
  backgroundColor: Colors.grey.shade50,
  onDismissed: () => print('Cerrado'),
  child: Column(
    children: [
      ListTile(title: Text('Opcion 1'), onTap: () {}),
      ListTile(title: Text('Opcion 2'), onTap: () {}),
    ],
  ),
)
```

#### IntMenuEmergente — Menu contextual

```dart
IntMenuEmergente<String>(
  enabled: true,
  elevation: 8,
  borderRadius: BorderRadius.circular(12),
  items: [
    IntElementoMenu(value: 'editar', label: 'Editar', icon: Icons.edit),
    IntElementoMenu(value: 'eliminar', label: 'Eliminar', icon: Icons.delete, destructive: true),
  ],
  onSelected: (v) => _ejecutarAccion(v),
  child: Icon(Icons.more_vert),
)
```

---

### Carrusel

```dart
IntCarrusel<String>(
  items: ['Slide 1', 'Slide 2', 'Slide 3', 'Slide 4'],
  height: 200,
  autoPlay: true,
  autoPlayDuration: Duration(seconds: 4),
  viewportFraction: 0.85,
  itemBuilder: (ctx, texto, index) => Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(child: Text(texto, style: TextStyle(fontSize: 22))),
  ),
)
```

**Resultado:** Carrusel con navegacion por:
- **Arrastrar/deslizar** con dedo o mouse (soportado en web)
- **Flechas** laterales (izquierda/derecha)
- **Puntos indicadores** clickeables en la parte inferior
- **Auto-play** opcional con duracion configurable

---

### Pasos y Miga de Pan

#### IntPasos — Stepper con botones y pasos completados

```dart
IntPasos(
  steps: [
    IntDatoPaso(title: 'Carrito'),
    IntDatoPaso(title: 'Envio'),
    IntDatoPaso(title: 'Pago'),
    IntDatoPaso(title: 'Confirmar'),
  ],
  currentStep: _pasoActual,
  completedSteps: {0, 1},        // pasos 0 y 1 muestran checkmark
  onStepTap: (i) => setState(() => _pasoActual = i),
  onStepContinue: () => setState(() => _pasoActual++),
  onStepCancel: () => setState(() => _pasoActual--),
)
```

**Resultado:** Stepper con circulos numerados, checkmarks en pasos completados, y botones Continuar/Atras.

#### IntMigaPan — Breadcrumb con truncado

```dart
IntMigaPan(
  maxItems: 4,  // si hay mas de 4, muestra "..." en el medio
  items: [
    IntElementoMigaPan(label: 'Inicio', icon: Icons.home, onTap: () => _irInicio()),
    IntElementoMigaPan(label: 'Categoria', onTap: () => _irCategoria()),
    IntElementoMigaPan(label: 'Subcategoria', onTap: () => _irSub()),
    IntElementoMigaPan(label: 'Producto', onTap: () => _irProducto()),
    IntElementoMigaPan(label: 'Detalle'),
  ],
)
```

**Resultado:** Breadcrumb con truncado automatico cuando hay muchos items.

---

### Vista de Arbol

```dart
IntVistaArbol(
  nodes: [
    IntNodoArbol(
      id: '1',
      label: 'Documentos',
      children: [
        IntNodoArbol(id: '1-1', label: 'Reportes', children: [
          IntNodoArbol(id: '1-1-1', label: 'Q1-2024.pdf'),
          IntNodoArbol(id: '1-1-2', label: 'Q2-2024.pdf'),
        ]),
        IntNodoArbol(id: '1-2', label: 'Contratos'),
      ],
    ),
  ],
  showLines: true,
  defaultExpandAll: false,
  searchFilter: _textoBusqueda,             // filtra nodos por texto
  expandIcon: Icons.add_box_outlined,       // icono para expandir
  collapseIcon: Icons.indeterminate_check_box_outlined,  // icono para colapsar
  scrollController: _treeScrollCtrl,
  onNodeSelected: (nodo) => print('Seleccionado: ${nodo.label}'),
)
```

**Resultado:** Arbol con busqueda/filtrado, iconos personalizables, scroll programatico y seleccion de nodos.

---

## Estructura del proyecto

```
lib/
├── flutter_ui_lib.dart              <- export principal
└── src/
    ├── int_tema/
    │   ├── int_tema.dart            <- ThemeData (claro + oscuro)
    │   ├── int_colores.dart         <- Paleta de colores
    │   ├── int_tipografia.dart      <- TextTheme
    │   └── int_espaciado.dart       <- Constantes de espaciado y radio
    ├── int_logos/
    │   └── int_logo.dart            <- IntLogo (SVG)
    ├── int_botones/
    │   └── int_boton.dart           <- IntBoton, IntBotonIcono, IntBotonFab
    ├── int_formularios/
    │   ├── int_campo_texto.dart     <- IntCampoTexto, IntCampoBusqueda,
    │   │                               IntCampoClave, IntDesplegable,
    │   │                               IntCasilla, IntGrupoCasillas,
    │   │                               IntGrupoRadio, IntInterruptor,
    │   │                               IntSelectorFecha
    │   └── int_campo_otp.dart       <- IntCampoOtp
    ├── int_tarjetas/
    │   └── int_tarjeta.dart         <- IntTarjeta, IntTarjetaInfo,
    │                                   IntTarjetaAccion, IntTarjetaEstadisticas
    ├── int_listas/
    │   └── int_elemento_lista.dart  <- IntElementoLista, IntVistaLista,
    │                                   IntElementoDeslizable
    ├── int_modales/
    │   └── int_dialogo.dart         <- IntDialogo, IntHojaInferior,
    │                                   IntMenuEmergente
    ├── int_alertas/
    │   └── int_snackbar.dart        <- IntSnackbar, IntBanner, IntToast
    ├── int_tablas/
    │   └── int_tabla.dart           <- IntTabla, IntTablaOrdenable
    ├── int_carrusel/
    │   └── int_carrusel.dart        <- IntCarrusel, IntPuntosIndicadores
    ├── int_cascada/
    │   └── int_pasos.dart           <- IntPasos, IntMigaPan
    └── int_vista_arbol/
        └── int_vista_arbol.dart     <- IntVistaArbol, IntNodoArbol
```

---

## Referencia de tokens

### Colores

| Token | Hex | Uso |
|-------|-----|-----|
| `IntColores.primary` | `#2563EB` | Color principal, botones, links |
| `IntColores.secondary` | `#7C3AED` | Color secundario, acentos |
| `IntColores.success` | `#16A34A` | Exito, confirmaciones |
| `IntColores.warning` | `#D97706` | Advertencias |
| `IntColores.error` | `#DC2626` | Errores, destructivo |
| `IntColores.textPrimary` | `#111827` | Texto principal |
| `IntColores.textSecondary` | `#6B7280` | Texto secundario |

### Espaciado

| Token | Valor | Uso comun |
|-------|-------|-----------|
| `IntEspaciado.xs` | 4px | Separacion minima |
| `IntEspaciado.sm` | 8px | Padding interno |
| `IntEspaciado.md` | 12px | Espaciado entre elementos |
| `IntEspaciado.lg` | 16px | Padding de contenedores |
| `IntEspaciado.xl` | 20px | Secciones |
| `IntEspaciado.xl2` | 24px | Separacion de bloques |
| `IntEspaciado.xl3` | 32px | Separacion de secciones |

### Radio de bordes

| Token | Valor |
|-------|-------|
| `IntRadio.sm` | 4px |
| `IntRadio.md` | 8px |
| `IntRadio.lg` | 12px |
| `IntRadio.xl` | 16px |
| `IntRadio.full` | 999px |

---

## Referencia de parametros

Tabla resumen de los parametros disponibles en cada componente:

| Componente | Parametros clave |
|------------|-----------------|
| **IntCampoTexto** | `controller`, `label`, `hint`, `helperText`, `errorText`, `prefixIcon`, `suffixIcon`, `obscureText`, `keyboardType`, `onChanged`, `onSubmitted`, `enabled`, `readOnly`, `maxLines`, `minLines`, `maxLength`, `inputFormatters`, `focusNode`, `autofocus`, `textInputAction`, `onTap`, `validator`, `onSaved`, `autovalidateMode`, `textAlign`, `textCapitalization`, `contentPadding` |
| **IntCampoBusqueda** | `controller`, `hint`, `onChanged`, `onSubmitted`, `onClear`, `autofocus`, `enabled`, `focusNode`, `readOnly` |
| **IntCampoClave** | `controller`, `label`, `hint`, `helperText`, `errorText`, `onChanged`, `onSubmitted`, `enabled`, `focusNode`, `autofocus`, `textInputAction`, `showStrengthIndicator`, `validator`, `onSaved`, `maxLength` |
| **IntCampoOtp** | `length`, `onCompleted`, `onChanged`, `obscure`, `autoFocus`, `fieldWidth`, `fieldHeight`, `activeColor`, `errorText`, `keyboardType`, `enabled`, `readOnly`, `borderRadius`, `spacing` |
| **IntDesplegable** | `items`, `itemLabel`, `value`, `onChanged`, `label`, `hint`, `errorText`, `enabled`, `prefixIcon`, `searchable`, `validator`, `focusNode`, `readOnly` |
| **IntCasilla** | `value`, `onChanged`, `label`, `description`, `activeColor`, `enabled`, `tristate`, `errorText` |
| **IntGrupoCasillas** | `options`, `optionLabel`, `values`, `onChanged`, `activeColor`, `direction`, `optionDescription`, `label`, `errorText`, `enabled` |
| **IntGrupoRadio** | `options`, `optionLabel`, `value`, `onChanged`, `direction`, `activeColor`, `label`, `errorText`, `enabled` |
| **IntInterruptor** | `value`, `onChanged`, `label`, `description`, `activeColor`, `enabled`, `size`, `focusNode`, `autofocus` |
| **IntSelectorFecha** | `initialDate`, `firstDate`, `lastDate`, `label`, `hint`, `onDateSelected`, `enabled`, `errorText`, `dateFormat`, `controller`, `validator` |
| **IntBoton** | `label`, `onPressed`, `size`, `variant`, `color`, `leadingIcon`, `trailingIcon`, `isLoading`, `isFullWidth`, `tooltip`, `onLongPress`, `focusNode`, `autofocus`, `borderRadius` |
| **IntBotonIcono** | `icon`, `onPressed`, `tooltip`, `color`, `size`, `variant`, `onLongPress`, `focusNode`, `backgroundColor` |
| **IntBotonFab** | `icon`, `label`, `onPressed`, `color`, `mini`, `tooltip`, `heroTag`, `elevation` |
| **IntTarjeta** | `child`, `padding`, `color`, `borderColor`, `elevation`, `onTap`, `borderRadius`, `margin`, `gradient`, `clipBehavior` |
| **IntTarjetaInfo** | `title`, `subtitle`, `description`, `leading`, `trailing`, `onTap`, `badge`, `footerActions`, `elevation`, `onLongPress`, `contentPadding` |
| **IntTarjetaEstadisticas** | `label`, `value`, `change`, `changePositive`, `icon`, `iconColor`, `onTap`, `prefix`, `suffix`, `isLoading` |
| **IntTarjetaAccion** | `title`, `description`, `icon`, `iconColor`, `actions`, `onTap`, `elevation`, `enabled` |
| **IntElementoLista** | `title`, `subtitle`, `leading`, `trailing`, `onTap`, `onLongPress`, `selected`, `showDivider`, `dense`, `enabled`, `tileColor` |
| **IntVistaLista** | `items`, `itemBuilder`, `emptyBuilder`, `loadingBuilder`, `isLoading`, `shrinkWrap`, `physics`, `padding`, `separatorBuilder`, `onRefresh`, `controller`, `scrollDirection`, `errorBuilder`, `hasError` |
| **IntElementoDeslizable** | `child`, `onDismissed`, `onEdit`, `dismissDirection`, `deleteBackground`, `editBackground`, `confirmDismiss`, `enabled` |
| **IntTabla** | `columns`, `rows`, `onRowTap`, `emptyMessage`, `isLoading`, `showBorder`, `stripedRows`, `stickyHeader`, `rowHeight`, `headerHeight`, `dense`, `selectable`, `selectedRows`, `onRowSelected`, `horizontalScroll` |
| **IntTablaOrdenable** | `columns`, `rows`, `sortRow`, `onRowTap`, `emptyMessage`, `isLoading`, `defaultSortKey`, `defaultSortAscending` |
| **IntDialogo** | `title`, `content`, `contentWidget`, `actions`, `icon`, `iconColor`, `maxWidth`, `scrollable`, `contentPadding` |
| **IntHojaInferior** | `child`, `title`, `showHandle`, `showCloseButton`, `padding`, `initialChildSize`, `minChildSize`, `maxChildSize`, `expand`, `backgroundColor`, `onDismissed` |
| **IntMenuEmergente** | `items`, `onSelected`, `child`, `tooltip`, `offset`, `enabled`, `elevation`, `borderRadius` |
| **IntCarrusel** | `items`, `itemBuilder`, `height`, `autoPlay`, `autoPlayDuration`, `showIndicator`, `showArrows`, `viewportFraction`, `onPageChanged`, `initialPage`, `infiniteScroll`, `itemSpacing` |
| **IntPasos** | `steps`, `currentStep`, `direction`, `activeColor`, `onStepTap`, `onStepContinue`, `onStepCancel`, `completedSteps` |
| **IntMigaPan** | `items`, `separator`, `activeColor`, `maxItems` |
| **IntVistaArbol** | `nodes`, `onNodeSelected`, `onNodeExpanded`, `activeColor`, `indent`, `showLines`, `multiSelect`, `defaultExpandAll`, `scrollController`, `searchFilter`, `expandIcon`, `collapseIcon` |

---

## Ejecutar el demo

```bash
cd example
flutter run -d chrome   # o -d edge
```

El demo incluye todos los componentes organizados por seccion con toggle de modo claro/oscuro.
