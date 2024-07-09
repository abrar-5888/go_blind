import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  RxString fcmtoken = ''.obs;

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

  Future<void> getFCMToken(String uid) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    if (token!.isNotEmpty) {
      fcmtoken.value = token;
    }
    FirebaseFirestore.instance.collection('FCMtokens').doc(uid).set({'FCMtoken': fcmtoken, 'uid': uid});

    print('FCM Token: $fcmtoken');
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
          locale = 'ur';
        } else if (user.language.toLowerCase() == 'chinese') {
          locale = 'zh-cn';
        } else {
          locale = 'en';
        }
        String userJson = jsonEncode(user.toJson());

        await prefs.setString('user', userJson);

        name = user.name;
        email = user.email;
        image = user.pictureUrl;
        getFCMToken(FirebaseAuth.instance.currentUser!.uid);
        Get.offAllNamed(Routes.BOTTOMBAR);
      });
    } catch (e) {
      CustomDialog.closeProgressDialog();
      CustomSnackBar.showCustomErrorToast(message: "No User exists for the given mail");
    }
  }
}
