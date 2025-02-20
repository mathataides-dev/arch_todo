import 'package:result_dart/result_dart.dart';

import '../../../domain/dtos/to_do_dto.dart';
import '../../../domain/entities/to_do_entity.dart';
import '../../services/to_do_services/to_do_local_storage.dart';
import 'to_do_repository.dart';

class ToDoRepositoryI implements ToDoRepository {
  final ToDoLocalStorage _toDoLocalStorage;
  ToDoRepositoryI(this._toDoLocalStorage);

  @override
  AsyncResult<List<ToDoEntity>> fetchToDos() {
    return _toDoLocalStorage.fetchToDos();
  }

  @override
  AsyncResult<ToDoEntity> postToDo(ToDoDTO toDoDTO) {
    return _toDoLocalStorage //
        .postToDo //
        (
          ToDoEntity(
            title: toDoDTO.title,
            description: toDoDTO.description,
            isDone: toDoDTO.isDone,
          ),
        );
  }

  @override
  AsyncResult<Unit> deleteToDo(ToDoEntity toDoEntity) {
    return _toDoLocalStorage.deleteToDo(toDoEntity);
  }
}
