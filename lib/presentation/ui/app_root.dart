import 'package:flutter/material.dart';
import 'package:todo_refatoracao_baguncado/presentation/pages/todos_page.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Refatoração',
      theme: ThemeData(useMaterial3: true),
      home: const TodosPage(),
    );
  }
}
