import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/pages/auth/login.page.dart';
import 'package:app_guias/presentation/pages/guias/new.guide.page.dart';
import 'package:app_guias/presentation/pages/usuarios/lista.usuarios.page.dart';
import 'package:app_guias/presentation/pages/historial/historial.page.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.card.dart';
import 'package:app_guias/presentation/widgets/custom.modal.dart';
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
            icon: const Icon(Icons.account_circle),
            tooltip: 'Información del usuario',
            onPressed: () {
              _mostrarInformacionUsuario(context, authProvider);
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

  void _mostrarInformacionUsuario(
      BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomModal(
          title: 'Información de Usuario',
          showCloseIcon: false,
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.15),
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.withOpacity(0.05),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('Usuario:', authProvider.username ?? 'N/A'),
                      Divider(height: 10, color: Colors.grey.withOpacity(0.2)),
                      _buildInfoRow('Rol:', authProvider.role ?? 'N/A'),
                      Divider(height: 10, color: Colors.grey.withOpacity(0.2)),
                      _buildInfoRow('ID:', authProvider.userId ?? 'N/A'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Cerrar Sesión',
                  onPressed: () async {
                    // Cerrar este modal
                    Navigator.pop(dialogContext);

                    // Mostrar confirmación
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

                      // Mostrar indicador de carga
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
                            content:
                                Text('Error al cerrar sesión: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  isOutlined: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _guideFlowController.dispose();
    super.dispose();
  }
}
