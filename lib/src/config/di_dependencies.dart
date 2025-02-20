import 'package:auto_injector/auto_injector.dart';

import '../data/repositories/to_do_repository/to_do_repository.dart';
import '../data/repositories/to_do_repository/to_do_repository_i.dart';
import '../data/services/local_storage.dart';
import '../data/services/to_do_services/to_do_local_storage.dart';
import '../ui/create_to_do/viewmodel/create_to_do_viewmodel.dart';
import '../ui/home/viewmodel/home_viewmodel.dart';

final di = AutoInjector();

void setupDependencies() {
  di.addLazySingleton<ToDoRepository>(ToDoRepositoryI.new);
  di.addLazySingleton(LocalStorage.new);
  di.addLazySingleton(ToDoLocalStorage.new);
  di.addLazySingleton(HomeViewmodel.new);
  di.addLazySingleton(CreateToDoViewmodel.new);

  di.commit();
}
