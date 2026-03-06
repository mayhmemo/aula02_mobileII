import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_refatoracao_baguncado/presentation/ui/app_root.dart';
import 'package:todo_refatoracao_baguncado/presentation/viewmodels/todo_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
      ],
      child: const AppRoot(),
    ),
  );
}
