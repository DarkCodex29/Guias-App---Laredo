class VistaCampo {
  final String campo;
  final String descCampo;

  VistaCampo({
    required this.campo,
    required this.descCampo,
  });

  factory VistaCampo.fromJson(Map<String, dynamic> json) {
    return VistaCampo(
      campo: json['campo']?.toString() ?? '',
      descCampo: json['descCampo']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campo': campo,
      'descCampo': descCampo,
    };
  }
}
