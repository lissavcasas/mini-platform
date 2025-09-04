import 'shift.dart';

extension ShiftCalculations on Shift {
  DateTime _combine(String yyyymmdd, String hhmm) {
    final d = DateTime.parse(yyyymmdd);
    final p = hhmm.split(':');
    return DateTime(d.year, d.month, d.day, int.parse(p[0]), int.parse(p[1]));
  }

  Duration _range(String date, String start, String end) {
    var s = _combine(date, start);
    var e = _combine(date, end);
    if (e.isBefore(s)) e = e.add(const Duration(days: 1)); // cruza medianoche
    return e.difference(s);
  }

  String _fmt(Duration d) {
    final m = d.inMinutes;
    final h = m ~/ 60;
    final mm = m % 60;
    return '$h:${mm.toString().padLeft(2, '0')}';
  }

  Duration get tiempoTrabajado => _range(fecha, inicioReal, finReal);
  Duration get tiempoTeorico => _range(fecha, inicioTeorico, finTeorico);

  Duration get horasExtra {
    final diff = tiempoTrabajado - tiempoTeorico;
    return diff.isNegative ? Duration.zero : diff;
  }

  String get tiempoTrabajadoHMM => _fmt(tiempoTrabajado);
  String get tiempoTeoricoHMM => _fmt(tiempoTeorico);
  String get horasExtraHMM => _fmt(horasExtra);
}
