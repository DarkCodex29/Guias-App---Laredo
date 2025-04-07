import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/auth/login.page.dart';
import '../pages/menu/menu.page.dart';
import '../../providers/auth.provider.dart';
import '../../core/constants/app.colors.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (!authProvider.isInitialized) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text(
                    'Cargando...',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (authProvider.isAuthenticated) {
          return const MenuPage();
        }

        return const LoginPage();
      },
    );
  }
}
