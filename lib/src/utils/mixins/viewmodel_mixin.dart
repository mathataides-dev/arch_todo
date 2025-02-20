import 'package:flutter/material.dart';

mixin ViewmodelMixin on ChangeNotifier {
  late dynamic _state;
  dynamic get state => _state;

  void setState(dynamic newState) {
    _state = newState;
    notifyListeners();
  }
}
