import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/pages/auth/login.page.dart';
import 'package:app_guias/presentation/pages/guias/new.guide.page.dart';
import 'package:app_guias/presentation/pages/usuarios/lista.usuarios.page.dart';
import 'package:app_guias/presentation/pages/historial/historial.page.dart';
import 'package:app_guias/presentation/widgets/custom.card.dart';
import 'package:app_guias/presentation/widgets/modals/confirmacion.modal.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late GuideFlowController _guideFlowController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    try {
      _guideFlowController = GuideFlowController.create();

      await _guideFlowController.llegadaController.init();
      await _guideFlowController.partidaController.init();
      await _guideFlowController.destinatarioController.init();
      await _guideFlowController.transporteController.init();
      await _guideFlowController.transportistaController.init();
      await _guideFlowController.detalleCargaController.init();
      await _guideFlowController.motivoTrasladoController.init();
      await _guideFlowController.usoInternoController.init();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al cargar los datos iniciales'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isAdmin = authProvider.role == 'ADMINISTRADOR';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final shouldLogout = await ConfirmacionModal.show(
                context,
                title: 'Cerrar sesión',
                message: '¿Estás seguro de que deseas cerrar sesión?',
                primaryButtonText: 'Aceptar',
              );

              if (shouldLogout == true) {
                if (!mounted) return;
                final context = this.context;
                if (!context.mounted) return;
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                try {
                  final success = await authProvider.logout();
                  if (!mounted) return;
                  final context = this.context;
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  if (success) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error al cerrar sesión'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  if (!mounted) return;
                  final context = this.context;
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al cerrar sesión: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomCard(
              title: 'Nueva guía de remisión',
              backgroundColor: AppColors.primary,
              titleColor: AppColors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewGuidePage(
                      guideFlowController: _guideFlowController,
                    ),
                  ),
                );
              },
            ),
            CustomCard(
              title: 'Historial guías',
              titleColor: AppColors.white,
              backgroundColor: AppColors.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistorialPage(),
                  ),
                );
              },
            ),
            if (isAdmin) ...[
              CustomCard(
                title: 'Administrar usuarios',
                titleColor: AppColors.white,
                backgroundColor: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListaUsuariosPage(),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _guideFlowController.dispose();
    super.dispose();
  }
}
