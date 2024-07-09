import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_appbar.dart';
import 'package:go_blind/app/components/recievedMessage.dart';
import 'package:go_blind/app/components/sendMessage.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/models/conversationMode.dart';
import 'package:go_blind/app/data/models/message_model.dart';
import 'package:go_blind/app/modules/Home/home_controller.dart';
import 'package:go_blind/app/modules/chat/chat_controller.dart';
import 'package:go_blind/app/modules/incomingCallPage/incomingCallPageView.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';
import 'package:go_blind/utils/global.dart';

class ChatView extends StatelessWidget {
  final String recieverName;
  final String receiverId;
  final String image;
  final String senderId;
  const ChatView({super.key, required this.receiverId, required this.senderId, required this.recieverName, required this.image});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());
    return Obx(() => controller.showIncomingCallPage.value
        ? Scaffold(
            body: IncomingCallWidget(
              call: controller.call!,
              acceptCall: () {
                FirebaseFirestore.instance.collection(FirebaseNodes.CALLS).doc(controller.callDocId.value).update({
                  'status': 'accepted',
                }).then((value) {
                  HomeController logic = Get.find<HomeController>();

                  String otherUserId = controller.call!.uids.firstWhere((uid) => uid != controller.uid);
                  final String username = logic.users.firstWhere((element) => element.firebaseKey == otherUserId).name;
                  controller.showIncomingCallPage.value = false;
                  controller.joinMeetingsss(controller.call!.roomName, image, username);
                  
                });
              },
              denyCall: () {
                FirebaseFirestore.instance.collection(FirebaseNodes.CALLS).doc(controller.callDocId.value).update({
                  'status': 'denied',
                }).then((value) => controller.showIncomingCallPage.value = false);
              },
              caller: "",
            ),
          )
        : Scaffold(
            appBar: CustomAppBar(
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                title: recieverName,
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          controller.createMeeting(
                            name,
                            recieverName,
                            receiverId,
                            image,
                          );
                        },
                        icon: const Icon(
                          Icons.video_call_rounded,
                          color: Colors.white,
                          size: 30,
                        )),
                  )
                ]),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(FirebaseNodes.MESSAGES).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("No Chats Available", style: MyStyles.smallPoppinsBlack),
                        );
                      }
                      controller.messages.value = snapshot.data!.docs
                          .map((e) => MessagesModels.fromJson(e.id, e.data() as Map<String, dynamic>))
                          .where((message) => message.uids.contains(receiverId))
                          .where((message) => message.uids.contains(senderId))
                          .toList();

                      return ListView.builder(
                        reverse: true,
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          MessagesModels message = controller.messages[index];
                          List<ConseverationModel> list = message.message;

                          if (list.isNotEmpty) {
                            return Column(
                                children: list.map((conversation) {
                              return conversation.senderId == controller.uid
                                  ? SentMessage(message: conversation)
                                  : ReceivedMessage(
                                      userName: recieverName,
                                      message: conversation,
                                    );
                            }).toList());
                          } else {
                            return const Center(
                              child: Text("No Chats Available"),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller.messageController.value,
                    onChanged: (value) {
                      controller.messageText.value = value;
                    },
                    style: MyStyles.smallPoppinsBlack,
                    decoration: InputDecoration(
                      hintText: 'Message...',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ThemeColors.seeGreen, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send_rounded, color: ThemeColors.seeGreen, size: 25),
                        onPressed: () {
                          controller.sendMessage(receiverId, image);
                        },
                      ),
                      hintStyle: MyStyles.smallPoppinsBlack,
                      filled: true,
                      fillColor: const Color.fromARGB(31, 207, 183, 176),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
  }
}
