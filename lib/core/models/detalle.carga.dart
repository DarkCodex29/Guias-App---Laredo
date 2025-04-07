import 'package:hive/hive.dart';
part 'detalle.carga.g.dart';

@HiveType(typeId: 2)
class DetalleCarga extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String producto;

  @HiveField(2)
  double cantidad;

  @HiveField(3)
  String unidadMedida;

  @HiveField(4)
  String campo;

  @HiveField(5)
  String cuartel;

  @HiveField(6)
  String jiron;

  @HiveField(7)
  String variedad;

  @HiveField(8)
  DateTime fechaCorte;

  @HiveField(9)
  double pesoKg;

  DetalleCarga({
    this.id,
    required this.producto,
    required this.cantidad,
    required this.unidadMedida,
    required this.campo,
    required this.cuartel,
    required this.jiron,
    required this.variedad,
    required this.fechaCorte,
    required this.pesoKg,
  });

  factory DetalleCarga.initial() {
    return DetalleCarga(
      id: null,
      producto: '',
      cantidad: 0.0,
      unidadMedida: '',
      campo: '',
      cuartel: '',
      jiron: '',
      variedad: '',
      fechaCorte: DateTime.now(),
      pesoKg: 0.0,
    );
  }

  bool get isValid =>
      cantidad > 0 &&
      campo.isNotEmpty &&
      cuartel.isNotEmpty &&
      jiron.isNotEmpty &&
      variedad.isNotEmpty &&
      unidadMedida.isNotEmpty;

  Map<String, dynamic> toJson() => {
        'id': id,
        'producto': producto,
        'cantidad': cantidad,
        'unidadMedida': unidadMedida,
        'campo': campo,
        'cuartel': cuartel,
        'jiron': jiron,
        'variedad': variedad,
        'fechaCorte': fechaCorte.toIso8601String(),
        'pesoKg': pesoKg,
      };
}
