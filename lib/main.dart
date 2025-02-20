import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app_widget.dart';
import 'src/config/di_dependencies.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const AppWidget());
}
