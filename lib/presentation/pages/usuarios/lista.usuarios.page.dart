import 'package:flutter/material.dart';
import '../../../providers/auth.provider.dart';
import '../../controllers/usuarios/lista.usuarios.controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app.colors.dart';
import 'registro.usuario.modal.dart';
import '../../../providers/usuario.provider.dart';
import '../../widgets/modals/confirmacion.modal.dart';
import '../../widgets/custom.card.dart';

class ListaUsuariosPage extends StatelessWidget {
  const ListaUsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListaUsuariosController(
        context.read<AuthProvider>(),
        context.read<UsuarioProvider>(),
      ),
      child: const _ListaUsuariosView(),
    );
  }
}

class _ListaUsuariosView extends StatefulWidget {
  const _ListaUsuariosView();

  @override
  State<_ListaUsuariosView> createState() => _ListaUsuariosViewState();
}

class _ListaUsuariosViewState extends State<_ListaUsuariosView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListaUsuariosController>().cargarUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ListaUsuariosController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios',
            style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.white,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.isLoading ? null : controller.cargarUsuarios,
            color: AppColors.white,
          ),
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: controller.isLoading
                ? null
                : () async {
                    final success = await controller.cargarMasivaUsuarios();
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuarios cargados correctamente'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(controller.errorMessage ??
                              'Error al cargar usuarios'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
            color: AppColors.white,
            tooltip: 'Carga masiva de usuarios',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.cargarUsuarios(),
        child: Stack(
          children: [
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onChanged: controller.filtrarUsuarios,
                      decoration: InputDecoration(
                        hintText:
                            'Buscar por username, nombres, apellidos, email...',
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                  ),
                  Expanded(
                    child: controller.isLoading && controller.usuarios.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text(
                                  'Cargando usuarios...',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : controller.usuarios.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person_off,
                                        size: 64, color: Colors.grey),
                                    SizedBox(height: 16),
                                    Text(
                                      'No hay usuarios disponibles',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                itemCount: controller.usuarios.length,
                                itemBuilder: (context, index) {
                                  final usuario = controller.usuarios[index];
                                  return CustomCard(
                                    title: usuario.username,
                                    subtitleWidgets: [
                                      Row(
                                        children: [
                                          const Icon(Icons.email_outlined,
                                              size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              usuario.email,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_outline,
                                              size: 14, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              '${usuario.nombres} ${usuario.apellidos}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  usuario.rol == 'ADMINISTRADOR'
                                                      ? Colors.blue[50]
                                                      : Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: usuario.rol ==
                                                        'ADMINISTRADOR'
                                                    ? Colors.blue[200]!
                                                    : Colors.grey[300]!,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  usuario.rol == 'ADMINISTRADOR'
                                                      ? Icons
                                                          .admin_panel_settings
                                                      : Icons.person,
                                                  size: 12,
                                                  color: usuario.rol ==
                                                          'ADMINISTRADOR'
                                                      ? Colors.blue[700]
                                                      : Colors.grey[700],
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  usuario.rol == 'ADMINISTRADOR'
                                                      ? 'Administrador'
                                                      : 'Usuario',
                                                  style: TextStyle(
                                                    color: usuario.rol ==
                                                            'ADMINISTRADOR'
                                                        ? Colors.blue[700]
                                                        : Colors.grey[700],
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: usuario.estado == '1'
                                                  ? Colors.green[50]
                                                  : Colors.red[50],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: usuario.estado == '1'
                                                    ? Colors.green[200]!
                                                    : Colors.red[200]!,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  usuario.estado == '1'
                                                      ? Icons.check_circle
                                                      : Icons.cancel_outlined,
                                                  size: 12,
                                                  color: usuario.estado == '1'
                                                      ? Colors.green[700]
                                                      : Colors.red[700],
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  usuario.estado == '1'
                                                      ? 'Activo'
                                                      : 'Inactivo',
                                                  style: TextStyle(
                                                    color: usuario.estado == '1'
                                                        ? Colors.green[700]
                                                        : Colors.red[700],
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    trailing: [
                                      PopupMenuButton(
                                        color: AppColors.white,
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.more_vert,
                                            color: Colors.grey, size: 20),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 'editar',
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit,
                                                    color: AppColors.primary,
                                                    size: 18),
                                                const SizedBox(width: 8),
                                                const Text('Editar'),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'eliminar',
                                            height: 40,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.delete,
                                                    color: Colors.red,
                                                    size: 18),
                                                const SizedBox(width: 8),
                                                const Text('Eliminar'),
                                              ],
                                            ),
                                          ),
                                        ],
                                        onSelected: (value) async {
                                          if (value == 'editar') {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  RegistroUsuarioModal(
                                                title: 'Editar usuario',
                                                usuario: usuario,
                                                onSubmit: (userData) async {
                                                  final success =
                                                      await controller
                                                          .actualizarUsuario(
                                                              userData);
                                                  if (!success &&
                                                      context.mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(controller
                                                                .errorMessage ??
                                                            'Error al actualizar usuario'),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            );
                                          } else if (value == 'eliminar') {
                                            final confirm =
                                                await ConfirmacionModal.show(
                                              context,
                                              title: 'Confirmar eliminación',
                                              message:
                                                  '¿Desea eliminar al usuario ${usuario.username}?',
                                              primaryButtonText: 'Eliminar',
                                              secondaryButtonText: 'Cancelar',
                                            );

                                            if (confirm == true) {
                                              final success = await controller
                                                  .eliminarUsuario(usuario);
                                              if (!success && context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(controller
                                                            .errorMessage ??
                                                        'Error al eliminar usuario'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                  ),
                  if (controller.totalPages > 1)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: controller.hasPrevious
                                ? controller.previousPage
                                : null,
                            color: controller.hasPrevious
                                ? AppColors.primary
                                : Colors.grey[300],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Página ${controller.currentPage} de ${controller.totalPages}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed:
                                controller.hasNext ? controller.nextPage : null,
                            color: controller.hasNext
                                ? AppColors.primary
                                : Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (controller.isLoading)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => RegistroUsuarioModal(
              onSubmit: (userData) async {
                final success = await controller.registrarUsuario(userData);
                if (!success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(controller.errorMessage ??
                            'Error al registrar usuario')),
                  );
                }
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
