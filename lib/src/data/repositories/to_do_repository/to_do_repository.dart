import 'package:result_dart/result_dart.dart';

import '../../../domain/dtos/to_do_dto.dart';
import '../../../domain/entities/to_do_entity.dart';

abstract interface class ToDoRepository {
  AsyncResult<List<ToDoEntity>> fetchToDos();
  AsyncResult<ToDoEntity> postToDo(ToDoDTO toDoDTO);
  AsyncResult<Unit> deleteToDo(ToDoEntity toDoEntity);
}
