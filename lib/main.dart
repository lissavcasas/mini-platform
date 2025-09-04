import 'package:flutter/material.dart';
import 'package:mini_platform/jornada_table_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jornadas'),
        ),
        body: const JornadaTableView(),
      ),
    );
  }
}
