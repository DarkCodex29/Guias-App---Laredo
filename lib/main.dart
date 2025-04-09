import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/core/models/company.dart';
import 'package:app_guias/core/models/detalle.carga.dart';
import 'package:app_guias/models/ubigeo.dart';
import 'package:app_guias/services/firebase.service.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:app_guias/core/providers/app.providers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'presentation/widgets/auth.wrapper.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Configurar share_plus
    Share.downloadFallbackEnabled = true;

    // Verificar plataforma y configurar permisos solo para Android
    if (!kIsWeb && Platform.isAndroid) {
      // Lógica específica para Android
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      // Solicitar permisos según la versión de Android
      if (sdkInt >= 33) {
        // Android 13 y superior
        final status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          LoggerService.warning(
              'Permisos de almacenamiento no concedidos en Android 13+');
        }
      } else if (sdkInt >= 29) {
        // Android 10-12
        final readStatus = await Permission.storage.request();
        final writeStatus = await Permission.storage.request();
        if (!readStatus.isGranted || !writeStatus.isGranted) {
          LoggerService.warning(
              'Permisos de almacenamiento no concedidos en Android 10-12');
        }
      } else {
        // Android 9 y anteriores
        final readStatus = await Permission.storage.request();
        final writeStatus = await Permission.storage.request();
        if (!readStatus.isGranted || !writeStatus.isGranted) {
          LoggerService.warning(
              'Permisos de almacenamiento no concedidos en Android 9 o anterior');
        }
      }
    } else {
      LoggerService.info(
          'Ejecutando en plataforma: ${kIsWeb ? 'Web' : Platform.operatingSystem}');
    }

    // Inicializar Firebase con opciones específicas para la plataforma
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    LoggerService.info('Firebase inicializado correctamente');

    // Cargar variables de entorno
    await dotenv.load(fileName: ".env");
    LoggerService.info('Variables de entorno cargadas');

    // Inicializar Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    LoggerService.info('Hive inicializado en: ${appDocumentDir.path}');

    // Registrar adaptadores
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(DetalleCargaAdapter());
    Hive.registerAdapter(DepartamentoModelAdapter());
    Hive.registerAdapter(ProvinciaModelAdapter());
    Hive.registerAdapter(DistritoModelAdapter());
    LoggerService.info('Adaptadores de Hive registrados');

    // Inicializar Firebase Service
    final firebaseService = FirebaseService();
    await firebaseService.initializeUbigeo();
    LoggerService.info('Firebase Service inicializado');

    // Abrir boxes de Hive
    await Hive.openBox<Company>('company');
    await Hive.openBox<DetalleCarga>('detalle_carga');
    await Hive.openBox<DepartamentoModel>('departamentos');
    await Hive.openBox<ProvinciaModel>('provincias');
    await Hive.openBox<DistritoModel>('distritos');

    runApp(
      AppProviders.getProviders(
        firebaseService,
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    LoggerService.error(
        'Error en la inicialización de la aplicación', stackTrace);
    // Mostrar un widget de error en lugar de la app
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Error al inicializar la aplicación: $e',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: dotenv.env['APP_NAME']!,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}
