import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:app_guias/domain/repositories/ubigeo.repository.dart';
import 'package:app_guias/presentation/controllers/ubigeo_controller.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/providers/campo.provider.dart';
import 'package:app_guias/providers/jiron.provider.dart';
import 'package:app_guias/providers/cuartel.provider.dart';
import 'package:app_guias/providers/empleado.provider.dart';
import 'package:app_guias/providers/equipo.provider.dart';
import 'package:app_guias/providers/transportista.provider.dart';
import 'package:app_guias/providers/usuario.provider.dart';
import 'package:app_guias/providers/guia.provider.dart';

class AppProviders {
  static MultiProvider getProviders(UbigeoRepository firebaseService,
      {required Widget child}) {
    final baseUrl = dotenv.env['API_BASE_URL']!;

    return MultiProvider(
      providers: [
        Provider<UbigeoRepository>.value(value: firebaseService),
        // Providers para la integración con el backend
        ChangeNotifierProvider(
          create: (_) => AuthProvider(baseUrl: baseUrl),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CampoProvider>(
          create: (context) => CampoProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => CampoProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, JironProvider>(
          create: (context) => JironProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => JironProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CuartelProvider>(
          create: (context) => CuartelProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => CuartelProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, EmpleadoProvider>(
          create: (context) => EmpleadoProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => EmpleadoProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, EquipoProvider>(
          create: (context) => EquipoProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => EquipoProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TransportistaProvider>(
          create: (context) => TransportistaProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => TransportistaProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UsuarioProvider>(
          create: (context) => UsuarioProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => UsuarioProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, GuiaProvider>(
          create: (context) => GuiaProvider(
            baseUrl: baseUrl,
            token: context.read<AuthProvider>().token ?? '',
          ),
          update: (context, auth, previous) => GuiaProvider(
            baseUrl: baseUrl,
            token: auth.token ?? '',
          ),
        ),
        // Providers existentes
        ChangeNotifierProvider(
          create: (context) => UbigeoController(firebaseService),
        ),
      ],
      child: child,
    );
  }
}
