import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_platform/jornada.dart';
import 'package:mini_platform/source.dart';

class JornadaTableView extends StatefulWidget {
  const JornadaTableView({super.key});

  @override
  State<JornadaTableView> createState() => _JornadaTableViewState();
}

class _JornadaTableViewState extends State<JornadaTableView> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final decoded = jsonDecode(sourceJson) as List;
    final jornadas = decoded.map((e) => Jornada.fromJson(e)).toList();

    // Sort DESC by fecha
    jornadas.sort((a, b) => b.fecha.compareTo(a.fecha));

    void handleSearch(String query) {
      final search = query.toUpperCase();
      // final searchController = searchController.text();

      for (var jornada in jornadas) {
        if (jornada.colaborador.toUpperCase().contains(search)) {
          print("Response: ${jornada.colaborador}");
        }
      }
    }

    return Column(
      children: [
        // Buscador
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: handleSearch,
        ),
        const SizedBox(height: 10),
        // Tabla
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Colaborador')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Turno teórico (HH:mm–HH:mm)')),
              DataColumn(label: Text('Inicio de jornada')),
              DataColumn(label: Text('Fin de jornada')),
            ],
            rows: jornadas
                .map(
                  (jornada) => DataRow(
                    cells: [
                      DataCell(Text(jornada.colaborador)),
                      DataCell(Text(jornada.fecha)),
                      DataCell(Text(jornada.inicioTeorico)),
                      DataCell(Text(jornada.inicioReal)),
                      DataCell(Text(jornada.finReal)),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
