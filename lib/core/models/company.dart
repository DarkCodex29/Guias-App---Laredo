import 'package:hive/hive.dart';
part 'company.g.dart';

@HiveType(typeId: 1)
class Company extends HiveObject {
  @HiveField(0)
  String companyName;

  @HiveField(1)
  String ruc;

  @HiveField(2)
  String address;

  @HiveField(3)
  Map<String, String> defaultValues;

  Company({
    required this.companyName,
    required this.ruc,
    required this.address,
    required this.defaultValues,
  });

  factory Company.initial() {
    return Company(
      companyName: '',
      ruc: '',
      address: '',
      defaultValues: {},
    );
  }

  bool get isValid =>
      companyName.isNotEmpty && ruc.isNotEmpty && address.isNotEmpty;

  void updateDefaultValues(String key, String value) {
    defaultValues[key] = value;
    save();
  }

  Map<String, String> toJson() => {
        'companyName': companyName,
        'ruc': ruc,
        'address': address,
        ...defaultValues,
      };
}
