import 'package:exercise_finder/core/constants/screen_constants/home_screen_contants.dart';
import 'package:exercise_finder/core/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/init/usecases/alert_dialog_helper.dart';
import '../../core/init/usecases/database_helper.dart';
import '../../core/models/response_model.dart';

class HomeViewModel extends BaseViewModel {
  bool isInit = false;
  bool loading = false;
  TextEditingController? searchController;
  TextEditingController? newGroupController;
  bool visibleSearchList = false;
  List<String> suggestions = [];
  List<ResponseModel>? responseList;
  bool showResultText = false;
  List<ResponseModel> filterResponseList = [];
  List<String> groups = [];
  List<ResponseModel> allItemsFromDB = [];

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    searchController = TextEditingController();
    newGroupController = TextEditingController();
    suggestions = HomeScreenConstants.instance.allSuggestions;
    responseList = [];
    await getGroupNames();
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  Future<void> getGroupNames() async {
    final List<Map<String, dynamic>> itemMaps = await DatabaseHelper.instance.getAllItems();
    allItemsFromDB = itemMaps.map((itemMap) {
      return ResponseModel(
        id: itemMap['id'],
        name: itemMap['name'],
        type: itemMap['type'],
        muscle: itemMap['muscle'],
        difficulty: itemMap['difficulty'],
        equipment: itemMap['equipment'],
        instructions: itemMap['instructions'],
        groupName: itemMap['groupName'],
      );
    }).toList();
    if (allItemsFromDB.isNotEmpty) {
      for (var i = 0; i < allItemsFromDB.length; i++) {
        groups.add(allItemsFromDB[i].groupName ?? "");
      }
      groups = groups.toSet().toList();
    }
  }

  Future<void> insertItemToDB(ResponseModel value, String? groupName) async {
    if (groupName == null) {
      AlertDialogHelper.instance.showErrorAlertMessage(context!, "Please add or select group name");
    } else {
      await DatabaseHelper.instance.insertItem({
        'name': value.name,
        'type': value.type,
        'muscle': value.muscle,
        'equipment': value.equipment,
        'difficulty': value.difficulty,
        'instructions': value.instructions,
        'groupName': groupName
      });
      await getGroupNames();
    }
    newGroupController!.text = "";
    notifyListeners();
  }

  void filterSuggestions(String query) {
    suggestions = HomeScreenConstants.instance.allSuggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void chanceVisibleFilterList(bool value) {
    visibleSearchList = value;
    notifyListeners();
  }

  Future<void> getFilterResults(List<String>? selectedMuscleList, String? selectedType) async {
    filterResponseList = [];
    loading = true;
    notifyListeners();
    showResultText = true;
    if (selectedMuscleList != null) {
      for (var i = 0; i < selectedMuscleList.length; i++) {
        var response = await HomeRepository.instance.getMuscles(selectedMuscleList[i]);
        response.fold(
            (l) => {AlertDialogHelper.instance.showErrorAlertMessage(context!, l.message)}, (r) {
          showResultText = true;
          filterResponseList = r + filterResponseList;
        });
      }
    }
    if (selectedType != null) {
      var response = await HomeRepository.instance.getTypes(selectedType);
      response.fold((l) => {AlertDialogHelper.instance.showErrorAlertMessage(context!, l.message)},
          (r) {
        filterResponseList = r + filterResponseList;
      });
    }
    responseList = filterResponseList;
    loading = false;
    notifyListeners();
  }

  Future<void> getMuscles(String value) async {
    loading = true;
    notifyListeners();
    showResultText = true;
    var response = await HomeRepository.instance.getMuscles(value);
    response.fold((l) => {AlertDialogHelper.instance.showErrorAlertMessage(context!, l.message)},
        (r) {
      responseList = r;
    });
    loading = false;
    notifyListeners();
  }

  Future<void> getTypes(String value) async {
    loading = true;
    notifyListeners();
    showResultText = true;
    var response = await HomeRepository.instance.getTypes(value);
    response.fold((l) => {AlertDialogHelper.instance.showErrorAlertMessage(context!, l.message)},
        (r) {
      responseList = r;
    });
    loading = false;
    notifyListeners();
  }
}
