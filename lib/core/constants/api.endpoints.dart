class ApiEndpoints {
  // Auth
  static const String login = '/api/auth/login';
  static const String validate = '/api/auth/validate';
  static const String logout = '/api/auth/logout';

  // Campos
  static const String campos = '/api/campos';
  static const String campoById = '/api/campos/{campo}';

  // Cuarteles
  static const String cuarteles = '/api/cuarteles';
  static const String cuartelById = '/api/cuarteles/{cuartel}';
  static const String cuartelesByCampo = '/api/cuarteles/campo/{campo}';

  // Empleados
  static const String empleados = '/api/empleados';
  static const String empleadoByDni = '/api/empleados/dni/{dni}';
  static const String empleadoByEmpleado = '/api/empleados/empleado/{empleado}';
  static const String empleadoExiste = '/api/empleados/existe/{codigo}';

  // Equipos
  static const String equipos = '/api/equipos';
  static const String equipoById = '/api/equipos/{codEquipo}';
  static const String equiposByTransportista =
      '/api/equipos/transportista/{codTransp}';
  static const String equipoByPlaca = '/api/equipos/placa/{placa}';

  // Guias
  static const String guias = '/api/guias';
  static const String guiaById = '/api/guias/{id}';
  static const String guiasByUsuario = '/api/guias/usuario/{idUsuario}';
  static const String guiaCorrelativo = '/api/guias/correlativo';

  // Jirones
  static const String jirones = '/api/jirones';
  static const String jironById = '/api/jirones/{jiron}';
  static const String jironesByCampo = '/api/jirones/campo/{campo}';

  // Transportistas
  static const String transportistas = '/api/transportistas';
  static const String transportistaByCodigo =
      '/api/transportistas/codigo/{codTransp}';
  static const String transportistaByRuc = '/api/transportistas/ruc/{ruc}';

  // Usuarios
  static const String usuarios = '/api/usuarios';
  static const String usuarioById = '/api/usuarios/{id}';
  static const String registroUsuario = '/api/usuarios/registro';
}
