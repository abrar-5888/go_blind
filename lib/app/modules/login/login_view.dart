import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/modules/login/login_controller.dart';
import 'package:go_blind/app/routes/app_routes.dart';
import 'package:go_blind/config/images.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.seeGreen,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 30,
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
                  height: 20,
                ),
                Image.asset(
                  Images.logoBg,
                  height: 250,
                  // width: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign In",
                      style: MyStyles.largePoppinsWhite.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempo incididunt ut labore et dolore magna aliqua.",
                    style: MyStyles.smallPoppinsWhite.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
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
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.idController,
                                style: MyStyles.smallPoppinsBlack,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person_pin, color: ThemeColors.seeGreen),
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
                              child: Obx(
                                () => TextFormField(
                                  controller: controller.passwordController,
                                  style: MyStyles.smallPoppinsBlack,
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
                                      prefixIcon: const Icon(Icons.lock, color: ThemeColors.seeGreen),
                                      labelStyle: MyStyles.mediumPoppins.copyWith(color: ThemeColors.seeGreen, fontSize: 14),
                                      labelText: 'Password',
                                      border: InputBorder.none),
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
                                  controller.login(controller.idController.text, controller.passwordController.text);
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
                                  "Sign In",
                                  style: MyStyles.largePoppinsWhite.copyWith(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.SIGNUP);
                                },
                                child: Text(
                                  "Don't have an account ?",
                                  style: MyStyles.smallPoppinsBlack.copyWith(color: ThemeColors.seeGreen),
                                )),
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
