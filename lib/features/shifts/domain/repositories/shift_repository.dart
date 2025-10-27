import 'package:mini_platform/features/shifts/domain/entities/shift.dart';

abstract class ShiftRepository {
  Future<List<Shift>> getAll();
  Future<List<Shift>> searchByColaborador(String query);
}
