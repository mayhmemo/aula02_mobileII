import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_refatoracao_baguncado/core/errors/app_error.dart';

class TodoLocalDataSource {
  static const _kLastSync = 'todos_last_sync_iso';

  Future<void> saveLastSync(DateTime dt) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kLastSync, dt.toIso8601String());
    } catch (error) {
      throw StorageError('Falha ao salvar última sincronização local.', error);
    }
  }

  Future<DateTime?> getLastSync() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final s = prefs.getString(_kLastSync);
      if (s == null || s.isEmpty) return null;
      return DateTime.tryParse(s);
    } catch (error) {
      throw StorageError('Falha ao ler última sincronização local.', error);
    }
  }
}
