import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repositories/to_do_repository/to_do_repository.dart';
import '../../../domain/dtos/to_do_dto.dart';
import '../../../domain/entities/to_do_entity.dart';

class CreateToDoViewmodel extends ChangeNotifier {
  final ToDoRepository _toDoRepository;
  CreateToDoViewmodel(this._toDoRepository);

  late final createToDoCommand = Command1(_postToDo);

  AsyncResult<ToDoEntity> _postToDo(ToDoDTO toDoDTO) async {
    return _toDoRepository.postToDo(toDoDTO);
  }
}
