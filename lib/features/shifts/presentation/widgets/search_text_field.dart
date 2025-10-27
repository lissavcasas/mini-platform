import 'package:flutter/material.dart';
import 'package:mini_platform/features/shifts/utils/shift_strings.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: ShiftStrings.searchHint,
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
