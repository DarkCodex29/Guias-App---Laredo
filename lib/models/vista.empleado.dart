class VistaEmpleado {
  final int codigo;
  final String empleado;
  final String dni;
  final int cdTransp;

  VistaEmpleado({
    required this.codigo,
    required this.empleado,
    required this.dni,
    required this.cdTransp,
  });

  factory VistaEmpleado.fromJson(Map<String, dynamic> json) {
    return VistaEmpleado(
      codigo: json['codigo'] ?? 0,
      empleado: json['empleado']?.toString() ?? '',
      dni: json['dni']?.toString() ?? '',
      cdTransp: json['cdTransp'] ?? json['cd_transp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'empleado': empleado,
      'dni': dni,
      'cdTransp': cdTransp,
    };
  }
}
