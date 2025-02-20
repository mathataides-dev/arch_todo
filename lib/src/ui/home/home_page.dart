import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../config/di_dependencies.dart';
import '../../domain/dtos/to_do_dto.dart';
import '../../domain/entities/to_do_entity.dart';
import '../../utils/components/app_snack_bars.dart';
import 'components/to_do_component.dart';
import 'viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = di.get<HomeViewmodel>();
  final scrollController = ScrollController();
  final List<ToDoEntity> toDos = [];

  void _fetchListenable() {
    if (viewModel.homeFetchCommand.isSuccess) {
      final snapshot =
          viewModel.homeFetchCommand.value as SuccessCommand<List<ToDoEntity>>;
      toDos
        ..clear()
        ..addAll(snapshot.value);
    } else if (viewModel.homeFetchCommand.isFailure) {
      final error = viewModel.homeFetchCommand.value as FailureCommand;
      ScaffoldMessenger.of(context) //
      .showSnackBar(AppSnackBars.errorSnackBar(error.error));
    }
  }

  void _postListenable() {
    if (viewModel.homePostCommand.isSuccess) {
      final snapshot =
          viewModel.homePostCommand.value as SuccessCommand<ToDoEntity>;
      toDos.add(snapshot.value);
    } else if (viewModel.homePostCommand.isFailure) {
      final error = viewModel.homePostCommand.value as FailureCommand;
      ScaffoldMessenger.of(context) //
      .showSnackBar(AppSnackBars.errorSnackBar(error.error));
    }
  }

  void _deleteListenable() {
    if (viewModel.homeDeleteCommand.isSuccess) {
      final snapshot =
          viewModel.homeDeleteCommand.value as SuccessCommand<ToDoEntity>;
      toDos.remove(snapshot.value);
      ScaffoldMessenger.of(context) //
      .showSnackBar(
        AppSnackBars.successSnackBar('${snapshot.value.title} removed'),
      );
    } else if (viewModel.homeDeleteCommand.isFailure) {
      final error = viewModel.homeDeleteCommand.value as FailureCommand;
      ScaffoldMessenger.of(context) //
      .showSnackBar(AppSnackBars.errorSnackBar(error.error));
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.homeFetchCommand.addListener(_fetchListenable);
    viewModel.homePostCommand.addListener(_postListenable);
    viewModel.homeDeleteCommand.addListener(_deleteListenable);
  }

  @override
  void dispose() {
    viewModel.homeFetchCommand.removeListener(_fetchListenable);
    viewModel.homePostCommand.removeListener(_postListenable);
    viewModel.homeDeleteCommand.removeListener(_deleteListenable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo List')),
      body: Center(
        child: ListenableBuilder(
          listenable: Listenable.merge([
            viewModel.homeFetchCommand,
            viewModel.homePostCommand,
            viewModel.homeDeleteCommand,
          ]),
          builder: (context, _) {
            final isRunning =
                viewModel.homeFetchCommand.isRunning ||
                viewModel.homePostCommand.isRunning ||
                viewModel.homeDeleteCommand.isRunning;

            return Column(
              children: [
                isRunning
                    ? const CircularProgressIndicator.adaptive()
                    : SingleChildScrollView(
                      controller: scrollController,
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: toDos.length,
                        itemBuilder: (_, i) {
                          final toDo = toDos[i];
                          return ToDoComponent(
                            key: Key(toDo.hashCode.toString()),
                            toDo: toDo,
                            onDismissed: (direction) {
                              viewModel.homeDeleteCommand.execute(toDo);
                            },
                            onChanged: (value) {
                              toDos.remove(toDo);
                              viewModel.homePostCommand.execute(
                                ToDoDTO(
                                  title: toDo.title,
                                  description: toDo.description,
                                  isDone: !toDo.isDone,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                if (!isRunning)
                  FloatingActionButton(
                    onPressed: () {
                      Routefly.push(routePaths.createToDo).then((value) {
                        if (value == true) viewModel.homeFetchCommand.execute();
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
