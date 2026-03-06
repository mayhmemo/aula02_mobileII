import 'package:todo_refatoracao_baguncado/domain/entities/todo.dart';

class TodoState {
  final bool isLoading;
  final List<Todo> todos;
  final String? error;
  final String? lastSyncLabel;

  const TodoState({
    this.isLoading = false,
    this.todos = const [],
    this.error,
    this.lastSyncLabel
  });

  TodoState copyWith({
    bool? isLoading,
    List<Todo>? todos,
    String? error,
    String? lastSyncLabel
  }) {
    return TodoState(
      isLoading: isLoading ?? this.isLoading,
      todos: todos ?? this.todos,
      error: error,
      lastSyncLabel: lastSyncLabel ?? this.lastSyncLabel
    );
  }
}