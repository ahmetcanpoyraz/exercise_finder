import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/base/base_viewmodel/base_viewmodel.dart';

class CustomBottomNavigationViewModel extends BaseViewModel {
  bool isInit = false;
  late int controller;
  late GlobalKey<NavigatorState> navigatorKey;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    controller = 0;
    navigatorKey = GlobalKey<NavigatorState>();
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  void changeController(int index) {
    controller = index;
    notifyListeners();
  }
}
