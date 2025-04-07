import 'package:app_guias/core/models/company.dart';
import 'package:hive/hive.dart';

class SettingsService {
  static const String _boxName = 'companySettings';

  Future<void> saveCompanySettings(Company settings) async {
    final box = await Hive.openBox<Company>(_boxName);
    await box.put('company', settings);
  }

  Future<Company?> getCompanySettings() async {
    final box = await Hive.openBox<Company>(_boxName);
    return box.get('company');
  }

  Future<void> updateDefaultValues(Map<String, String> newValues) async {
    final box = await Hive.openBox<Company>(_boxName);
    final settings = box.get('company');
    if (settings != null) {
      settings.defaultValues = newValues;
      await settings.save();
    }
  }
}
