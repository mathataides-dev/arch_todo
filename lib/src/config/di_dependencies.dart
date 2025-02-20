import 'package:auto_injector/auto_injector.dart';

final di = AutoInjector();

void setupDependencies() {
  di.commit();
}
