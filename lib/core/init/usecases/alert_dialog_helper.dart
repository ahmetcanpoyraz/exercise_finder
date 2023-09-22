import 'package:flutter/material.dart';

import '../../global_widgets/custom_alertdialog.dart';

class AlertDialogHelper {
  static final AlertDialogHelper _instance = AlertDialogHelper._init();
  static AlertDialogHelper get instance => _instance;

  AlertDialogHelper._init();

  Future showErrorAlertMessage(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
              buttonText: "Okey",
              message: message,
              onButtonPressed: () {
                Navigator.of(context).pop();
              });
        });
  }

  Future showAlertForAddingItem(BuildContext context, Widget content, Function function) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
              buttonText: "Add",
              content: content,
              onButtonPressed: () {
                Navigator.of(context).pop();
                function();
              });
        });
  }
}
