import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/api/users_api.dart';
import 'package:go_blind/app/data/models/message_model.dart';
import 'package:go_blind/app/data/models/users_model.dart';

class HomeController extends GetxController {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<UsersModel> users = <UsersModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<MessagesModels> messages = <MessagesModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    fetchMessages();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;

    UsersApi.usersRef.snapshots().listen((event) {
      users.value = event.docs.map((e) => UsersModel.fromJson(e.id, e.data())).toList();
    });
  }

  void fetchMessages() {
    FirebaseFirestore.instance.collection(FirebaseNodes.MESSAGES).where('uids', arrayContains: uid).snapshots().listen((snapshot) {
      messages.value = snapshot.docs.map((doc) => MessagesModels.fromJson(doc.id, doc.data())).toList();
      messages.value = messages.reversed.toList();
      isLoading.value = false;
    });
  }
}
