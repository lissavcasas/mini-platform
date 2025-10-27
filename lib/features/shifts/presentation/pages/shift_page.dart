import 'package:flutter/material.dart';
import 'package:mini_platform/features/shifts/data/repositories/shift_repository_impl_local.dart';
import 'package:mini_platform/features/shifts/domain/repositories/shift_repository.dart';
import 'package:mini_platform/features/shifts/presentation/views/shift_view.dart';
import 'package:mini_platform/features/shifts/utils/shift_strings.dart';

class ShiftPage extends StatelessWidget {
  const ShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Dependecy Injection
    final ShiftRepository repo = ShiftRepositoryImplLocal();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(ShiftStrings.pageTitle),
      ),
      body: ShiftView(repo: repo),
    );
  }
}
