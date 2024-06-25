import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomDialog {
  static bool _isShowing = false;

  static showProgressDialog() {
    _isShowing = true;
    Get.dialog(
      const PopScope(
        canPop: false,
        child: Dialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
            ),
            ],
          ),
        ),
      ),
    );
  }

  static closeProgressDialog() {
    if (_isShowing) {
      Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
      _isShowing = false;
    }
  }

  static showConfirmationDialog(String message, Function() onYesPressed) {
    Get.dialog(AlertDialog(
      content: Text(message, style: const TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          onPressed: onYesPressed,
          child: const Text('Yes'),
        ),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel')),
      ],
    ));
  }
}
