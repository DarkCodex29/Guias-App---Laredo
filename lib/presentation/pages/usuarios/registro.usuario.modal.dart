import 'package:flutter/material.dart';
import '../../widgets/custom.modal.dart';
import '../../widgets/custom.textfield.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/presentation/controllers/usuarios/registro.usuario.controller.dart';
import '../../../core/constants/app.colors.dart';

class RegistroUsuarioModal extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;
  final String title;
  final dynamic usuario;
  final VoidCallback onSuccess;

  const RegistroUsuarioModal({
    super.key,
    required this.onSubmit,
    required this.onSuccess,
    this.title = 'Registro de usuario',
    this.usuario,
  });

  @override
  _RegistroUsuarioModalState createState() => _RegistroUsuarioModalState();
}

class _RegistroUsuarioModalState extends State<RegistroUsuarioModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistroUsuarioController(usuario: widget.usuario),
      child: Builder(
        builder: (context) {
          final size = MediaQuery.of(context).size;
          final isDesktop = size.width > 600;
          final double modalWidth = isDesktop ? 500 : size.width * 0.9;
          final controller = context.watch<RegistroUsuarioController>();

          return CustomModal(
            title: widget.title,
            width: modalWidth,
            primaryButtonText:
                widget.usuario != null ? 'Actualizar' : 'Registrar',
            secondaryButtonText: 'Cancelar',
            onPrimaryButtonPressed: controller.isLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      controller.prepareProviders(context);

                      final userData = {
                        'username': controller.usernameController.text.trim(),
                        'password': controller.passwordController.text,
                        'names': controller.nombresController.text.trim(),
                        'surnames': controller.apellidosController.text.trim(),
                        'role': controller.roleController.text == 'Usuario'
                            ? 'USUARIO'
                            : 'ADMINISTRADOR',
                      };
                      // Solo incluir email si no está vacío
                      final email = '';
                      if (email.isNotEmpty) {
                        userData['email'] = email;
                      }

                      //if (widget.usuario != null) {
                      // userData['id'] = widget.usuario.id;
                      //}

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      try {
                        final success = widget.usuario != null
                            ? await controller.update()
                            : await controller.register(userData);

                        if (!mounted) return;
                        Navigator.of(context)
                            .pop(); // Cierra el indicador de progreso

                        if (success) {
                          // Cerrar el modal de registro
                          Navigator.of(context).pop();

                          // Llamar al callback de éxito para actualizar la lista
                          widget.onSuccess();

                          // Mostrar modal de confirmación con el mismo estilo
                          if (!mounted) return;
                          await showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Éxito',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      widget.usuario != null
                                          ? 'Usuario actualizado exitosamente'
                                          : 'Usuario registrado exitosamente',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Aceptar'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Extraer solo el mensaje del error
                          String errorMsg = controller.error ?? '';
                          if (errorMsg.contains('{message:')) {
                            errorMsg = errorMsg.split('{message:')[1];
                            errorMsg = errorMsg.split('}')[0].trim();
                          }
                          controller.error = errorMsg;
                        }
                      } catch (e) {
                        if (!mounted) return;
                        Navigator.of(context)
                            .pop(); // Cierra el indicador de progreso

                        // Formatear y mostrar solo el mensaje de error
                        String errorMsg = e.toString();
                        if (errorMsg.contains('{message:')) {
                          errorMsg = errorMsg.split('{message:')[1];
                          errorMsg = errorMsg.split('}')[0].trim();
                        }
                        controller.error = errorMsg;
                      }
                    }
                  },
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.error != null)
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.error!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      CustomTextField(
                        controller: controller.usernameController,
                        label: 'Usuario',
                        hint: 'Ingrese el usuario',
                        validator: controller.validateRequired,
                        enabled: !controller.isLoading,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.passwordController,
                        label: 'Contraseña',
                        hint: widget.usuario != null
                            ? 'Ingrese nueva contraseña'
                            : 'Ingrese la contraseña',
                        type: TextFieldType.password,
                        validator: widget.usuario != null
                            ? null
                            : controller.validatePassword,
                        enabled: !controller.isLoading,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.nombresController,
                        label: 'Nombres',
                        hint: 'Ingrese los nombres',
                        validator: controller.validateRequired,
                        enabled: !controller.isLoading,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.apellidosController,
                        label: 'Apellidos',
                        hint: 'Ingrese los apellidos',
                        validator: controller.validateRequired,
                        enabled: !controller.isLoading,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.roleController,
                        label: 'Rol',
                        hint: 'Seleccione el rol',
                        readOnly: true,
                        enabled: !controller.isLoading,
                        enableSuggestions: true,
                        suggestions: const ['Usuario', 'Administrador'],
                        onSuggestionSelected: (value) {
                          controller.setRole(
                              value == 'Usuario' ? 'USUARIO' : 'ADMINISTRADOR');
                        },
                        validator: controller.validateRequired,
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
