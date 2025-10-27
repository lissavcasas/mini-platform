class Shift {
  final String colaborador;
  final String fecha;
  final String inicioTeorico;
  final String finTeorico;
  final String inicioReal;
  final String finReal;

  Shift({
    required this.colaborador,
    required this.fecha,
    required this.inicioTeorico,
    required this.finTeorico,
    required this.inicioReal,
    required this.finReal,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      colaborador: json['colaborador'],
      fecha: json['fecha'],
      inicioTeorico: json['inicioTeorico'],
      finTeorico: json['finTeorico'],
      inicioReal: json['inicioReal'],
      finReal: json['finReal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colaborador': colaborador,
      'fecha': fecha,
      'inicioTeorico': inicioTeorico,
      'finTeorico': finTeorico,
      'inicioReal': inicioReal,
      'finReal': finReal,
    };
  }
}
