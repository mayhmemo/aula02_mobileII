import 'dart:convert';

import 'package:todo_refatoracao_baguncado/core/errors/app_error.dart';
import 'package:todo_refatoracao_baguncado/core/network/http_client.dart';
import 'package:todo_refatoracao_baguncado/data/models/todo_model.dart';

class TodoRemoteDataSource {
  final HttpClient _client;

  TodoRemoteDataSource(this._client);

  Future<List<TodoModel>> fetchTodos() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=20');
    final res = await _call(() => _client.get(uri), 'Não foi possível buscar as tarefas.');

    _ensureSuccess(res);

    final data = _decodeList(res.body);
    return data.map((e) => TodoModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<TodoModel> addTodo(String title) async {
    // JSONPlaceholder não cria de verdade, mas responde com um id
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    final res = await _call(
      () => _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'completed': false}),
      ),
      'Não foi possível criar a tarefa.',
    );

    _ensureSuccess(res);

    final obj = _decodeMap(res.body);
    return TodoModel.fromJson(obj);
  }

  Future<void> updateCompleted({required int id, required bool completed}) async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
    final res = await _call(
      () => _client.patch(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'completed': completed}),
      ),
      'Não foi possível atualizar a tarefa.',
    );

    _ensureSuccess(res);
  }

  Future<HttpResponse> _call(Future<HttpResponse> Function() fn, String message) async {
    try {
      return await fn();
    } catch (error) {
      if (error is AppError) rethrow;
      throw NetworkError(message, error);
    }
  }

  void _ensureSuccess(HttpResponse res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ServerError(res.statusCode);
    }
  }

  List<dynamic> _decodeList(String body) {
    try {
      return jsonDecode(body) as List;
    } on FormatException catch (error) {
      throw ParsingError('Resposta inválida ao buscar tarefas.', error);
    }
  }

  Map<String, dynamic> _decodeMap(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } on FormatException catch (error) {
      throw ParsingError('Resposta inválida ao criar tarefa.', error);
    }
  }
}
