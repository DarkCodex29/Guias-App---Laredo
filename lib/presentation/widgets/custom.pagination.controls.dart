import 'package:flutter/material.dart';
import 'package:app_guias/core/constants/app.colors.dart';

class CustomPaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool isLoading;
  final VoidCallback? onFirstPage;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;
  final VoidCallback? onLastPage;

  const CustomPaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.isLoading = false,
    this.onFirstPage,
    this.onPreviousPage,
    this.onNextPage,
    this.onLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Botón para ir a la primera página
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: isLoading || currentPage <= 1 ? null : onFirstPage,
            color:
                isLoading || currentPage <= 1 ? Colors.grey : AppColors.primary,
            tooltip: 'Primera página',
          ),
          // Botón para ir a la página anterior
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: isLoading || currentPage <= 1 ? null : onPreviousPage,
            color:
                isLoading || currentPage <= 1 ? Colors.grey : AppColors.primary,
            tooltip: 'Página anterior',
          ),
          const SizedBox(width: 8),
          // Información de paginación
          Expanded(
            child: Center(
              child: isLoading
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
                          'Cargando página $currentPage...',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Página $currentPage de $totalPages',
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
            onPressed:
                isLoading || currentPage >= totalPages ? null : onNextPage,
            color: isLoading || currentPage >= totalPages
                ? Colors.grey
                : AppColors.primary,
            tooltip: 'Página siguiente',
          ),
          // Botón para ir a la última página
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed:
                isLoading || currentPage >= totalPages ? null : onLastPage,
            color: isLoading || currentPage >= totalPages
                ? Colors.grey
                : AppColors.primary,
            tooltip: 'Última página',
          ),
        ],
      ),
    );
  }
}
