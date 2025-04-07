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

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                ),
                const SizedBox(height: 48),
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
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            controller.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Ingresar',
                  onPressed: controller.isLoading
                      ? null
                      : () => controller.login(context),
                  isLoading: controller.isLoading,
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: controller.isLoading ? null : () {},
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
