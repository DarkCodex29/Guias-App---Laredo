class VistaJiron {
  final String campo;
  final String jiron;

  VistaJiron({
    required this.campo,
    required this.jiron,
  });

  factory VistaJiron.fromJson(Map<String, dynamic> json) {
    return VistaJiron(
      campo: json['campo']?.toString() ?? '',
      jiron: json['jiron']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campo': campo,
      'jiron': jiron,
    };
  }
}
