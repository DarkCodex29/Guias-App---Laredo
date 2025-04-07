import 'package:app_guias/core/models/detalle.carga.dart';
import 'package:hive/hive.dart';

class DetalleCargaService {
  static const String _boxName = 'detalleCarga';

  Future<void> saveDetalle(DetalleCarga detalle) async {
    final box = await Hive.openBox<DetalleCarga>(_boxName);
    await box.add(detalle);
  }

  Future<List<DetalleCarga>> getAllDetalles() async {
    final box = await Hive.openBox<DetalleCarga>(_boxName);
    return box.values.toList();
  }

  Future<void> updateDetalle(int index, DetalleCarga detalle) async {
    final box = await Hive.openBox<DetalleCarga>(_boxName);
    await box.putAt(index, detalle);
  }

  Future<void> deleteDetalle(int index) async {
    final box = await Hive.openBox<DetalleCarga>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await Hive.openBox<DetalleCarga>(_boxName);
    await box.clear();
  }
}
