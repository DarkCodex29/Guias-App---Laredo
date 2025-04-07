class VistaCuartel {
  final String campo;
  final String jiron;
  final String cuartel;

  VistaCuartel({
    required this.campo,
    required this.jiron,
    required this.cuartel,
  });

  factory VistaCuartel.fromJson(Map<String, dynamic> json) {
    return VistaCuartel(
      campo: json['campo']?.toString() ?? '',
      jiron: json['jiron']?.toString() ?? '',
      cuartel: json['cuartel']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campo': campo,
      'jiron': jiron,
      'cuartel': cuartel,
    };
  }
}
