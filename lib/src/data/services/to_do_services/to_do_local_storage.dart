import 'package:result_dart/result_dart.dart';

import '../../../domain/entities/to_do_entity.dart';
import '../local_storage.dart';

const _toDoKey = '_toDoKey_';

class ToDoLocalStorage {
  final LocalStorage _localStorage;
  ToDoLocalStorage(this._localStorage);

  AsyncResult<List<ToDoEntity>> fetchToDos() {
    return _localStorage
        .fetchAll(_toDoKey) //
        .map(
          (jsonToDos) => jsonToDos.map((p) => ToDoEntity.fromJson(p)).toList(),
        );
  }

  AsyncResult<ToDoEntity> postToDo(ToDoEntity toDoEntity) {
    return _localStorage //
        .post('$_toDoKey${toDoEntity.toJson()}', toDoEntity.toJson())
        .pure(toDoEntity);
  }

  AsyncResult<Unit> deleteToDo(ToDoEntity toDoEntity) {
    return _localStorage.delete('$_toDoKey${toDoEntity.toJson()}');
  }
}
