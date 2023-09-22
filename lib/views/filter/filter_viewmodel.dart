import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/init/usecases/alert_dialog_helper.dart';
import '../home/home_viewmodel.dart';

class FilterViewModel extends BaseViewModel {
  bool isInit = false;
  bool loading = false;
  List<String> selectedMuscles = [];
  List<String> selectedTypes = [];

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  void onClearAllFilters() {
    selectedMuscles = [];
    selectedTypes = [];
    notifyListeners();
  }

  void onOkey() {
    if (selectedMuscles.isEmpty && selectedMuscles.isEmpty) {
      AlertDialogHelper.instance.showErrorAlertMessage(context!, "Please select a filter");
    } else {
      context!.read<HomeViewModel>().searchController!.text = "";
      context!.read<HomeViewModel>().getFilterResults(
          selectedMuscles.isNotEmpty ? selectedMuscles : null,
          selectedTypes.isNotEmpty ? selectedTypes[0] : null);
      Navigator.pop(context!);
    }
  }

  void onTapMuscles(String value) {
    if (!selectedMuscles.contains(value)) {
      if (selectedMuscles.length < 5) {
        selectedMuscles.add(value);
      }
    } else {
      selectedMuscles.removeWhere((element) => element == value);
    }
    notifyListeners();
  }

  void onTapTypes(String value) {
    if (selectedTypes.contains(value)) {
      selectedTypes.clear();
    } else {
      selectedTypes.clear();
      selectedTypes.add(value);
    }
    notifyListeners();
  }
}
