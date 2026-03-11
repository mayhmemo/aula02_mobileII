import 'package:flutter/foundation.dart';
import 'package:todo_refatoracao_baguncado/core/errors/app_error.dart';
import 'package:todo_refatoracao_baguncado/data/repositories/todo_repository_impl.dart';
import 'package:todo_refatoracao_baguncado/presentation/viewmodels/todo_state.dart';

class TodoViewModel {
  final TodoRepositoryImpl repository;

  final ValueNotifier<TodoState> state = ValueNotifier(const TodoState());

  TodoViewModel(this.repository);

  Future<void> loadTodos({bool forceRefresh = false}) async {
    state.value = state.value.copyWith(isLoading: true, error: null);

    try {
      final result = await repository.fetchTodos(forceRefresh: forceRefresh);
      state.value = state.value.copyWith(todos: result.todos, lastSyncLabel: result.lastSyncLabel);
    } on AppError catch (error) {
      state.value = state.value.copyWith(error: 'Falha ao carregar: ${error.message}');
    } catch (e) {
      state.value = state.value.copyWith(error: 'Falha ao carregar: $e');
    } finally {
      state.value = state.value.copyWith(isLoading: false);
    }
  }

  Future<void> addTodo(String title) async {
    // validação mínima fica no VM (ok)
    if (title.trim().isEmpty) {
      state.value = state.value.copyWith(error: 'Título não pode ser vazio.');
      return;
    }

    try {
      final created = await repository.addTodo(title);
      final todos = state.value.todos;
      todos.insert(0, created);
      state.value = state.value.copyWith(todos: todos);
    } on AppError catch (error) {
      state.value = state.value.copyWith(error: 'Falha ao adicionar: ${error.message}');
    } catch (e) {
      state.value = state.value.copyWith(error: 'Falha ao adicionar: $e');
    }
  }

  Future<void> toggleCompleted(int id, bool completed) async {
    final todos = state.value.todos;
    final idx = todos.indexWhere((t) => t.id == id);
    if (idx < 0) return;

    final old = todos[idx];
    todos[idx] = old.copyWith(completed: completed);
    state.value = state.value.copyWith(todos: todos);

    try {
      await repository.updateCompleted(id: id, completed: completed);
    } on AppError catch (error) {
      todos[idx] = old;
      state.value = state.value.copyWith(todos: todos, error: 'Falha ao atualizar: ${error.message}');
    } catch (e) {
      // rollback
      todos[idx] = old;
      state.value = state.value.copyWith(todos: todos, error: 'Falha ao atualizar: $e');
    }
  }
}
