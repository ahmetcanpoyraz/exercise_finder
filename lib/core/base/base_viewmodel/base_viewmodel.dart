import 'dart:async';
import '../../init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoadingPage = true;
  bool isLoadingRequest = false;
  bool _isDisposed = false;
  final bool _isInitializeDone = false;
  BuildContext? context;
  NavigationService navigation = NavigationService.instance;

  FutureOr<void> _initState;

  FutureOr<void> init();

  void setContext(BuildContext context);

  void changeStatus() => isLoadingPage = !isLoadingPage;

  void reloadState() {
    if (!isLoadingPage) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    changeStatus();
    _isDisposed = true;
    //super.dispose();
  }

  //Getters
  FutureOr<void> get initState => _initState;

  bool get isLoadingPage => _isLoadingPage;

  bool get isDisposed => _isDisposed;

  bool get isInitialized => _isInitializeDone;

  //Setters
  set isLoadingPage(bool value) {
    _isLoadingPage = value;
    scheduleMicrotask(() {
      if (!_isDisposed) notifyListeners();
    });
  }
}
