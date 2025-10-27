import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_platform/features/shifts/domain/entities/shift.dart';
import 'package:mini_platform/features/shifts/domain/repositories/shift_repository.dart';
import 'package:mini_platform/features/shifts/presentation/widgets/search_text_field.dart';
import 'package:mini_platform/features/shifts/presentation/widgets/shift_table.dart';
import 'package:mini_platform/features/shifts/utils/shift_strings.dart';

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
  bool _searching = false;

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
      setState(() => _searching = true);
      final filtered =
          await widget.repo.searchByColaborador(searchController.text);
      if (!mounted) return;
      setState(() {
        _items = filtered;
        _searching = false;
      });
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

    final hasQuery = searchController.text.trim().isNotEmpty;
    final noResults = hasQuery && _items.isEmpty;

    return Column(
      children: [
        SearchTextField(controller: searchController),
        const SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ShiftTable(items: _items),
                ),
              ),
              // No coincidences
              if (hasQuery && (_searching || noResults))
                IgnorePointer(
                  ignoring: true,
                  child: Builder(
                    builder: (context) {
                      final insets =
                          MediaQuery.of(context).viewInsets.bottom; // teclado
                      final safe =
                          MediaQuery.of(context).padding.bottom; // notch
                      final bottomPad =
                          (insets > 0 ? insets : safe + 24.0); // dinámico

                      final msg = _searching
                          ? ShiftStrings.noResults
                          : ShiftStrings.emptyList;

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: bottomPad),
                          child: Text(
                            msg,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              // Empty list
              if (!hasQuery && _items.isEmpty)
                const Text(ShiftStrings.emptyList),
            ],
          ),
        ),
      ],
    );
  }
}
