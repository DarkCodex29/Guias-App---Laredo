import 'package:flutter/material.dart';
import '../../../providers/auth.provider.dart';
import '../../controllers/usuarios/lista.usuarios.controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app.colors.dart';
import 'registro.usuario.modal.dart';
import '../../../providers/usuario.provider.dart';
import '../../widgets/modals/confirmacion.modal.dart';
import '../../widgets/custom.card.dart';
import '../../../services/log/logger.service.dart';

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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

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
      body: isDesktop
          ? _buildDesktopLayout(controller)
          : _buildMobileLayout(controller),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          LoggerService.info('Iniciando proceso de registro de usuario');
          showDialog(
            context: context,
            builder: (context) => RegistroUsuarioModal(
              onSubmit: (userData) async {
                LoggerService.info(
                    'Datos del formulario recibidos, procesando registro...');

                // Mostrar modal de procesando
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                try {
                  LoggerService.info('Llamando a registrarUsuario...');
                  final success = await controller.registrarUsuario(userData);
                  LoggerService.info('Respuesta de registrarUsuario: $success');

                  if (context.mounted) {
                    // Cerrar el modal de procesando
                    Navigator.of(context).pop();

                    if (success) {
                      LoggerService.info(
                          'Registro exitoso, mostrando confirmación...');
                      // No necesitamos mostrar el modal de confirmación aquí ya que el RegistroUsuarioModal lo maneja
                      await controller.cargarUsuarios();
                    }
                  }
                } catch (e) {
                  LoggerService.error('Error inesperado: $e');
                  if (context.mounted) {
                    // Asegurar que el modal de procesando se cierre
                    Navigator.of(context).pop();
                  }
                }
              },
              onSuccess: () async {
                LoggerService.info(
                    'Callback onSuccess llamado, actualizando lista...');
                await controller.cargarUsuarios();
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget _buildMobileLayout(ListaUsuariosController controller) {
    return RefreshIndicator(
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
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                  child: _buildUserList(controller),
                ),
                if (controller.totalPages > 1) _buildPagination(controller),
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
    );
  }

  Widget _buildDesktopLayout(ListaUsuariosController controller) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: RefreshIndicator(
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
                        child: _buildUserList(controller),
                      ),
                      if (controller.totalPages > 1)
                        _buildPagination(controller),
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: AppColors.primary.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gestión de Usuarios',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Aquí puedes gestionar todos los usuarios del sistema. Puedes crear nuevos usuarios, editar los existentes o eliminar usuarios que ya no sean necesarios.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Acciones disponibles:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildActionItem(
                    Icons.add,
                    'Crear usuario',
                    'Agrega un nuevo usuario al sistema',
                  ),
                  const SizedBox(height: 12),
                  _buildActionItem(
                    Icons.edit,
                    'Editar usuario',
                    'Modifica la información de un usuario existente',
                  ),
                  const SizedBox(height: 12),
                  _buildActionItem(
                    Icons.delete,
                    'Eliminar usuario',
                    'Elimina un usuario del sistema',
                  ),
                  const SizedBox(height: 12),
                  _buildActionItem(
                    Icons.upload_file,
                    'Carga masiva',
                    'Importa múltiples usuarios desde un archivo CSV',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserList(ListaUsuariosController controller) {
    if (controller.isLoading && controller.usuarios.isEmpty) {
      return const Center(
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
      );
    }

    if (controller.usuarios.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off, size: 64, color: Colors.grey),
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
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: controller.usuarios.length,
      itemBuilder: (context, index) {
        final usuario = controller.usuarios[index];
        return CustomCard(
          title: usuario.username,
          subtitleWidgets: [
            Row(
              children: [
                const Icon(Icons.person_outline, size: 14, color: Colors.grey),
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
                    color: usuario.rol == 'ADMINISTRADOR'
                        ? Colors.blue[50]
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: usuario.rol == 'ADMINISTRADOR'
                          ? Colors.blue[200]!
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        usuario.rol == 'ADMINISTRADOR'
                            ? Icons.admin_panel_settings
                            : Icons.person,
                        size: 12,
                        color: usuario.rol == 'ADMINISTRADOR'
                            ? Colors.blue[700]
                            : Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        usuario.rol == 'ADMINISTRADOR'
                            ? 'Administrador'
                            : 'Usuario',
                        style: TextStyle(
                          color: usuario.rol == 'ADMINISTRADOR'
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
                    borderRadius: BorderRadius.circular(12),
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
                        usuario.estado == '1' ? 'Activo' : 'Inactivo',
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
              icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'editar',
                  height: 40,
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: AppColors.primary, size: 18),
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
                      const Icon(Icons.delete, color: Colors.red, size: 18),
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
                    builder: (context) => RegistroUsuarioModal(
                      title: 'Editar usuario',
                      usuario: usuario,
                      onSubmit: (userData) async {
                        final success =
                            await controller.actualizarUsuario(userData);
                        if (success) {
                          await controller.cargarUsuarios();
                        } else if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(controller.errorMessage ??
                                  'Error al actualizar usuario'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      onSuccess: () async {
                        await controller.cargarUsuarios();
                      },
                    ),
                  );
                } else if (value == 'eliminar') {
                  LoggerService.info(
                      'Iniciando proceso de eliminación para usuario: ${usuario.username}');

                  final confirm = await ConfirmacionModal.show(
                    context,
                    title: 'Confirmar eliminación',
                    message:
                        '¿Está seguro que desea eliminar al usuario ${usuario.username}?\n\nEsta acción no se puede deshacer.',
                    primaryButtonText: 'Eliminar',
                    secondaryButtonText: 'Cancelar',
                  );

                  LoggerService.info('Respuesta de confirmación: $confirm');

                  if (confirm == true && context.mounted) {
                    LoggerService.info('Mostrando modal de procesando...');

                    // Mostrar el modal de procesando
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                    try {
                      LoggerService.info('Llamando a eliminarUsuario...');
                      final success = await controller.eliminarUsuario(usuario);
                      LoggerService.info(
                          'Respuesta de eliminarUsuario: $success');

                      if (context.mounted) {
                        // Cerrar el modal de procesando
                        Navigator.of(context).pop();

                        if (success) {
                          LoggerService.info(
                              'Eliminación exitosa, mostrando confirmación...');
                          await ConfirmacionModal.show(
                            context,
                            title: 'Usuario eliminado',
                            message:
                                'El usuario ha sido eliminado correctamente.',
                            primaryButtonText: 'Aceptar',
                          );
                          await controller.cargarUsuarios();
                        } else {
                          LoggerService.error(
                              'Error en eliminación, mostrando error...');
                          await ConfirmacionModal.show(
                            context,
                            title: 'Error',
                            message: controller.errorMessage ??
                                'Error al eliminar usuario',
                            primaryButtonText: 'Aceptar',
                          );
                        }
                      }
                    } catch (e) {
                      LoggerService.error('Error inesperado: $e');
                      if (context.mounted) {
                        // Asegurar que el modal de procesando se cierre
                        Navigator.of(context).pop();
                        await ConfirmacionModal.show(
                          context,
                          title: 'Error',
                          message: 'Ocurrió un error inesperado: $e',
                          primaryButtonText: 'Aceptar',
                        );
                      }
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPagination(ListaUsuariosController controller) {
    return Container(
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
            onPressed: controller.hasPrevious ? controller.previousPage : null,
            color:
                controller.hasPrevious ? AppColors.primary : Colors.grey[300],
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
            onPressed: controller.hasNext ? controller.nextPage : null,
            color: controller.hasNext ? AppColors.primary : Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
