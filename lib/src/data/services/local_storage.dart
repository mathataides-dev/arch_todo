import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/exceptions/exceptions.dart';

class LocalStorage {
  AsyncResult<String> fetch(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      if (shared.containsKey(key)) return Success(shared.getString(key)!);
      return Failure(LocalStorageException('Not found data'));
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<List<String>> fetchAll(String keyPrefix) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final Set<String> keys = shared.getKeys();
      final List<String> registers = [];

      for (final key in keys) {
        if (key.contains(keyPrefix)) registers.add(shared.getString(key)!);
      }

      return Success(registers);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<String> post(String key, String value) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.setString(key, value);
      return Success(key);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }

  AsyncResult<Unit> delete(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.remove(key);
      return const Success(unit);
    } catch (e, s) {
      return Failure(LocalStorageException(e.toString(), s));
    }
  }
}
