// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_appbar.dart';
import 'package:go_blind/app/components/inputFields.dart';
import 'package:go_blind/app/modules/Profile/profile_controller.dart';
import 'package:go_blind/config/images.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put<ProfileController>(ProfileController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          leading: Container(),
          title: 'Profile',
          actions: const [],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Obx(
                                  () => controller.pickedImage.value.path != ''
                                      ? CircleAvatar(
                                          radius: 50,
                                          child: Image.file(
                                            File(controller.pickedImage.value.path),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(controller.user!.pictureUrl),
                                          backgroundColor: Colors.white,
                                        ),
                                ),
                                Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: IconButton(
                                        icon: SvgPicture.asset(
                                          Svgs.addImage,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          controller.pickImages();
                                        })),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.user!.name, style: MyStyles.mediumPoppins),
                                  Text(controller.user!.email, style: MyStyles.smallPoppinsBlack),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Name", style: MyStyles.outfitNormalGray.copyWith(fontSize: 16)),
                                  ),
                                  InputFormField(
                                    inputType: TextInputType.name,
                                    hintTextLabel: "Name",
                                    isEnable: true,
                                    controller: controller.nameController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Phone", style: MyStyles.outfitNormalGray.copyWith(fontSize: 16)),
                                  ),
                                  InputFormField(inputType: TextInputType.phone, hintTextLabel: "Enter Phone", isEnable: true, controller: controller.phoneController),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Email", style: MyStyles.outfitNormalGray.copyWith(fontSize: 16)),
                        ),
                        InputFormField(inputType: TextInputType.emailAddress, hintTextLabel: "Enter email", isEnable: false, controller: controller.emailController),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Address", style: MyStyles.outfitNormalGray.copyWith(fontSize: 16)),
                        ),
                        InputFormField(inputType: TextInputType.streetAddress, hintTextLabel: "Enter Address", isEnable: true, controller: controller.addressController),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Language", style: MyStyles.outfitNormalGray.copyWith(fontSize: 16)),
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: ThemeColors.gray)),
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
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.isFormValid()) {
                                controller.updateProfile();
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: ThemeColors.seeGreen),
                            child: Text(
                              'Update',
                              style: MyStyles.smallPoppinsWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
