class VistaTransportista {
  final int codTransp;
  final String transportista;
  final String ruc;

  VistaTransportista({
    required this.codTransp,
    required this.transportista,
    required this.ruc,
  });

  factory VistaTransportista.fromJson(Map<String, dynamic> json) {
    return VistaTransportista(
      codTransp: json['cod_transp'] ?? 0,
      transportista: json['transportista']?.toString() ?? '',
      ruc: json['ruc']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod_transp': codTransp,
      'transportista': transportista,
      'ruc': ruc,
    };
  }
}
