class Jornada {
  final String colaborador;
  final String fecha; //DateTime
  final String inicioTeorico;
  final String finTeorico;
  final String inicioReal;
  final String finReal;

  Jornada({
    required this.colaborador,
    required this.fecha,
    required this.inicioTeorico,
    required this.finTeorico,
    required this.inicioReal,
    required this.finReal,
  });

  factory Jornada.fromJson(Map<String, dynamic> json) {
    return Jornada(
      colaborador: json['colaborador'],
      fecha: json['fecha'], //DateTime.parse(json['fecha']),
      inicioTeorico: json['inicioTeorico'],
      finTeorico: json['finTeorico'],
      inicioReal: json['inicioReal'],
      finReal: json['finReal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colaborador': colaborador,
      'fecha': fecha, //.toIso8601String().split('T')[0], // yyyy-MM-dd
      'inicioTeorico': inicioTeorico,
      'finTeorico': finTeorico,
      'inicioReal': inicioReal,
      'finReal': finReal,
    };
  }
}
