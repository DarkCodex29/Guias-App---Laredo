import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app_guias/presentation/widgets/custom.card.dart';

class CustomCardShimmer extends StatelessWidget {
  final bool isPdf;
  final int count;

  const CustomCardShimmer({
    super.key,
    this.isPdf = true,
    this.count = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 72, // Espacio para la paginación
        ),
        itemCount: count,
        itemBuilder: (context, index) {
          return CustomCard(
            title: '',
            titleWidget: Row(
              children: [
                Icon(
                  isPdf ? Icons.picture_as_pdf : Icons.description,
                  color: isPdf ? Colors.red : Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            subtitleWidgets: [
              // Fecha
              Container(
                height: 12,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),

              // Nombre del archivo
              Container(
                height: 12,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              // Usuario (solo para PDF)
              if (isPdf) ...[
                const SizedBox(height: 4),
                Container(
                  height: 12,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ],
            trailing: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
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
