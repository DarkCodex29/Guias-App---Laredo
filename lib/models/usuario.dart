import 'guia.dart';

class Usuario {
  final int id;
  final String username;
  final String nombres;
  final String apellidos;
  final String? contrasena;
  final String rol;
  final String email;
  final String estado;
  final DateTime fechaCreacion;
  final DateTime? fechaActualizacion;
  final List<Guia>? guias;

  Usuario({
    required this.id,
    required this.username,
    required this.nombres,
    required this.apellidos,
    this.contrasena,
    required this.rol,
    required this.email,
    required this.estado,
    required this.fechaCreacion,
    this.fechaActualizacion,
    this.guias,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      username: json['username'] as String,
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      contrasena: json['contraseña'] as String?,
      rol: json['rol'] as String,
      email: json['email'] as String,
      estado: json['estado'] as String,
      fechaCreacion: DateTime.parse(json['fechA_CREACION'] as String),
      fechaActualizacion: json['fechA_ACTUALIZACION'] != null
          ? DateTime.parse(json['fechA_ACTUALIZACION'] as String)
          : null,
      guias: (json['guias'] as List<dynamic>?)
          ?.map((g) => Guia.fromJson(g as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'nombres': nombres,
      'apellidos': apellidos,
      'contraseña': contrasena,
      'rol': rol,
      'email': email,
      'estado': estado,
      'fechA_CREACION': fechaCreacion.toIso8601String(),
      'fechA_ACTUALIZACION': fechaActualizacion?.toIso8601String(),
      'guias': guias?.map((g) => g.toJson()).toList() ?? [],
    };
  }
}
