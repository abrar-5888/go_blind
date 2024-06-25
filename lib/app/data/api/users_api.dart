import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/models/users_model.dart';

class UsersApi {
  UsersApi._();

  static final usersRef = FirebaseFirestore.instance.collection(FirebaseNodes.USERS);

  static void uploadUser(UsersModel user, String uid) async {
    await usersRef.doc(uid).set({...user.toJson(), "timestamp": Timestamp.now().millisecondsSinceEpoch});
  }

  static void updateUser(String firebaseKey, Map<String, dynamic> updatedUser) async {
    await usersRef.doc(firebaseKey).update(updatedUser);
  }

  static void deleteUser(String firebaseKey) async {
    await usersRef.doc(firebaseKey).update({"deleted": true});
  }

  static Future<UsersModel?> getUserByEmail(String email) async {
    var result = await usersRef.where("email", isEqualTo: email).get();
    if (result.docs.isNotEmpty) {
      return UsersModel.fromJson(result.docs.first.id, result.docs.first.data());
    }
    return null;
  }

}
