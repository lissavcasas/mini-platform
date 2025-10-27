import 'package:flutter/material.dart';
import 'package:mini_platform/features/shifts/domain/entities/shift.dart';
import 'package:mini_platform/features/shifts/domain/entities/shift_calculations.dart';
import 'package:mini_platform/features/shifts/utils/shift_strings.dart';

class ShiftTable extends StatelessWidget {
  const ShiftTable({super.key, required this.items});
  final List<Shift> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text(ShiftStrings.columnColaborador)),
          DataColumn(label: Text(ShiftStrings.columnFecha)),
          DataColumn(label: Text(ShiftStrings.columnTurno)),
          DataColumn(label: Text(ShiftStrings.columnInicio)),
          DataColumn(label: Text(ShiftStrings.columnFin)),
          DataColumn(label: Text(ShiftStrings.columnTiempoTrabajado)),
          DataColumn(label: Text(ShiftStrings.columnTiempoTeorico)),
          DataColumn(label: Text(ShiftStrings.columnHorasExtra)),
        ],
        rows: items.map((j) {
          return DataRow(cells: [
            DataCell(Text(j.colaborador)),
            DataCell(Text(j.fecha.toString())),
            DataCell(Text('${j.inicioTeorico}-${j.finTeorico}')),
            DataCell(Text(j.inicioReal)),
            DataCell(Text(j.finReal)),
            DataCell(Text(j.tiempoTrabajadoHMM)),
            DataCell(Text(j.tiempoTeoricoHMM)),
            DataCell(Text(j.horasExtraHMM)),
          ]);
        }).toList(),
      ),
    );
  }
}
