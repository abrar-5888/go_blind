// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:go_blind/app/modules/BottomBar/bottombar_view.dart';
import 'package:go_blind/app/modules/addChat/add_chat_view.dart';
import 'package:go_blind/app/modules/login/login_view.dart';
import 'package:go_blind/app/modules/signup/signup_view.dart';
import 'package:go_blind/app/modules/splash/splash_view.dart';
import 'package:go_blind/app/modules/storyBoard/storyboard.dart';
import 'package:go_blind/app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.STORYBOARD,
      page: () => const StoryBoard(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.BOTTOMBAR,
      page: () => const BottomBarPage(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: Routes.ADDCHAT,
      page: () => const AddChatView(),
    ),
  ];
}
