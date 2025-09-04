import 'dart:convert';

import 'package:mini_platform/features/shifts/data/mock/data_mock.dart';
import 'package:mini_platform/features/shifts/domain/entities/shift.dart';
import 'package:mini_platform/features/shifts/domain/repositories/shift_repository.dart';

class ShiftRepositoryImplLocal implements ShiftRepository {
  List<Shift>? _cache;

  Future<List<Shift>> _loadShifts() async {
    _cache ??= (jsonDecode(dataMock) as List)
        .cast<Map<String, dynamic>>()
        .map(Shift.fromJson)
        .toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));
    return _cache!;
  }

  @override
  Future<List<Shift>> getAll() async => List<Shift>.from(await _loadShifts());

  @override
  Future<List<Shift>> searchByColaborador(String query) async {
    final all = await getAll();
    final q = query.trim().toUpperCase();
    if (q.isEmpty) return all;
    return all.where((j) => j.colaborador.toUpperCase().contains(q)).toList();
  }
}
