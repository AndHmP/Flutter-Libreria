import 'package:flutter/material.dart';
import 'package:flutter_ui_lib/flutter_ui_lib.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  static _DemoAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DemoAppState>();

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Lib Demo',
      theme: IntTema.light,
      darkTheme: IntTema.dark,
      themeMode: _themeMode,
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  int _gi_curpas = 1;
  bool _gb_swtval = true;
  bool _gb_swtsml = false;
  bool _gb_swtdis = true;
  bool _gb_chkval = false;
  bool _gb_chktwo = true;
  bool _gb_chkdis = false;
  String _gs_radval = 'option1';
  int _gi_crspag = 0;
  Set<String> _ge_chkgrp = {'email'};
  String? _gs_selpai;
  String? _gs_selciu;
  String? _gs_selrol;
  String _gs_otpcod = '';
  String _gs_nombre = '';
  String _gs_email = '';
  String _gs_passw = '';
  String _gs_passc = '';
  DateTime? _gd_fecha;
  bool _gb_terms = false;
  bool _gb_formsub = false;

  final _gl_trnods = [
    IntNodoArbol(
      id: '1',
      label: 'Documents',
      icon: Icons.folder_outlined,
      children: [
        IntNodoArbol(id: '1-1', label: 'Reports', children: [
          IntNodoArbol(id: '1-1-1', label: 'Q1 Report.pdf'),
          IntNodoArbol(id: '1-1-2', label: 'Q2 Report.pdf'),
        ]),
        IntNodoArbol(id: '1-2', label: 'Invoices', children: [
          IntNodoArbol(id: '1-2-1', label: 'Invoice-001.pdf'),
        ]),
      ],
    ),
    IntNodoArbol(
      id: '2',
      label: 'Images',
      icon: Icons.image_outlined,
      children: [
        IntNodoArbol(id: '2-1', label: 'photo_001.jpg'),
        IntNodoArbol(id: '2-2', label: 'photo_002.jpg'),
      ],
    ),
    IntNodoArbol(id: '3', label: 'README.md'),
  ];

  final _gl_tbldat = [
    {'name': 'Alice Johnson', 'role': 'Engineer', 'status': 'Active', 'joined': '2022-01-15'},
    {'name': 'Bob Martinez', 'role': 'Designer', 'status': 'Active', 'joined': '2021-08-03'},
    {'name': 'Carol White', 'role': 'PM', 'status': 'Away', 'joined': '2023-03-20'},
    {'name': 'David Lee', 'role': 'Engineer', 'status': 'Inactive', 'joined': '2020-11-11'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Library Demo'),
        actions: [
          Row(
            children: [
              Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                size: 20,
              ),
              const SizedBox(width: 4),
              Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (v) => DemoApp.of(context)?.toggleTheme(v),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(IntEspaciado.lg),
        children: [
          _section('Logos', _logos()),
          _section('Buttons', _buttons()),
          _section('Alerts & Toasts', _alerts()),
          _section('Password', _password()),
          _section('OTP / Verification Code', _otp()),
          _section('Dropdown', _dropdown()),
          _section('Checkboxes', _checkboxes()),
          _section('Switches', _switches()),
          _section('Form Inputs', _forms()),
          _section('Cards', _cards()),
          _section('Stepper (Cascade)', _stepper()),
          _section('Breadcrumb', _breadcrumb()),
          _section('Carousel', _carousel()),
          _section('Table', _table()),
          _section('TreeView', _treeview()),
        ],
      ),
    );
  }

  Widget _section(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: IntEspaciado.xl2, bottom: IntEspaciado.md),
          child: Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        content,
        const SizedBox(height: IntEspaciado.md),
      ],
    );
  }

  Widget _logos() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IntLogo(tipo: IntLogoTipo.supervisores, width: 120, height: 120),
                const SizedBox(height: IntEspaciado.sm),
                const Text('Supervisores', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              children: [
                IntLogo(tipo: IntLogoTipo.vendedores, width: 120, height: 120),
                const SizedBox(height: IntEspaciado.sm),
                const Text('Vendedores', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              children: [
                IntLogo(tipo: IntLogoTipo.transportistas, width: 120, height: 120),
                const SizedBox(height: IntEspaciado.sm),
                const Text('Transportistas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        const SizedBox(height: IntEspaciado.lg),
        // Versión grande
        IntLogo(tipo: IntLogoTipo.supervisores, width: 200, height: 200),
      ],
    );
  }

  Widget _buttons() {
    return Wrap(
      spacing: IntEspaciado.sm,
      runSpacing: IntEspaciado.sm,
      children: [
        IntBoton(label: 'Primary', onPressed: () {}),
        IntBoton(label: 'Outlined', variant: IntBotonVariante.outlined, onPressed: () {}),
        IntBoton(label: 'Ghost', variant: IntBotonVariante.ghost, onPressed: () {}),
        IntBoton(label: 'Loading', isLoading: true, onPressed: () {}),
        IntBoton(
          label: 'With Icon',
          leadingIcon: Icons.add,
          onPressed: () {},
        ),
        IntBoton(label: 'Disabled', onPressed: null),
        IntBoton(label: 'Danger', color: IntColores.error, onPressed: () {}),
        IntBoton(label: 'Small', size: IntBotonTamano.sm, onPressed: () {}),
        IntBoton(label: 'Large', size: IntBotonTamano.lg, onPressed: () {}),
        IntBotonIcono(icon: Icons.edit, onPressed: () {}, tooltip: 'Edit'),
        IntBotonIcono(
            icon: Icons.delete,
            color: IntColores.error,
            variant: IntBotonVariante.outlined,
            onPressed: () {}),
        IntBotonFab(icon: Icons.add, label: 'Create', onPressed: () {}),
      ],
    );
  }

  Widget _alerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: IntEspaciado.sm,
          children: [
            IntBoton(
              label: 'Success',
              color: IntColores.success,
              onPressed: () => IntSnackbar.success(context, 'Operation completed!'),
            ),
            IntBoton(
              label: 'Error',
              color: IntColores.error,
              onPressed: () => IntSnackbar.error(context, 'Something went wrong.'),
            ),
            IntBoton(
              label: 'Confirm Dialog',
              variant: IntBotonVariante.outlined,
              onPressed: () async {
                final ok = await IntDialogo.confirm(
                  context,
                  title: 'Delete item?',
                  message: 'This action cannot be undone.',
                  destructive: true,
                );
                if (ok == true && context.mounted) {
                  IntSnackbar.info(context, 'Item deleted');
                }
              },
            ),
            IntBoton(
              label: 'Bottom Sheet',
              variant: IntBotonVariante.outlined,
              onPressed: () => IntHojaInferior.show(
                context,
                title: 'Choose an option',
                child: Column(
                  children: List.generate(
                    4,
                    (i) => IntElementoLista(
                      title: 'Option ${i + 1}',
                      subtitle: 'Description for option ${i + 1}',
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: IntEspaciado.md),
        const IntBanner(
          type: IntTipoAlerta.info,
          title: 'Info',
          message: 'This is an inline informational banner.',
        ),
        const SizedBox(height: IntEspaciado.sm),
        const IntBanner(
          type: IntTipoAlerta.success,
          message: 'Your changes have been saved successfully.',
        ),
        const SizedBox(height: IntEspaciado.sm),
        const IntBanner(
          type: IntTipoAlerta.warning,
          title: 'Warning',
          message: 'Your subscription expires in 3 days.',
        ),
        const SizedBox(height: IntEspaciado.sm),
        const IntBanner(
          type: IntTipoAlerta.error,
          message: 'Failed to connect to the server.',
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      children: [
        IntCampoClave(
          label: 'Password',
          hint: 'Enter your password',
          onChanged: (v) => setState(() => _gs_passw = v),
          errorText: _gb_formsub && _gs_passw.isEmpty ? 'Password is required' : null,
        ),
        const SizedBox(height: IntEspaciado.md),
        IntCampoClave(
          label: 'Confirm password',
          hint: 'Min. 8 characters',
          showStrengthIndicator: true,
          onChanged: (v) => setState(() => _gs_passc = v),
          errorText: _gb_formsub && _gs_passc.isEmpty
              ? 'Confirm your password'
              : _gb_formsub && _gs_passc != _gs_passw && _gs_passc.isNotEmpty
                  ? 'Passwords do not match'
                  : null,
        ),
      ],
    );
  }

  Widget _otp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter the 6-digit code sent to your phone',
          style: TextStyle(fontSize: 13, color: IntColores.textSecondary),
        ),
        const SizedBox(height: IntEspaciado.md),
        IntCampoOtp(
          length: 6,
          autoFocus: false,
          onChanged: (code) => setState(() => _gs_otpcod = code),
          onCompleted: (code) {
            if (mounted) {
              IntSnackbar.success(context, 'Code entered: $code');
            }
          },
        ),
        const SizedBox(height: IntEspaciado.lg),
        const Text(
          '4-digit PIN (masked)',
          style: TextStyle(fontSize: 13, color: IntColores.textSecondary),
        ),
        const SizedBox(height: IntEspaciado.md),
        IntCampoOtp(
          length: 4,
          obscure: true,
          autoFocus: false,
          fieldWidth: 52,
          fieldHeight: 60,
        ),
      ],
    );
  }

  Widget _dropdown() {
    return Column(
      children: [
        IntDesplegable<String>(
          label: 'Country',
          items: const ['Peru', 'Colombia', 'Mexico', 'Argentina', 'Chile'],
          itemLabel: (s) => s,
          hint: 'Select country',
          prefixIcon: Icons.flag_outlined,
          value: _gs_selpai,
          onChanged: (v) => setState(() => _gs_selpai = v),
          errorText: _gb_formsub && _gs_selpai == null ? 'Select a country' : null,
        ),
        const SizedBox(height: IntEspaciado.md),
        IntDesplegable<String>(
          label: 'Role',
          items: const ['Admin', 'Editor', 'Viewer'],
          itemLabel: (s) => s,
          hint: 'Assign role',
          value: _gs_selrol,
          onChanged: (v) => setState(() => _gs_selrol = v),
          errorText: _gb_formsub && _gs_selrol == null ? 'Role is required' : null,
        ),
        const SizedBox(height: IntEspaciado.md),
        IntDesplegable<String>(
          label: 'Draggable Dropdown',
          items: const ['Lima', 'Bogotá', 'CDMX', 'Buenos Aires', 'Santiago', 'Quito'],
          itemLabel: (s) => s,
          hint: 'Presiona y arrastra el panel',
          draggable: true,
          value: _gs_selciu,
          onChanged: (v) => setState(() => _gs_selciu = v),
        ),
      ],
    );
  }

  Widget _checkboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntCasilla(
          value: _gb_chkval,
          onChanged: (v) => setState(() => _gb_chkval = v ?? false),
          label: 'I agree to the terms and conditions',
          description: 'Please read the full agreement before accepting.',
          errorText: _gb_formsub && !_gb_chkval ? 'You must accept the terms' : null,
        ),
        IntCasilla(
          value: _gb_chktwo,
          onChanged: (v) => setState(() => _gb_chktwo = v ?? false),
          label: 'Subscribe to newsletter',
          activeColor: IntColores.success,
        ),
        IntCasilla(
          value: _gb_chkdis,
          onChanged: (_) {},
          label: 'Disabled checkbox',
          enabled: false,
        ),
        const SizedBox(height: IntEspaciado.md),
        IntGrupoCasillas<String>(
          label: 'Notification preferences',
          options: const ['email', 'sms', 'push'],
          optionLabel: (s) => s == 'email' ? 'Email' : s == 'sms' ? 'SMS' : 'Push notifications',
          optionDescription: (s) => s == 'email'
              ? 'Receive updates via email'
              : s == 'sms'
                  ? 'Text message alerts'
                  : 'Mobile app notifications',
          values: _ge_chkgrp,
          onChanged: (v) => setState(() => _ge_chkgrp = v),
          errorText: _gb_formsub && _ge_chkgrp.isEmpty ? 'Select at least one option' : null,
        ),
      ],
    );
  }

  Widget _switches() {
    return Column(
      children: [
        IntInterruptor(
          value: _gb_swtval,
          onChanged: (v) => setState(() => _gb_swtval = v),
          label: 'Enable notifications',
          description: 'Receive alerts for new messages',
        ),
        const SizedBox(height: IntEspaciado.sm),
        IntInterruptor(
          value: _gb_swtsml,
          onChanged: (v) => setState(() => _gb_swtsml = v),
          label: 'Dark mode',
          size: IntInterruptorTamano.sm,
        ),
        const SizedBox(height: IntEspaciado.sm),
        IntInterruptor(
          value: _gb_swtdis,
          onChanged: (v) => setState(() => _gb_swtdis = v),
          label: 'Maintenance mode',
          description: 'Cannot be changed right now',
          enabled: false,
        ),
        const SizedBox(height: IntEspaciado.sm),
        IntInterruptor(
          value: _gb_swtval,
          onChanged: (v) => setState(() => _gb_swtval = v),
          label: 'Custom color switch',
          activeColor: IntColores.success,
        ),
      ],
    );
  }

  Widget _forms() {
    return Column(
      children: [
        IntCampoTexto(
          label: 'Full name',
          hint: 'Enter your name',
          prefixIcon: Icons.person_outline,
          onChanged: (v) => setState(() => _gs_nombre = v),
          errorText: _gb_formsub && _gs_nombre.isEmpty ? 'Name is required' : null,
        ),
        const SizedBox(height: IntEspaciado.md),
        IntCampoTexto(
          label: 'Email',
          hint: 'user@example.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          onChanged: (v) => setState(() => _gs_email = v),
          errorText: _gb_formsub && _gs_email.isEmpty
              ? 'Email is required'
              : _gb_formsub && _gs_email.isNotEmpty && !_gs_email.contains('@')
                  ? 'Enter a valid email'
                  : null,
        ),
        const SizedBox(height: IntEspaciado.md),
        const IntCampoBusqueda(hint: 'Search products...'),
        const SizedBox(height: IntEspaciado.md),
        IntGrupoRadio<String>(
          label: 'Billing cycle',
          options: const ['option1', 'option2', 'option3'],
          optionLabel: (s) => s == 'option1' ? 'Weekly' : s == 'option2' ? 'Monthly' : 'Yearly',
          value: _gs_radval,
          onChanged: (v) => setState(() => _gs_radval = v),
          direction: Axis.horizontal,
        ),
        const SizedBox(height: IntEspaciado.md),
        IntSelectorFecha(
          label: 'Date of birth',
          onDateSelected: (d) => setState(() => _gd_fecha = d),
          errorText: _gb_formsub && _gd_fecha == null ? 'Date is required' : null,
        ),
        const SizedBox(height: IntEspaciado.lg),
        IntCasilla(
          value: _gb_terms,
          onChanged: (v) => setState(() => _gb_terms = v ?? false),
          label: 'I accept the terms and conditions',
          errorText: _gb_formsub && !_gb_terms ? 'You must accept the terms' : null,
        ),
        const SizedBox(height: IntEspaciado.lg),
        IntBoton(
          label: 'Submit form',
          leadingIcon: Icons.check,
          isFullWidth: true,
          onPressed: () {
            setState(() => _gb_formsub = true);
            if (_gs_nombre.isNotEmpty &&
                _gs_email.contains('@') &&
                _gs_passw.isNotEmpty &&
                _gs_passc == _gs_passw &&
                _gs_selpai != null &&
                _gs_selrol != null &&
                _gd_fecha != null &&
                _gb_terms) {
              IntSnackbar.success(context, 'Form submitted successfully!');
              setState(() => _gb_formsub = false);
            }
          },
        ),
      ],
    );
  }

  Widget _cards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: IntTarjetaEstadisticas(
                label: 'Revenue',
                value: '\$48,295',
                change: '+12.5% this month',
                changePositive: true,
                icon: Icons.attach_money_rounded,
                iconColor: IntColores.success,
              ),
            ),
            const SizedBox(width: IntEspaciado.md),
            Expanded(
              child: IntTarjetaEstadisticas(
                label: 'Churn',
                value: '3.2%',
                change: '-0.4% vs last month',
                changePositive: false,
                icon: Icons.trending_down_rounded,
                iconColor: IntColores.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: IntEspaciado.md),
        IntTarjetaInfo(
          title: 'Project Alpha',
          subtitle: 'Engineering · 8 members',
          description: 'Redesign of the core checkout flow with improved A/B testing.',
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: IntColores.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.rocket_launch_outlined, color: IntColores.primary),
          ),
          badge: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: IntColores.successLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Active',
                style: TextStyle(fontSize: 11, color: IntColores.success, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: IntEspaciado.md),
        IntTarjetaAccion(
          title: 'Backup database',
          description: 'Last run 2 hours ago',
          icon: Icons.storage_rounded,
          iconColor: IntColores.secondary,
          actions: [
            IntBoton(label: 'Run now', size: IntBotonTamano.sm, onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Widget _stepper() {
    final steps = [
      const IntDatoPaso(title: 'Cart', icon: Icons.shopping_cart_outlined),
      const IntDatoPaso(title: 'Shipping', icon: Icons.local_shipping_outlined),
      const IntDatoPaso(title: 'Payment', icon: Icons.payment_outlined),
      const IntDatoPaso(title: 'Confirm', icon: Icons.check_circle_outline),
    ];

    return Column(
      children: [
        IntPasos(steps: steps, currentStep: _gi_curpas),
        const SizedBox(height: IntEspaciado.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntBoton(
              label: 'Back',
              variant: IntBotonVariante.outlined,
              onPressed: _gi_curpas > 0
                  ? () => setState(() => _gi_curpas--)
                  : null,
            ),
            const SizedBox(width: IntEspaciado.md),
            IntBoton(
              label: 'Next',
              onPressed: _gi_curpas < steps.length - 1
                  ? () => setState(() => _gi_curpas++)
                  : null,
              trailingIcon: Icons.arrow_forward_rounded,
            ),
          ],
        ),
      ],
    );
  }

  Widget _breadcrumb() {
    return IntMigaPan(
      items: [
        IntElementoMigaPan(label: 'Home', icon: Icons.home_outlined, onTap: () {}),
        IntElementoMigaPan(label: 'Products', onTap: () {}),
        IntElementoMigaPan(label: 'Electronics', onTap: () {}),
        const IntElementoMigaPan(label: 'Headphones'),
      ],
    );
  }

  Widget _carousel() {
    final colors = [
      IntColores.primary,
      IntColores.secondary,
      IntColores.success,
      IntColores.warning,
    ];
    final labels = ['Slide One', 'Slide Two', 'Slide Three', 'Slide Four'];

    return IntCarrusel<int>(
      items: List.generate(4, (i) => i),
      height: 160,
      autoPlay: true,
      onPageChanged: (i) => setState(() => _gi_crspag = i),
      itemBuilder: (ctx, index, i) => Container(
        decoration: BoxDecoration(
          color: colors[index],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            labels[index],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: IntColores.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _table() {
    final columns = [
      IntColumnaTabla<Map<String, String>>(
        key: 'name',
        label: 'NAME',
        sortable: true,
        cellBuilder: (row) => Text(
          row['name']!,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
      IntColumnaTabla<Map<String, String>>(
        key: 'role',
        label: 'ROLE',
        cellBuilder: (row) => Text(row['role']!,
            style: const TextStyle(fontSize: 13, color: IntColores.textSecondary)),
      ),
      IntColumnaTabla<Map<String, String>>(
        key: 'status',
        label: 'STATUS',
        cellBuilder: (row) {
          final status = row['status']!;
          final color = status == 'Active'
              ? IntColores.success
              : status == 'Away'
                  ? IntColores.warning
                  : IntColores.grey400;
          return Row(
            children: [
              Container(
                  width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text(status, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500)),
            ],
          );
        },
      ),
      IntColumnaTabla<Map<String, String>>(
        key: 'joined',
        label: 'JOINED',
        cellBuilder: (row) =>
            Text(row['joined']!, style: const TextStyle(fontSize: 13, color: IntColores.textSecondary)),
      ),
    ];

    return IntTablaOrdenable<Map<String, String>>(
      columns: columns,
      rows: _gl_tbldat,
      sortRow: (a, b, key, asc) {
        final result = (a[key] ?? '').compareTo(b[key] ?? '');
        return asc ? result : -result;
      },
    );
  }

  Widget _treeview() {
    return Container(
      padding: const EdgeInsets.all(IntEspaciado.md),
      decoration: BoxDecoration(
        border: Border.all(color: IntColores.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntVistaArbol(
        nodes: _gl_trnods,
        defaultExpandAll: false,
        showLines: true,
        onNodeSelected: (node) => IntSnackbar.info(context, 'Selected: ${node.label}'),
      ),
    );
  }
}
