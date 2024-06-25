import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/snackbars.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/models/conversationMode.dart';
import 'package:go_blind/app/data/models/message_model.dart';

class ChatController extends GetxController {
  RxString messageText = ''.obs;
  RxList<MessagesModels> messages = <MessagesModels>[].obs;
  var messageController = TextEditingController().obs;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  void sendMessage(String receiverId, String image) async {
    if (messageController.value.text.isNotEmpty) {
      String currentUserId = uid; // Assuming `uid` is the current user's ID
      messageText.value = messageController.value.text;

      ConseverationModel conversation = ConseverationModel(message: messageText.value, senderId: currentUserId);

      MessagesModels message = MessagesModels(
        image: image,
        message: [conversation],
        uids: [currentUserId, receiverId],
        lastMessage: messageText.value,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        senderId: currentUserId,
      );

      if (messages.isNotEmpty) {
        String? docId = messages
            .firstWhere(
              (message) => message.uids.contains(receiverId) && message.uids.contains(currentUserId),
            )
            .firebaseKey;

        if (docId != null) {
          await FirebaseFirestore.instance.collection(FirebaseNodes.MESSAGES).doc(docId).update({
            'lastMessage': messageController.value.text,
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
            'message': FieldValue.arrayUnion([message.message.first.toJson()]),
          }).then((value) {
            messageController.value.clear();
            messageText.value = '';
          });
        } else {
      
          await FirebaseFirestore.instance.collection(FirebaseNodes.MESSAGES).add(message.toJson()).then((value) => messageController.value.clear());
        }
      } else {
        await FirebaseFirestore.instance.collection(FirebaseNodes.MESSAGES).add(message.toJson()).then((value) => messageController.value.clear());
      }
    } else {
      CustomSnackBar.showCustomErrorToast(message: "Message can't be empty");
    }
  }
}
