import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:app_guias/presentation/controllers/historial/historial.controller.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/presentation/widgets/custom.card.dart';
import 'package:app_guias/presentation/widgets/custom.card.shimmer.dart';
import 'package:app_guias/presentation/widgets/custom.textfield.dart';
import 'package:app_guias/presentation/widgets/modals/procesando.modal.dart';
import 'package:app_guias/presentation/widgets/modals/resultado.modal.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistorialController(),
      child: const _HistorialPageContent(),
    );
  }
}

class _HistorialPageContent extends StatefulWidget {
  const _HistorialPageContent();

  @override
  State<_HistorialPageContent> createState() => _HistorialPageContentState();
}

class _HistorialPageContentState extends State<_HistorialPageContent> {
  // Variable para controlar si el widget está montado
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_mounted) return;
      final controller = context.read<HistorialController>();
      controller.initialize(context);
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HistorialController>();
    final authProvider = context.watch<AuthProvider>();
    final isAdmin = authProvider.role == 'ADMINISTRADOR';
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    // En desktop solo mostramos una pestaña (PDF), mientras que en móvil mostramos dos (PDF y CSV)
    final tabCount = isDesktop ? 1 : 2;

    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historial de Guías',
              style: TextStyle(color: AppColors.white)),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 1,
          actions: [],
          bottom: TabBar(
            tabs: [
              const Tab(
                icon: Icon(Icons.picture_as_pdf),
                text: 'PDF',
              ),
              // Solo mostrar la pestaña CSV en móvil
              if (!isDesktop)
                const Tab(
                  icon: Icon(Icons.description),
                  text: 'CSV',
                ),
            ],
            labelColor: AppColors.white,
            indicatorColor: AppColors.white,
          ),
        ),
        body: isDesktop
            ? _buildDesktopLayout(controller, context, isAdmin)
            : _buildMobileLayout(controller, context, isAdmin),
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.cargarArchivos(isAdmin: isAdmin),
          backgroundColor: AppColors.primary,
          tooltip: 'Actualizar',
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      HistorialController controller, BuildContext context, bool isAdmin) {
    return Column(
      children: [
        _buildSearchBar(controller, context),
        Expanded(
          child: TabBarView(
            children: [
              _buildTabContent(controller.filteredPdfFiles, controller, context,
                  isPdf: true),
              _buildTabContent(controller.filteredCsvFiles, controller, context,
                  isPdf: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
      HistorialController controller, BuildContext context, bool isAdmin) {
    return Column(
      children: [
        _buildSearchBar(controller, context),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TabBarView(
                  children: [
                    _buildTabContent(
                        controller.filteredPdfFiles, controller, context,
                        isPdf: true),
                  ],
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
                      children: const [
                        Text(
                          'Nota',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Solo el administrador puede ver el historial de guías completo.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'En versión de escritorio solo se muestran los archivos PDF. Para ver los archivos CSV, acceda desde un dispositivo móvil.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(HistorialController controller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              label: '',
              hint: 'Buscar guías (número o correlativo)',
              type: TextFieldType.search,
              controller: controller.searchController,
              actionIcon:
                  controller.searchText.isNotEmpty ? Icons.clear : Icons.search,
              onActionPressed: controller.searchText.isNotEmpty
                  ? () => controller.clearFilters()
                  : null,
              onChanged: (value) => controller.searchGuias(value),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(List<GuideFile> archivos,
      HistorialController controller, BuildContext context,
      {required bool isPdf}) {
    final isLoading =
        isPdf ? controller.isLoadingPagePDF : controller.isLoadingPageCSV;

    if (isLoading) {
      return CustomCardShimmer(
        isPdf: isPdf,
        count: 10,
      );
    }

    // Si hay error, mostrar mensaje de error
    if (controller.hasError) {
      return RefreshIndicator(
        onRefresh: () async {
          if (!mounted) return;
          return isPdf
              ? controller.cargarArchivosPDF(isAdmin: controller.isAdmin)
              : controller.cargarArchivosCSV(isAdmin: controller.isAdmin);
        },
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: AppColors.red),
                    const SizedBox(height: 16),
                    Text(
                      controller.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh, color: AppColors.white),
                      label: const Text('Reintentar',
                          style: TextStyle(color: AppColors.white)),
                      onPressed: () => isPdf
                          ? controller.cargarArchivosPDF(
                              isAdmin: controller.isAdmin)
                          : controller.cargarArchivosCSV(
                              isAdmin: controller.isAdmin),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    if (archivos.isEmpty && !isLoading) {
      return RefreshIndicator(
        onRefresh: () async {
          if (!mounted) return;
          return isPdf
              ? controller.cargarArchivosPDF(isAdmin: controller.isAdmin)
              : controller.cargarArchivosCSV(isAdmin: controller.isAdmin);
        },
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 56),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isPdf ? Icons.picture_as_pdf : Icons.description,
                      size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No hay archivos ${isPdf ? 'PDF' : 'CSV'} en esta página',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return RefreshIndicator(
      onRefresh: () async {
        if (!mounted) return;
        return isPdf
            ? controller.cargarArchivosPDF(isAdmin: controller.isAdmin)
            : controller.cargarArchivosCSV(isAdmin: controller.isAdmin);
      },
      child: ListView.builder(
        itemCount: archivos.length,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 72,
        ),
        itemBuilder: (context, index) {
          final archivo = archivos[index];

          // Verificar si el archivo es local
          final bool isLocal = isPdf &&
              archivo.fullPath.isNotEmpty &&
              controller.archivosPdfLocales
                  .any((local) => local.fullPath == archivo.fullPath);

          // Extraer correlativo del nombre
          String? correlativo;

          if (archivo.fileName.contains('-')) {
            final parts = archivo.fileName.split('-');
            if (parts.length >= 3) {
              correlativo = parts.length > 2 ? '${parts[2]}-${parts[3]}' : '';
            }
          }

          // Construir widgets del subtítulo
          final List<Widget> subtitleWidgets = [
            // Fecha
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Colors.black87),
                children: [
                  const TextSpan(
                    text: 'Fecha: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: dateFormat.format(archivo.creationDate),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Nombre del archivo
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Colors.black87),
                children: [
                  const TextSpan(
                    text: 'Nombre del archivo: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: archivo.fileName,
                  ),
                ],
              ),
            ),

            // Etiqueta "Archivo Local" para archivos locales
            if (isLocal)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Archivo Local',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Usuario (solo para PDF del servidor)
            if (isPdf && archivo.usernameUsuario != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    children: [
                      const TextSpan(
                        text: 'Usuario: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: archivo.usernameUsuario,
                      ),
                    ],
                  ),
                ),
              ),
          ];

          // Iconos para compartir y subir (si es local)
          final List<Widget> actions = [
            // Botón para subir al backend
            if (isLocal)
              IconButton(
                icon: controller.isUploadingFile(archivo)
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      )
                    : const Icon(Icons.cloud_upload, color: Colors.blue),
                onPressed: controller.isUploadingFile(archivo)
                    ? null
                    : () async {
                        // Mostrar diálogo de confirmación primero
                        final confirmResult = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              title: const Text('Confirmar subida'),
                              content: const Text(
                                '¿Está seguro que desea subir esta guía al servidor?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(false),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                  ),
                                  child: const Text(
                                    'Subir',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        // Verificar si se confirmó la subida
                        if (confirmResult != true || !context.mounted) return;

                        // Guardar las listas actuales para poder restaurarlas en caso de error
                        final currentPdfFiles =
                            List<GuideFile>.from(controller.filteredPdfFiles);
                        final currentCsvFiles =
                            List<GuideFile>.from(controller.filteredCsvFiles);

                        // Mostrar modal de procesamiento
                        ProcesandoModal.show(
                          context,
                          title: 'Subiendo guía',
                          message: 'Subiendo archivo al servidor...',
                        );

                        try {
                          // Limpiar cualquier error previo
                          controller.clearError();

                          // Subir el archivo
                          final success =
                              await controller.subirArchivoLocal(archivo);

                          // Asegurarnos de cerrar el modal de procesamiento
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }

                          if (!context.mounted) return;

                          if (success) {
                            // Actualizar la lista después de una subida exitosa
                            await controller.cargarArchivos(
                                isAdmin: controller.isAdmin);

                            // Subida exitosa - mostrar después de actualizar la lista
                            if (context.mounted) {
                              await ResultadoModal.showSuccess(
                                context,
                                title: 'Éxito',
                                message: 'Archivo subido exitosamente',
                              );
                            }
                          } else {
                            final errorMsg = controller.getErrorAndClear();

                            // Si el error contiene el mensaje de guía existente
                            if (controller.isGuiaExistsError) {
                              await ResultadoModal.showError(
                                context,
                                title: 'Guía ya registrada',
                                message: errorMsg,
                                onButtonPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                              // Actualizar la lista después de eliminar el archivo local
                              await controller.cargarArchivos(
                                  isAdmin: controller.isAdmin);
                            } else {
                              // Para otros tipos de errores
                              await ResultadoModal.showError(
                                context,
                                title: 'Error',
                                message: 'No se pudo subir el archivo',
                                details: [Text(errorMsg)],
                                onButtonPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                              // Restaurar las listas originales
                              controller.restoreFilesState(
                                  currentPdfFiles, currentCsvFiles);
                            }
                          }
                        } catch (e) {
                          // Cerrar el modal de procesamiento si sigue abierto
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }

                          if (!context.mounted) return;

                          // Mostrar error inesperado
                          await ResultadoModal.showError(
                            context,
                            title: 'Error',
                            message: 'Ocurrió un error inesperado',
                            details: [Text(e.toString())],
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          controller.clearError();

                          // Restaurar las listas originales
                          controller.restoreFilesState(
                              currentPdfFiles, currentCsvFiles);
                        }
                      },
                tooltip: 'Subir al backend',
              ),

            // Botón para compartir
            IconButton(
              icon: controller.isSharingFile(archivo)
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    )
                  : const Icon(Icons.share, color: Colors.green),
              onPressed: controller.isSharingFile(archivo)
                  ? null
                  : () async {
                      // Mostrar diálogo de carga
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return PopScope(
                            canPop: false,
                            onPopInvokedWithResult: (didPop, result) {
                              if (didPop) {
                                Navigator.of(dialogContext).pop();
                              }
                            },
                            child: AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(height: 16),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 24),
                                  Text(
                                    'Preparando archivo para compartir...',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      // Compartir el archivo
                      final success =
                          await controller.compartirArchivo(archivo);

                      // Cerrar el diálogo de carga
                      if (context.mounted) {
                        // Usamos un pequeño retraso para asegurar que el Navigator se desbloquee
                        await Future.delayed(const Duration(milliseconds: 100));
                        if (context.mounted) Navigator.of(context).pop();
                      }

                      // Verificar si el widget todavía está montado
                      if (!context.mounted) return;

                      // Usamos otro pequeño retraso para asegurar que el Navigator se desbloquee completamente
                      await Future.delayed(const Duration(milliseconds: 100));
                      if (!context.mounted) return;

                      // Si hubo error, mostrar diálogo
                      if (!success) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text(
                                'Error',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text(
                                controller.errorMessage.isNotEmpty
                                    ? controller.errorMessage
                                    : 'No se pudo compartir el archivo',
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                  ),
                                  child: const Text(
                                    'ACEPTAR',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
              tooltip: 'Compartir',
            ),
          ];

          // Título con el correlativo e icono diferenciador
          final titleWidget = Row(
            children: [
              Icon(
                isPdf
                    ? (isLocal ? Icons.picture_as_pdf : Icons.picture_as_pdf)
                    : Icons.description,
                color: isPdf
                    ? (isLocal
                        ? Colors.orange
                        : Colors
                            .red) // Naranja para PDFs locales, rojo para normales
                    : Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  correlativo ?? archivo.serieCorrelativo ?? archivo.fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

          return CustomCard(
            title: '',
            titleWidget: titleWidget,
            subtitleWidgets: subtitleWidgets,
            trailing: actions,
            onTap: () => controller.abrirArchivo(archivo),
            elevation: 2,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          );
        },
      ),
    );
  }
}
