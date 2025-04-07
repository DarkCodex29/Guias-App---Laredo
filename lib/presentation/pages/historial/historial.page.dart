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
                  _buildTabContent(controller.archivosPdf, controller, context,
                      isPdf: true),
                  _buildTabContent(controller.archivosCsv, controller, context,
                      isPdf: false),
                ],
              ),
      ),
    );
  }

  // Nuevo método para construir el contenido completo de cada tab, incluyendo la paginación
  Widget _buildTabContent(List<GuideFile> archivos,
      HistorialController controller, BuildContext context,
      {required bool isPdf}) {
    final guiaProvider = context.watch<GuiaProvider>();

    return Column(
      children: [
        // Lista de archivos (ahora ocupa todo el espacio excepto la paginación)
        Expanded(
          child: _buildFileList(archivos, controller, context, isPdf: isPdf),
        ),

        // Controles de paginación específicos para cada tab
        if (guiaProvider.totalPages > 1)
          _buildTabPaginationControls(context, controller, guiaProvider, isPdf),
      ],
    );
  }

  // Controles de paginación para cada tab
  Widget _buildTabPaginationControls(BuildContext context,
      HistorialController controller, GuiaProvider guiaProvider, bool isPdf) {
    if (!mounted) return Container();
    return Container(
      height: 56,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Botón para ir a la primera página
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage <= 1
                ? null
                : () => controller.goToPage(1),
            color: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage <= 1
                ? Colors.grey
                : AppColors.primary,
            tooltip: 'Primera página',
          ),
          // Botón para ir a la página anterior
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage <= 1
                ? null
                : () => controller.previousPage(),
            color: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage <= 1
                ? Colors.grey
                : AppColors.primary,
            tooltip: 'Página anterior',
          ),
          const SizedBox(width: 8),
          // Información de paginación
          Expanded(
            child: Center(
              child: isPdf && controller.isLoadingPage
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Cargando...',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Página ${guiaProvider.currentPage} de ${guiaProvider.totalPages}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          const SizedBox(width: 8),
          // Botón para ir a la página siguiente
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage >= guiaProvider.totalPages
                ? null
                : () => controller.nextPage(),
            color: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage >= guiaProvider.totalPages
                ? Colors.grey
                : AppColors.primary,
            tooltip: 'Página siguiente',
          ),
          // Botón para ir a la última página
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage >= guiaProvider.totalPages
                ? null
                : () => controller.goToPage(guiaProvider.totalPages),
            color: (isPdf && controller.isLoadingPage) ||
                    guiaProvider.currentPage >= guiaProvider.totalPages
                ? Colors.grey
                : AppColors.primary,
            tooltip: 'Última página',
          ),
        ],
      ),
    );
  }

  Widget _buildFileList(List<GuideFile> archivos,
      HistorialController controller, BuildContext context,
      {required bool isPdf}) {
    final guiaProvider = context.watch<GuiaProvider>();
    final authProvider = context.read<AuthProvider>();
    final isAdmin = authProvider.role == 'ADMINISTRADOR';

    if (isPdf && controller.isLoadingPage) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando página...'),
          ],
        ),
      );
    }

    if (archivos.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          if (!mounted) return;
          return controller.cargarArchivos(isAdmin: isAdmin);
        },
        child: Center(
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
              if (guiaProvider.totalPages > 1) ...[
                const SizedBox(height: 8),
                Text(
                  'Página ${guiaProvider.currentPage} de ${guiaProvider.totalPages}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('Anterior'),
                      onPressed: guiaProvider.currentPage > 1
                          ? () => controller.previousPage()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('Siguiente'),
                      onPressed:
                          guiaProvider.currentPage < guiaProvider.totalPages
                              ? () => controller.nextPage()
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    }

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

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
