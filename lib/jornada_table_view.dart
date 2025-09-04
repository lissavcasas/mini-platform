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

  late final List<Jornada> _allJornadas;
  late List<Jornada> _filteredJornadas;

  @override
  void initState() {
    super.initState();

    // Trae data mock (source)
    final decoded = jsonDecode(sourceJson) as List;

    // Ordena por fecha DESC
    _allJornadas = decoded.map((e) => Jornada.fromJson(e)).toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));
    _filteredJornadas = List.of(_allJornadas);

    // Escucha cambios en el controller
    searchController.addListener(handleSearch);
  }

  void handleSearch() {
    final search = searchController.text.trim().toUpperCase();

    setState(() {
      if (search.isEmpty) {
        _filteredJornadas = List.of(_allJornadas);
      } else {
        _filteredJornadas = _allJornadas.where((jornada) {
          final worker = jornada.colaborador.toUpperCase();
          return worker.contains(search);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(handleSearch);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buscador
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar colaborador...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 10),
        // Tabla
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Colaborador')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Turno teórico (HH:mm–HH:mm)')),
                DataColumn(label: Text('Inicio de jornada')),
                DataColumn(label: Text('Fin de jornada')),
              ],
              rows: _filteredJornadas.map((jornada) {
                return DataRow(
                  cells: [
                    DataCell(Text(jornada.colaborador)),
                    DataCell(Text(jornada.fecha)),
                    DataCell(
                        Text('${jornada.inicioTeorico}–${jornada.finTeorico}')),
                    DataCell(Text(jornada.inicioReal)),
                    DataCell(Text(jornada.finReal)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
