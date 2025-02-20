import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/to_do_repository/to_do_repository.dart';
import '../../../domain/dtos/to_do_dto.dart';
import '../../../domain/entities/to_do_entity.dart';

class HomeViewmodel extends ChangeNotifier {
  final ToDoRepository _toDoRepository;
  HomeViewmodel(this._toDoRepository) {
    homeFetchCommand.execute();
  }

  late final homeFetchCommand = Command0(_fetchToDos);
  late final homePostCommand = Command1(_postToDo);
  late final homeDeleteCommand = Command1(_deleteToDo);

  AsyncResult<List<ToDoEntity>> _fetchToDos() {
    return _toDoRepository.fetchToDos();
  }

  AsyncResult<ToDoEntity> _postToDo(ToDoDTO toDoDTO) async {
    return _toDoRepository
        .deleteToDo(
          ToDoEntity(
            title: toDoDTO.title,
            description: toDoDTO.description,
            isDone: !toDoDTO.isDone,
          ),
        ) //
        .flatMap((_) => _toDoRepository.postToDo(toDoDTO));
  }

  AsyncResult<ToDoEntity> _deleteToDo(ToDoEntity toDo) {
    return _toDoRepository
        .deleteToDo(toDo)
        .fold((success) => Success(toDo), (error) => Failure(error));
  }
}
