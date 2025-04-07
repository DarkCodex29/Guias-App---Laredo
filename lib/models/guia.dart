class Guia {
  final int id;
  final String nombre;
  final String? archivo;
  final DateTime fechaSubida;
  final int? idUsuario;
  final String? usuario;

  Guia({
    required this.id,
    required this.nombre,
    this.archivo,
    required this.fechaSubida,
    this.idUsuario,
    this.usuario,
  });

  factory Guia.fromJson(Map<String, dynamic> json) {
    return Guia(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      archivo: json['archivo'] as String?,
      fechaSubida: DateTime.parse(json['fechA_SUBIDA'] as String),
      idUsuario: json['iD_USUARIO'] as int?,
      usuario: json['usernameUsuario'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'archivo': archivo,
      'fechA_SUBIDA': fechaSubida.toIso8601String(),
      'iD_USUARIO': idUsuario,
      'usernameUsuario': usuario,
    };
  }

  // Método para crear una copia de la guía con ciertos campos actualizados
  Guia copyWith({
    int? id,
    String? nombre,
    String? archivo,
    DateTime? fechaSubida,
    int? idUsuario,
    String? usuario,
  }) {
    return Guia(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      archivo: archivo ?? this.archivo,
      fechaSubida: fechaSubida ?? this.fechaSubida,
      idUsuario: idUsuario ?? this.idUsuario,
      usuario: usuario ?? this.usuario,
    );
  }
}
