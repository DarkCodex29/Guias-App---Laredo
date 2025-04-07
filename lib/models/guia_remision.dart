class GuiaRemision {
  final String fechaEmision;
  final String serieCorrelativo;
  final int cantidadItems;
  final String horaEmision;
  final Conductor? conductor;
  final Vehiculo? vehiculo;
  final Remitente remitente;
  final Destinatario destinatario;
  final Envio envio;
  final String? observaciones;
  final List<Item> items;

  GuiaRemision({
    required this.fechaEmision,
    required this.serieCorrelativo,
    required this.cantidadItems,
    required this.horaEmision,
    this.conductor,
    this.vehiculo,
    required this.remitente,
    required this.destinatario,
    required this.envio,
    this.observaciones,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        'fechaEmision': fechaEmision,
        'serieCorrelativo': serieCorrelativo,
        'cantidadItems': cantidadItems,
        'horaEmision': horaEmision,
        'conductor': conductor?.toJson(),
        'vehiculo': vehiculo?.toJson(),
        'remitente': remitente.toJson(),
        'destinatario': destinatario.toJson(),
        'envio': envio.toJson(),
        'observaciones': observaciones,
        'items': items.map((item) => item.toJson()).toList(),
      };
}

class Conductor {
  final String numeroDocumento;
  final String tipoDocumento;
  final String nombres;
  final String apellidos;
  final String licencia;

  Conductor({
    required this.numeroDocumento,
    required this.tipoDocumento,
    required this.nombres,
    required this.apellidos,
    required this.licencia,
  });

  Map<String, dynamic> toJson() => {
        'numeroDocumento': numeroDocumento,
        'tipoDocumento': tipoDocumento,
        'nombres': nombres,
        'apellidos': apellidos,
        'licencia': licencia,
      };
}

class Vehiculo {
  final String placa;

  Vehiculo({required this.placa});

  Map<String, dynamic> toJson() => {
        'placa': placa,
      };
}

class Remitente {
  final String razonSocial;
  final String tipoDocumento;
  final String numeroDocumento;
  final String ubigeo;
  final String direccion;
  final String? urbanizacion;
  final String provincia;
  final String departamento;
  final String distrito;

  Remitente({
    required this.razonSocial,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.ubigeo,
    required this.direccion,
    this.urbanizacion,
    required this.provincia,
    required this.departamento,
    required this.distrito,
  });

  Map<String, dynamic> toJson() => {
        'razonSocial': razonSocial,
        'tipoDocumento': tipoDocumento,
        'numeroDocumento': numeroDocumento,
        'ubigeo': ubigeo,
        'direccion': direccion,
        'urbanizacion': urbanizacion,
        'provincia': provincia,
        'departamento': departamento,
        'distrito': distrito,
      };
}

class Destinatario {
  final String razonSocial;
  final String tipoDocumento;
  final String numeroDocumento;
  final String ubigeo;
  final String direccion;
  final String? urbanizacion;
  final String provincia;
  final String departamento;
  final String distrito;

  Destinatario({
    required this.razonSocial,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.ubigeo,
    required this.direccion,
    this.urbanizacion,
    required this.provincia,
    required this.departamento,
    required this.distrito,
  });

  Map<String, dynamic> toJson() => {
        'razonSocial': razonSocial,
        'tipoDocumento': tipoDocumento,
        'numeroDocumento': numeroDocumento,
        'ubigeo': ubigeo,
        'direccion': direccion,
        'urbanizacion': urbanizacion,
        'provincia': provincia,
        'departamento': departamento,
        'distrito': distrito,
      };
}

class Envio {
  final String motivoTraslado;
  final String descripcionMotivo;
  final double pesoBruto;
  final String unidadMedida;
  final String modalidadTraslado;
  final String fechaInicioTraslado;
  final Transportista? transportista;
  final PuntoTraslado puntoPartida;
  final PuntoTraslado puntoLlegada;

  Envio({
    required this.motivoTraslado,
    required this.descripcionMotivo,
    required this.pesoBruto,
    required this.unidadMedida,
    required this.modalidadTraslado,
    required this.fechaInicioTraslado,
    this.transportista,
    required this.puntoPartida,
    required this.puntoLlegada,
  });

  Map<String, dynamic> toJson() => {
        'motivoTraslado': motivoTraslado,
        'descripcionMotivo': descripcionMotivo,
        'pesoBruto': pesoBruto,
        'unidadMedida': unidadMedida,
        'modalidadTraslado': modalidadTraslado,
        'fechaInicioTraslado': fechaInicioTraslado,
        'transportista': transportista?.toJson(),
        'puntoPartida': puntoPartida.toJson(),
        'puntoLlegada': puntoLlegada.toJson(),
      };
}

class Transportista {
  final String razonSocial;
  final String ruc;

  Transportista({
    required this.razonSocial,
    required this.ruc,
  });

  Map<String, dynamic> toJson() => {
        'razonSocial': razonSocial,
        'ruc': ruc,
      };
}

class PuntoTraslado {
  final String ubigeo;
  final String direccion;
  final String? urbanizacion;
  final String provincia;
  final String departamento;
  final String distrito;

  PuntoTraslado({
    required this.ubigeo,
    required this.direccion,
    this.urbanizacion,
    required this.provincia,
    required this.departamento,
    required this.distrito,
  });

  Map<String, dynamic> toJson() => {
        'ubigeo': ubigeo,
        'direccion': direccion,
        'urbanizacion': urbanizacion,
        'provincia': provincia,
        'departamento': departamento,
        'distrito': distrito,
      };
}

class Item {
  final int numero;
  final String unidadMedida;
  final String descripcionUnidad;
  final double cantidad;
  final String descripcion;
  final String? codigo;
  final String? codigoSunat;

  Item({
    required this.numero,
    required this.unidadMedida,
    required this.descripcionUnidad,
    required this.cantidad,
    required this.descripcion,
    this.codigo,
    this.codigoSunat,
  });

  Map<String, dynamic> toJson() => {
        'numero': numero,
        'unidadMedida': unidadMedida,
        'descripcionUnidad': descripcionUnidad,
        'cantidad': cantidad,
        'descripcion': descripcion,
        'codigo': codigo,
        'codigoSunat': codigoSunat,
      };
}
