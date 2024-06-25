import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_dialog.dart';
import 'package:go_blind/app/components/snackbars.dart';
import 'package:go_blind/app/data/api/users_api.dart';
import 'package:go_blind/app/routes/app_routes.dart';
import 'package:go_blind/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isObscure = true.obs;
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  void togglePasswordVisibility() {
    isObscure.toggle();
  }

  bool isFormValid() {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Enter all fields.");
      return false;
    }
    return true;
  }

  void login(String email, String password) async {
    try {
      CustomDialog.showProgressDialog();
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async {
        var user = await UsersApi.getUserByEmail(email);
        CustomDialog.closeProgressDialog();
        if (user == null) {
          CustomSnackBar.showCustomErrorToast(message: "No User exists for the given mail");
          return;
        }
        if (user.password != password) {
          CustomSnackBar.showCustomErrorToast(message: "Wrong Password!");
          return;
        }
        if (user.language.toLowerCase() == 'urdu') {
          locale = 'ur_PK';
        } else if (user.language.toLowerCase() == 'chinese') {
          locale = 'zh_CN';
        } else {
          locale = 'en_US';
        }
        String userJson = jsonEncode(user.toJson());

        await prefs.setString('user', userJson);

        Get.offAllNamed(Routes.BOTTOMBAR);
      });
    } catch (e) {
      CustomDialog.closeProgressDialog();
      CustomSnackBar.showCustomErrorToast(message: "No User exists for the given mail");
    }
  }
}
