import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'app_widget.route.dart';

part 'app_widget.g.dart';

@Main('lib/src/ui/')
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ToDo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.home,
      ),
    );
  }
}
