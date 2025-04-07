class VistaEquipo {
  final int codEquipo;
  final String placa;
  final int codTransp;
  final String tipEquipo;

  VistaEquipo({
    required this.codEquipo,
    required this.placa,
    required this.codTransp,
    required this.tipEquipo,
  });

  factory VistaEquipo.fromJson(Map<String, dynamic> json) {
    return VistaEquipo(
      codEquipo: json['codigo'] ?? 0,
      placa: json['placa']?.toString() ?? '',
      codTransp: json['codTransp'] ?? 0,
      tipEquipo: json['tipoEquipo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod_equipo': codEquipo,
      'placa': placa,
      'cod_transp': codTransp,
      'tip_equipo': tipEquipo,
    };
  }
}
