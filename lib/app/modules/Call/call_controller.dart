import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/models/callsModel.dart';

class CallsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;
  RxList<CallsModel> calls = <CallsModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchCalls();
  }

  Future<void> fetchCalls() async {
    firestore.collection(FirebaseNodes.CALLS).where('uids', arrayContains: user.uid).snapshots().listen((event) {
      calls.value = event.docs.map((doc) {
        return CallsModel.fromJson(doc.data());
      }).toList();
    });
  }
}
