import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/routes/app_routes.dart';
import 'package:go_blind/config/images.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class StoryBoard extends StatelessWidget {
  const StoryBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.black,
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            color: ThemeColors.black,
            child: Image.asset(
              Images.logo,
              // height: 300,
              // width: 300,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black, blurRadius: 0.5, spreadRadius: 0.9)
                ],
                color: ThemeColors.seeGreen,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome",
                    style: MyStyles.largePoppinsWhite.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: MyStyles.smallPoppinsWhite
                        .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.LOGIN);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 20,
                                padding: const EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Get Started",
                                style: MyStyles.largePoppinsBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
