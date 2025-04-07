import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:app_guias/presentation/controllers/historial/historial.controller.dart';
import 'package:app_guias/core/constants/app.colors.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/providers/guia.provider.dart';
import 'package:app_guias/presentation/widgets/custom.card.dart';

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
    // Inicializar el controlador después de que el contexto esté disponible
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
    final guiaProvider = context.watch<GuiaProvider>();
    final isAdmin = authProvider.role == 'ADMINISTRADOR';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historial de Guías',
              style: TextStyle(color: AppColors.white)),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 1,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.cargarArchivos(isAdmin: isAdmin),
              tooltip: 'Actualizar',
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.picture_as_pdf),
                text: 'PDF',
              ),
              Tab(
                icon: Icon(Icons.description),
                text: 'CSV',
              ),
            ],
            labelColor: AppColors.white,
            indicatorColor: AppColors.white,
          ),
        ),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildFileList(controller.archivosPdf, controller, context,
                      isPdf: true),
                  _buildFileList(controller.archivosCsv, controller, context,
                      isPdf: false),
                ],
              ),
        bottomNavigationBar:
            _buildPaginationControls(context, controller, guiaProvider),
      ),
    );
  }

  Widget? _buildPaginationControls(BuildContext context,
      HistorialController controller, GuiaProvider guiaProvider) {
    // Verificar si el widget sigue montado
    if (!mounted) return null;

    // Solo mostrar paginación si hay guías y más de una página
    if (controller.archivosPdf.isEmpty || guiaProvider.totalPages <= 1) {
      return null;
    }

    return Container(
      height: 50,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: guiaProvider.currentPage <= 1
                ? null
                : () => controller.previousPage(),
            color:
                guiaProvider.currentPage <= 1 ? Colors.grey : AppColors.primary,
          ),
          Text(
            'Página ${guiaProvider.currentPage} de ${guiaProvider.totalPages}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: guiaProvider.currentPage >= guiaProvider.totalPages
                ? null
                : () => controller.nextPage(),
            color: guiaProvider.currentPage >= guiaProvider.totalPages
                ? Colors.grey
                : AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildFileList(List<GuideFile> archivos,
      HistorialController controller, BuildContext context,
      {required bool isPdf}) {
    if (archivos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isPdf ? Icons.picture_as_pdf : Icons.description,
                size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No hay archivos ${isPdf ? 'PDF' : 'CSV'} disponibles',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final authProvider = context.read<AuthProvider>();
    final isAdmin = authProvider.role == 'ADMINISTRADOR';

    return RefreshIndicator(
      onRefresh: () async {
        if (!mounted) return;
        return controller.cargarArchivos(isAdmin: isAdmin);
      },
      child: controller.hasError
          ? Center(
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
                      onPressed: () => controller.cargarArchivos(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: archivos.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (context, index) {
                final archivo = archivos[index];

                // Extraer correlativo del nombre
                String? correlativo;

                if (archivo.fileName.contains('-')) {
                  final parts = archivo.fileName.split('-');
                  if (parts.length >= 3) {
                    correlativo =
                        parts.length > 2 ? '${parts[2]}-${parts[3]}' : '';
                  }
                }

                // Construir widgets del subtítulo
                final List<Widget> subtitleWidgets = [
                  // Fecha
                  RichText(
                    text: TextSpan(
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87),
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
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87),
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

                  // Usuario (solo para PDF)
                  if (isPdf && archivo.usernameUsuario != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black87),
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

                // Icono para abrir el archivo
                final List<Widget> actions = [
                  IconButton(
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () => controller.abrirArchivo(archivo),
                    tooltip: 'Abrir',
                  ),
                ];

                // Título con el correlativo
                final titleWidget = Row(
                  children: [
                    Icon(
                      isPdf ? Icons.picture_as_pdf : Icons.description,
                      color: isPdf ? Colors.red : Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        correlativo ??
                            archivo.serieCorrelativo ??
                            archivo.fileName,
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
