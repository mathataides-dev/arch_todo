import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:routefly/routefly.dart';

import '../../config/di_dependencies.dart';
import '../../domain/dtos/to_do_dto.dart';
import '../../domain/entities/to_do_entity.dart';
import '../../utils/components/app_snack_bars.dart';
import '../../utils/mixins/validators_mixin.dart';
import 'viewmodel/create_to_do_viewmodel.dart';

class CreateToDoPage extends StatefulWidget {
  const CreateToDoPage({super.key});

  @override
  State<CreateToDoPage> createState() => _CreateToDoPageState();
}

class _CreateToDoPageState extends State<CreateToDoPage> with ValidatorsMixin {
  final viewModel = di.get<CreateToDoViewmodel>();
  final formKey = GlobalKey<FormState>();
  final toDoDTO = ToDoDTO();

  void _postListenable() {
    if (viewModel.createToDoCommand.isSuccess) {
      final snapshot =
          viewModel.createToDoCommand.value as SuccessCommand<ToDoEntity>;

      ScaffoldMessenger.of(context) //
      .showSnackBar(
        AppSnackBars.successSnackBar('${snapshot.value.title} created!'),
      );

      Routefly.pop(context, result: true);
    } else if (viewModel.createToDoCommand.isFailure) {
      final error = viewModel.createToDoCommand.value as FailureCommand;
      ScaffoldMessenger.of(context) //
      .showSnackBar(AppSnackBars.errorSnackBar(error.error));
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.createToDoCommand.addListener(_postListenable);
  }

  @override
  void dispose() {
    viewModel.createToDoCommand.removeListener(_postListenable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create ToDo'),
        leading: ListenableBuilder(
          listenable: viewModel.createToDoCommand,
          builder: (context, _) {
            return BackButton(
              onPressed: () {
                if (viewModel.createToDoCommand.isRunning) return;
                Routefly.pop(context, result: false);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: ListenableBuilder(
            listenable: viewModel.createToDoCommand,
            builder: (context, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    enabled: !viewModel.createToDoCommand.isRunning,
                    textInputAction: TextInputAction.go,
                    validator: isNotEmpty,
                    onChanged: toDoDTO.setTitle,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      enabled: !viewModel.createToDoCommand.isRunning,
                      textInputAction: TextInputAction.go,
                      validator: isNotEmpty,
                      onChanged: toDoDTO.setDescription,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed:
                          viewModel.createToDoCommand.isRunning
                              ? null
                              : () {
                                if (formKey.currentState!.validate()) {
                                  viewModel.createToDoCommand.execute(toDoDTO);
                                }
                              },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
