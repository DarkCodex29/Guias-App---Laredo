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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

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
          if (isDesktop) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Usuario: ${authProvider.username ?? "N/A"}',
                  style: const TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Rol: ${authProvider.role ?? "N/A"}',
                  style: const TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Información del usuario',
            onPressed: () {
              _mostrarInformacionUsuario(context, authProvider);
            },
          ),
        ],
      ),
      body: isDesktop
          ? _buildDesktopBody(authProvider, isAdmin)
          : _buildMobileBody(isAdmin),
    );
  }

  Widget _buildMobileBody(bool isAdmin) {
    return Padding(
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
    );
  }

  Widget _buildDesktopBody(AuthProvider authProvider, bool isAdmin) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Panel Principal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bienvenido, ${authProvider.username ?? "Usuario"}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.3,
                children: [
                  _buildDesktopCard(
                    'Historial guías',
                    Icons.history,
                    'Consulta el historial de guías generadas',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistorialPage(),
                        ),
                      );
                    },
                  ),
                  // if (isAdmin)
                  //   _buildDesktopCard(
                  //     'Administrar usuarios',
                  //     Icons.people,
                  //     'Gestiona los usuarios del sistema',
                  //     () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const ListaUsuariosPage(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopCard(
      String title, IconData icon, String description, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarInformacionUsuario(
      BuildContext context, AuthProvider authProvider) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomModal(
          title: 'Información de Usuario',
          showCloseIcon: true,
          width: isDesktop ? 450 : null,
          content: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : 8,
              vertical: isDesktop ? 16 : 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar con fondo
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: isDesktop ? 120 : 70,
                      height: isDesktop ? 120 : 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.15),
                      ),
                    ),
                    CircleAvatar(
                      radius: isDesktop ? 50 : 30,
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: isDesktop ? 60 : 36,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isDesktop ? 24 : 12),

                // Datos del usuario
                Container(
                  padding: EdgeInsets.all(isDesktop ? 20 : 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.05),
                    border: isDesktop
                        ? Border.all(
                            color: Colors.grey.withOpacity(0.1), width: 1)
                        : null,
                  ),
                  child: Column(
                    children: [
                      if (isDesktop)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            "Datos de la cuenta",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      _buildInfoRow(
                        'Usuario:',
                        authProvider.username ?? 'N/A',
                        isDesktop: isDesktop,
                      ),
                      Divider(
                          height: isDesktop ? 20 : 10,
                          color: Colors.grey.withOpacity(0.2)),
                      _buildInfoRow(
                        'Rol:',
                        authProvider.role ?? 'N/A',
                        isDesktop: isDesktop,
                      ),
                      Divider(
                          height: isDesktop ? 20 : 10,
                          color: Colors.grey.withOpacity(0.2)),
                      _buildInfoRow(
                        'ID:',
                        authProvider.userId ?? 'N/A',
                        isDesktop: isDesktop,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isDesktop ? 24 : 16),

                // Botón de cerrar sesión
                SizedBox(
                  width: isDesktop ? 200 : double.infinity,
                  height: isDesktop ? 48 : null,
                  child: CustomButton(
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
                              content: Text(
                                  'Error al cerrar sesión: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    isOutlined: false,
                  ),
                ),

                if (isDesktop) ...[
                  const SizedBox(height: 16),
                  Text(
                    "Sistema de Guías v1.0",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isDesktop = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 8.0 : 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isDesktop ? 15 : 13,
              color: isDesktop ? AppColors.primary : AppColors.greyText,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isDesktop ? 15 : 13,
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
