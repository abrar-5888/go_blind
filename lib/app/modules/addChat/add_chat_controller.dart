// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/data/api/users_api.dart';
import 'package:go_blind/app/data/models/users_model.dart';

class AddChatController extends GetxController {
  RxList<UsersModel> users = <UsersModel>[].obs;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    UsersApi.usersRef.snapshots().listen((event) {
      users.value = event.docs.map((e) => UsersModel.fromJson(e.id, e.data())).toList();
    });
  }
}
