import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_dialog.dart';
import 'package:go_blind/app/components/snackbars.dart';
import 'package:go_blind/app/data/api/users_api.dart';
import 'package:go_blind/app/data/models/users_model.dart';
import 'package:go_blind/utils/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  UsersModel? user;
  Rx<File> pickedImage = File('').obs;
  RxString url = ''.obs;
  var selectedLanguage = ''.obs;
  RxBool isLoading = false.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();

    getUser();
  }

  Future<void> getUser() async {
    isLoading.value = true;
    UsersApi.usersRef.doc(uid).snapshots().listen((event) {
      user = UsersModel.fromJson(event.id, event.data());
      if (user != null) {
        nameController.text = user!.name;
        phoneController.text = user!.phone;
        emailController.text = user!.email;
        addressController.text = user!.address;
        isLoading.value = false;
        selectedLanguage.value = user!.language;
      }
    });
  }

  pickImages() async {
    final ImagePicker picker = ImagePicker();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    pickedImage.value = File(pickedImageFile!.path);

    sharedPreferences.setString('image', pickedImageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child("profileImages/${DateTime.now().millisecondsSinceEpoch}");
    UploadTask uploadTask = reference.putFile(File(pickedImage.value.path));

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    url.value = await taskSnapshot.ref.getDownloadURL();
  }

  bool isFormValid() {
    if (nameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty || addressController.text.isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Enter all fields.");
      return false;
    }
    if (!emailController.text.endsWith('@gmail.com')) {
      CustomSnackBar.showCustomErrorToast(message: "Email is not valid");
      return false;
    }
    if (!RegExp(r'^(03\d{9}|(\+92)?3\d{9})$').hasMatch(phoneController.text)) {
      CustomSnackBar.showCustomErrorToast(message: "Phone is not valid");
      return false;
    }
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$]').hasMatch(addressController.text)) {
      CustomSnackBar.showCustomErrorToast(message: "Address should not contain special characters");
      return false;
    }

    return true;
  }

  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CustomDialog.showProgressDialog();
    UsersModel users = UsersModel(
        pictureUrl: url.value,
        name: nameController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text,
        password: user!.password,
        address: addressController.value.text,
        language: selectedLanguage.value);
    Map<String, dynamic> updatedUser = users.toJson();
    UsersApi.updateUser(uid, updatedUser);

    String userJson = jsonEncode(users.toJson());

    await prefs.setString('user', userJson);
    if (users.language.toLowerCase() == 'urdu') {
      locale = 'ur';
    } else if (users.language.toLowerCase() == 'chinese') {
      locale = 'zh-cn';
    } else {
      locale = 'en';
    }
    CustomDialog.closeProgressDialog();
    CustomSnackBar.showCustomToast(message: 'Profile Updated');
  }
}
