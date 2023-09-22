import 'package:flutter/material.dart';
import '../../../core/base/base_viewmodel/base_viewmodel.dart';
import '../../core/init/usecases/database_helper.dart';
import '../../core/models/response_model.dart';

class MyProgramViewModel extends BaseViewModel {
  bool isInit = false;
  bool loading = false;
  List<ResponseModel> allItemsFromDB = [];
  List<String> groups = [];
  List<List<ResponseModel>>? itemsByGroups = [];
  int currentIndex = 0;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    await getAllItemsFromDB();
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }

  Future<void> getAllItemsFromDB() async {
    loading = true;
    groups.clear();
    itemsByGroups!.clear();
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
      for (var i = 0; i < groups.length; i++) {
        itemsByGroups!
            .add(allItemsFromDB.where((element) => element.groupName == groups[i]).toList());
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<void> deleteItem(int groupIndex, int id) async {
    await DatabaseHelper.instance.deleteItem(id);
    itemsByGroups![groupIndex]
        .remove(itemsByGroups![groupIndex].where((element) => element.id == id).first);
    if (itemsByGroups![groupIndex].isEmpty) {
      itemsByGroups!.removeAt(groupIndex);
    }
    notifyListeners();
  }

  void changeCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
