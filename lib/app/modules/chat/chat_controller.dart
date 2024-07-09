// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/snackbars.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/models/callsModel.dart';
import 'package:go_blind/app/data/models/conversationMode.dart';
import 'package:go_blind/app/data/models/message_model.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class ChatController extends GetxController {
  RxString messageText = ''.obs;
  CallsModel? call;

  RxBool showIncomingCallPage = false.obs;
  RxList<MessagesModels> messages = <MessagesModels>[].obs;
  var messageController = TextEditingController().obs;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  RxString callDocId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCall();
  }

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

  String generateFiveLetterWord() {
    final wordPair = generateWordPairs().first;
    String word = wordPair.first;
    while (word.length != 5) {
      word = generateWordPairs().first.asPascalCase;
    }
    return word;
  }

  createMeeting(String senderName, String recieverName, String recverId, String imageUrl) async {
    try {
      String roomName = generateFiveLetterWord();
      var options = JitsiMeetingOptions(
        room: "$roomName",
      )
        ..serverURL = "https://finispeak.com"
        ..subject = "Meeting with $recieverName"
        ..userAvatarURL = "$imageUrl"
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
      List<String> uids = [uid, recverId];
      CallsModel call = CallsModel(image: imageUrl, name: senderName, uids: uids, status: 'pending', roomName: roomName, senderId: FirebaseAuth.instance.currentUser!.uid);
      String id = await FirebaseFirestore.instance.collection(FirebaseNodes.CALLS).add(call.toJson()).then((data) {
        return data.id;
      });
      Future.delayed(const Duration(minutes: 2), () async {
        FirebaseFirestore.instance.collection(FirebaseNodes.CALLS).doc(id).update({'status': 'denied'});
      });
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  joinMeetingsss(String roomName, String imageUrl, String senderName) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(
        room: "$roomName",
      )
        ..serverURL = "https://finispeak.com"
        ..subject = "Meeting with $senderName"
        ..userAvatarURL = "$imageUrl"
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void fetchCall() {
    FirebaseFirestore.instance.collection(FirebaseNodes.CALLS).where('status', isEqualTo: 'pending').where('uids', arrayContains: uid).where('senderId', isNotEqualTo: uid).snapshots().listen((event) {
      call = CallsModel.fromJson(event.docs.first.data());
      callDocId.value = event.docs.first.id;
      showIncomingCallPage.value = true;
    });
  }
}
