# Guías Laredo - Sistema de Gestión de Guías de Remisión

[![Flutter](https://img.shields.io/badge/Flutter-2.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-2.12+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

Aplicación multiplataforma desarrollada con Flutter para la gestión integral de guías de remisión. Proyecto implementado por Ebim como proveedor de soluciones tecnológicas para el cliente Agroindustrial Laredo. Permite crear, gestionar y monitorear guías de remisión según especificaciones SUNAT.

<div align="center">
  <img src="assets/images/logo_manuelita.png" alt="Guías Laredo Logo" width="200"/>
  
  <p><strong>Desarrollado para:</strong></p>
  <img src="assets/images/logo.png" alt="Agroindustrial Laredo Logo" width="250"/>
</div>

## 📋 Características

- **Autenticación de usuarios**: Sistema seguro de ingreso para personal autorizado
- **Gestión de empresas**: Administración completa de información empresarial
- **Gestión de detalles de carga**: Control y seguimiento detallado de la información de carga
- **Interfaz intuitiva**: Diseño amigable que facilita la operación diaria
- **Generación de guías de remisión**: Creación automatizada de documentos según especificaciones SUNAT
- **Integración con EFACT**: Emisión electrónica de guías conectada con OSE autorizado
- **Soporte multiusuario**: Sistema adaptado para diferentes roles y permisos
- **Multiplaforma**: Aplicación disponible para Android y Desktop (Windows y Android)
- **Interfaz adaptativa**: Diseño responsivo que se adapta a diferentes tamaños de pantalla
- **Modo escritorio**: Interfaz optimizada para pantallas grandes con funcionalidades adicionales
- **Almacenamiento local**: Gestión de archivos adaptada a cada plataforma
- **Tema oscuro**: Soporte para modo oscuro en sistemas operativos de escritorio

## 🚀 Instalación

### Requisitos previos

- Flutter SDK 2.0 o superior
- Dart SDK 2.12 o superior
- Conexión a Internet para descarga de dependencias
- Acceso a Firebase para configuración de servicios
- Para Windows:
  - Windows 10 o superior
  - Visual Studio 2019 o superior con soporte para desarrollo de escritorio

### Pasos de instalación

1. Clona este repositorio:
   ```bash
   git clone https://github.com/GRUPO-EBIM/app-guias.git
   cd app-guias
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Configura las variables de entorno:
   - Copia el archivo `.env.example` a `.env`:
     ```bash
     cp .env.example .env
     ```
   - Edita el archivo `.env` y completa con tus credenciales reales
   - **⚠️ IMPORTANTE**: Nunca subas el archivo `.env` con tus credenciales al repositorio

4. Configura Firebase:
   - **IMPORTANTE**: El archivo `firebase_options.dart` contiene credenciales sensibles y está excluido del repositorio
   - Crea tu propio archivo `firebase_options.dart` basado en `firebase_options.example.dart`
   - Obtén tus propias credenciales de Firebase desde la consola de Firebase
   - Puedes usar el comando `flutterfire configure` para generarlo automáticamente:
     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```

5. Ejecuta la aplicación:
   ```bash
   flutter run -d android   # Para Android
   flutter run -d windows   # Para Windows
   flutter run              # Para dispositivo predeterminado
   ```

## ⚙️ Configuración

### Variables de entorno

El proyecto utiliza un archivo `.env` para gestionar la configuración de forma segura:

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `API_BASE_URL` | URL base para la API de Laredo | `https://api.laredo.com` |
| `APP_NAME` | Nombre de la aplicación | `Sol de Laredo - Guías` |
| `APP_VERSION` | Versión de la aplicación | `0.1.0` |
| `EFACT_BASE_URL` | URL para la API de EFACT | `https://api.efact.com` |
| `EFACT_USERNAME` | Usuario para autenticación EFACT | `username` |
| `EFACT_PASSWORD` | Contraseña para autenticación EFACT | `password` |
| `EFACT_CLIENT_USERNAME` | Cliente para EFACT | `client` |
| `EFACT_CLIENT_PASSWORD` | Contraseña del cliente EFACT | `secret` |
| `RUC` | RUC de la empresa emisora | `20123456789` |

### ⚠️ Seguridad

Para garantizar la seguridad de las credenciales y datos sensibles:

- El archivo `.env` está incluido en `.gitignore` para evitar subirlo accidentalmente
- Los archivos de configuración de Firebase (`firebase_options.dart`, `google-services.json`, etc.) están excluidos del repositorio
- **NUNCA** guardes credenciales reales en el código fuente
- **NUNCA** incluyas información sensible en commits o PRs
- **NUNCA** subas archivos de configuración con credenciales reales al repositorio
- Utiliza servicios seguros para compartir credenciales con el equipo de desarrollo
- Si crees que has expuesto accidentalmente alguna credencial, cámbiala inmediatamente

### Seguridad de Firebase

Para proteger tu proyecto de Firebase:

1. **Limita el uso de API keys**: Configura restricciones de dominio y app para tus claves de API en la consola de Firebase
2. **Configura reglas de seguridad**: Establece reglas estrictas para Firestore, Storage y Realtime Database
3. **Rota las credenciales**: Cambia periódicamente las credenciales sensibles
4. **Monitoriza el uso**: Revisa regularmente los logs de uso y actividad en tu proyecto Firebase

### Almacenamiento local

La aplicación utiliza Hive para la gestión de datos locales:

1. **Persistencia de datos**: Almacenamiento eficiente de información de empresas y cargas
2. **Optimización de recursos**: Carga rápida de datos frecuentemente utilizados
3. **Modelos adaptados**: Uso de adaptadores Hive para entidades del negocio

## 🏗️ Arquitectura

El proyecto sigue una arquitectura modular organizada por funcionalidades:

```
lib/
├── core/           # Elementos centrales de la aplicación
│   ├── constants/  # Constantes y configuración
│   ├── models/     # Modelos de datos principales
│   ├── providers/  # Proveedores centrales
│   └── services/   # Servicios compartidos
├── data/           # Capa de datos y APIs
├── domain/         # Lógica de negocio
├── models/         # Modelos adicionales
├── presentation/   # Capa de UI
│   ├── pages/      # Páginas de la aplicación
│   └── widgets/    # Componentes de UI reutilizables
├── providers/      # Proveedores de datos específicos
├── services/       # Servicios específicos
└── main.dart       # Punto de entrada de la aplicación
```

### Patrones y frameworks utilizados:

- **Provider**: Para gestión de estado e inyección de dependencias
- **Hive**: Para almacenamiento local persistente
- **Dio**: Para comunicación HTTP con backends
- **Firebase**: Para analítica y almacenamiento en la nube
- **Repository Pattern**: Para separar la lógica de acceso a datos
- **Service Pattern**: Para encapsular lógica de negocio reutilizable

## 🔍 Validación y Pruebas

La aplicación ha sido validada con:

- **Pruebas manuales**: Verificación de flujos de trabajo completos
- **Validación en campo**: Pruebas con usuarios de Agroindustrial Laredo
- **Verificación SUNAT**: Conformidad con requerimientos oficiales para guías de remisión

## 📄 Licencia

Este proyecto es propiedad de Agroindustrial Laredo S.A.A. Todos los derechos reservados.

## 👥 Desarrollo

Proyecto desarrollado por Ebim para Agroindustrial Laredo S.A.A.

### Desarrollador Principal
- **Gianpierre Mio**: Desarrollador de software en Ebim, encargado de implementar esta solución para el cliente Agroindustrial Laredo.

Para contribuir al proyecto:

1. Revisa las guías de estilo de código
2. Crea una rama para tu funcionalidad (`git checkout -b feature/nueva-funcionalidad`)
3. Haz commit de tus cambios (`git commit -m 'Agrega nueva funcionalidad'`)
4. Envía un Pull Request

## 📞 Contacto

Para soporte o consultas, contacta al desarrollador:

- Nombre: Gianpierre Mio
- Email: gianxs296@gmail.com
- Teléfono: +51952164832
- Empresa: Desarrollador en Ebim para el proyecto de Agroindustrial Laredo
