// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:go_blind/app/routes/app_routes.dart';
import 'package:go_blind/config/images.dart';
import 'package:go_blind/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> checkUserAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3), () {
      // Get.offNamed(Routes.STORYBOARD);

      String? userJson = prefs.getString('user');

      if (userJson != null) {
        var data = jsonDecode(userJson);
        if (data['language'].toLowerCase() == 'urdu') {
          locale = 'ur';
        } else if (data['language'].toLowerCase() == 'chinese') {
          locale = 'zh-cn';
        } else {
          locale = 'en';
        }
        Get.offAllNamed(Routes.BOTTOMBAR);
      } else {
        Get.offAllNamed(Routes.STORYBOARD);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkUserAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: Center(
        child: Image.asset(Images.logo),
      ),
    );
  }
}
