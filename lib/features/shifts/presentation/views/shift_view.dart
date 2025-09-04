import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_platform/features/shifts/domain/entities/shift.dart';
import 'package:mini_platform/features/shifts/domain/repositories/shift_repository.dart';
import 'package:mini_platform/features/shifts/presentation/widgets/search_text_field.dart';
import 'package:mini_platform/features/shifts/presentation/widgets/shift_table.dart';

class ShiftView extends StatefulWidget {
  const ShiftView({super.key, required this.repo});
  final ShiftRepository repo;

  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends State<ShiftView> {
  final TextEditingController searchController = TextEditingController();
  List<Shift> _items = [];
  bool _loading = true;
  String? _error;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _load();
    searchController.addListener(_onQueryChanged);
  }

  Future<void> _load() async {
    try {
      final data = await widget.repo.getAll();
      setState(() {
        _items = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      final filtered =
          await widget.repo.searchByColaborador(searchController.text);
      if (!mounted) return;
      setState(() => _items = filtered);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.removeListener(_onQueryChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Text('Error: $_error'));

    return Column(
      children: [
        SearchTextField(controller: searchController),
        const SizedBox(height: 10),
        Expanded(child: ShiftTable(items: _items)),
      ],
    );
  }
}
