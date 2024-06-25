// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/modules/signup/signup_controller.dart';
import 'package:go_blind/config/images.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.seeGreen,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign Up",
                      style: MyStyles.largePoppinsWhite.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempo incididunt ut labore et dolore magna aliqua.",
                    style: MyStyles.smallPoppinsWhite.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(clipBehavior: Clip.none, fit: StackFit.expand, children: [
                      Obx(
                        () => controller.pickedImage.value.path != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(controller.pickedImage.value.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const CircleAvatar(radius: 50, backgroundColor: Colors.white, backgroundImage: AssetImage(Images.profile)),
                      ),
                      Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                              icon: SvgPicture.asset(
                                Svgs.addImage,
                                color: Colors.black,
                              ),
                              onPressed: controller.pickImages)),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 0.5,
                          spreadRadius: 0.9,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: TextFormField(
                                controller: controller.nameController,
                                style: MyStyles.smallPoppinsBlack,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.drive_file_rename_outline, color: ThemeColors.seeGreen),
                                    labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                    labelText: 'Name',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: TextFormField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: MyStyles.smallPoppinsBlack,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email_outlined, color: ThemeColors.seeGreen),
                                    labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                    labelText: 'Email',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: controller.phoneController,
                                style: MyStyles.smallPoppinsBlack,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.call_outlined, color: ThemeColors.seeGreen),
                                    labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                    labelText: 'Phone',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: TextFormField(
                                controller: controller.addressController,
                                keyboardType: TextInputType.streetAddress,
                                style: MyStyles.smallPoppinsBlack,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.location_on_outlined, color: ThemeColors.seeGreen),
                                    labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                    labelText: 'Address',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                              child: Obx(
                                () => TextFormField(
                                  controller: controller.passwordController,
                                  style: MyStyles.smallPoppinsBlack,
                                  //  keyboardType: TextInputType.visiblePassword,
                                  obscureText: controller.isObscure.value,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.isObscure.value ? Icons.remove_red_eye : Icons.visibility_off,
                                          color: ThemeColors.seeGreen,
                                        ),
                                        onPressed: () {
                                          controller.togglePasswordVisibility();
                                        },
                                      ),
                                      prefixIcon: const Icon(Icons.lock_outlined, color: ThemeColors.seeGreen),
                                      labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                      labelText: 'Password',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
                              child: Obx(
                                () => DropdownButtonFormField<String>(
                                  value: controller.selectedLanguage.value,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.selectedLanguage.value = newValue;
                                    }
                                  },
                                  items: <String>['English', 'Urdu', 'Chinese'].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: MyStyles.mediumPoppins),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.language, color: ThemeColors.seeGreen),
                                    labelText: 'Language',
                                    labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.isFormValid()) {
                                  controller.signUp();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  elevation: 20,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                                child: Text(
                                  "Sign Up",
                                  style: MyStyles.largePoppinsWhite.copyWith(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
