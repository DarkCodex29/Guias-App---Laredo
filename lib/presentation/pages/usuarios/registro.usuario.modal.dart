import 'package:flutter/material.dart';
import '../../widgets/custom.modal.dart';
import '../../widgets/custom.textfield.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/presentation/controllers/usuarios/registro.usuario.controller.dart';
import 'package:app_guias/presentation/widgets/modals/confirmacion.modal.dart';

class RegistroUsuarioModal extends StatelessWidget {
  final Function(Map<String, String>) onSubmit;
  final String title;
  final dynamic usuario;

  const RegistroUsuarioModal({
    super.key,
    required this.onSubmit,
    this.title = 'Registro de usuario',
    this.usuario,
  });

  Future<void> _handleSubmit(
      BuildContext context, RegistroUsuarioController controller) async {
    // Validar el formulario
    if (controller.formKey.currentState!.validate()) {
      final bool isUpdate = usuario != null;

      // 1. Iniciar la operación y obtener respuesta
      bool success;

      // Guardar los providers que necesitamos antes de operaciones asíncronas
      controller.prepareProviders(context);

      try {
        success =
            isUpdate ? await controller.update() : await controller.register();
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
        return;
      }

      // 2. Verificar si el widget sigue montado
      if (!context.mounted) return;

      // 3. Mostrar confirmación si fue exitoso
      if (success) {
        await ConfirmacionModal.show(
          context,
          title: 'Éxito',
          message: isUpdate
              ? 'Usuario actualizado correctamente'
              : 'Usuario registrado correctamente',
          primaryButtonText: 'Aceptar',
        );

        // 4. Verificar nuevamente si el widget sigue montado
        if (!context.mounted) return;

        // 5. Enviar datos y cerrar modal
        onSubmit({
          'id': usuario?.id?.toString() ?? '0',
          'username': controller.usernameController.text.trim(),
          'password': controller.passwordController.text.isEmpty && isUpdate
              ? usuario.contrasena
              : controller.passwordController.text,
          'email': controller.emailController.text.trim(),
          'names': controller.nombresController.text.trim(),
          'surnames': controller.apellidosController.text.trim(),
          'role': controller.roleController.text == 'Usuario'
              ? 'USUARIO'
              : 'ADMINISTRADOR',
          'fechaCreacion': usuario?.fechaCreacion?.toIso8601String() ??
              DateTime.now().toIso8601String(),
        });
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistroUsuarioController(usuario: usuario),
      child: Builder(
        builder: (context) {
          final controller = context.watch<RegistroUsuarioController>();
          final size = MediaQuery.of(context).size;
          final isDesktop = size.width > 600;
          final double modalWidth =
              isDesktop ? 500 : size.width * 0.9; // Ancho fijo para desktop

          return CustomModal(
            title: title,
            width: modalWidth, // Pasar el ancho calculado al CustomModal
            primaryButtonText: usuario != null ? 'Actualizar' : 'Registrar',
            secondaryButtonText: 'Cancelar',
            onPrimaryButtonPressed: controller.isLoading
                ? null
                : () => _handleSubmit(context, controller),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.error != null)
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            controller.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      CustomTextField(
                        controller: controller.usernameController,
                        label: 'Usuario',
                        hint: 'Ingrese el usuario',
                        validator: controller.validateRequired,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.passwordController,
                        label: 'Contraseña',
                        hint: usuario != null
                            ? 'Dejar vacío para mantener la contraseña actual'
                            : 'Ingrese la contraseña',
                        type: TextFieldType.password,
                        validator: usuario != null
                            ? null // No validar contraseña en modo edición
                            : controller.validatePassword,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.emailController,
                        label: 'Email',
                        hint: 'Ingrese el email',
                        validator: controller.validateEmail,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.nombresController,
                        label: 'Nombres',
                        hint: 'Ingrese los nombres',
                        validator: controller.validateRequired,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.apellidosController,
                        label: 'Apellidos',
                        hint: 'Ingrese los apellidos',
                        validator: controller.validateRequired,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.roleController,
                        label: 'Rol',
                        hint: 'Seleccione el rol',
                        suggestions: const ['Usuario', 'Administrador'],
                        onSuggestionSelected: (value) {
                          controller.setRole(
                              value == 'Usuario' ? 'USUARIO' : 'ADMINISTRADOR');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
