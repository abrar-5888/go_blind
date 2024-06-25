import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_dialog.dart';
import 'package:go_blind/app/components/snackbars.dart';
import 'package:go_blind/app/data/api/users_api.dart';
import 'package:go_blind/app/data/models/users_model.dart';
import 'package:go_blind/app/routes/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  Rx<File> pickedImage = File('').obs;
  var selectedLanguage = 'English'.obs;
  RxBool isObscure = true.obs;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  RxString url = ''.obs;

  void togglePasswordVisibility() {
    isObscure.toggle();
  }

  bool isFormValid() {
    if (nameController.text.isEmpty || passwordController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty || addressController.text.isEmpty) {
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
    if (pickedImage.value.path.isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Image can't be empty");
      return false;
    }
    return true;
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

  void signUp() async {
    CustomDialog.showProgressDialog();
    UsersModel users = UsersModel(
        pictureUrl: url.value,
        name: nameController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text,
        password: passwordController.value.text,
        address: addressController.value.text,
        language: selectedLanguage.value);
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.value.text, password: passwordController.value.text).then((value) => {
            UsersApi.uploadUser(users, value.user!.uid),
            Get.offAllNamed(Routes.LOGIN)!.then((value) => {CustomSnackBar.showCustomToast(message: 'Sign up Successfully,Please login to continue')})
          });
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(message: "Account already created");
    }
  }
}
