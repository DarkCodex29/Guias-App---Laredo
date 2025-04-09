import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/presentation/controllers/auth/login.controller.dart';
import 'package:app_guias/presentation/widgets/custom.button.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(context.read<AuthProvider>()),
      builder: (context, child) => const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1200 : size.width,
                ),
                child: Row(
                  children: [
                    // Sección lateral con imagen/fondo decorativo (solo visible en desktop)
                    if (isDesktop)
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: 120,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Sistema de Guías',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 48),
                                child: Text(
                                  'Administre sus guías de forma eficiente y segura',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Formulario de login
                    Expanded(
                      flex: isDesktop ? 4 : 1,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 64 : 24,
                          vertical: 24,
                        ),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isDesktop) ...[
                                const SizedBox(height: 48),
                                Center(
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    height: 80,
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                              Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  fontSize: isDesktop ? 32 : 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ingrese sus credenciales para acceder al sistema',
                                style: TextStyle(
                                  fontSize: isDesktop ? 16 : 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: isDesktop ? 32 : 24),
                              CustomTextField(
                                controller: controller.usernameController,
                                label: 'Usuario',
                                hint: 'Ingrese su usuario',
                                type: TextFieldType.text,
                                enabled: !controller.isLoading,
                                validator: controller.validateUsername,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: controller.passwordController,
                                label: 'Contraseña',
                                hint: '••••••••',
                                type: TextFieldType.password,
                                enabled: !controller.isLoading,
                                validator: controller.validatePassword,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) {
                                  if (!controller.isLoading) {
                                    controller.login(context);
                                  }
                                },
                              ),
                              const SizedBox(height: 8),
                              if (controller.errorMessage != null)
                                Container(
                                  padding: const EdgeInsets.all(8),
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
                                          controller.errorMessage!,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      text: 'Ingresar',
                                      onPressed: controller.isLoading
                                          ? null
                                          : () => controller.login(context),
                                      isLoading: controller.isLoading,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: TextButton(
                                  onPressed:
                                      controller.isLoading ? null : () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.help_outline,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '¿Olvidaste tu contraseña?',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: isDesktop ? 15 : 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (isDesktop) ...[
                                const SizedBox(height: 32),
                                const Divider(),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sistema de Gestión de Guías v1.0',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
