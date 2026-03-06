import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_refatoracao_baguncado/data/repositories/todo_repository_impl.dart';
import 'package:todo_refatoracao_baguncado/presentation/ui/app_root.dart';
import 'package:todo_refatoracao_baguncado/presentation/viewmodels/todo_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => TodoViewModel(TodoRepositoryImpl())),
      ],
      child: const AppRoot(),
    ),
  );
}
