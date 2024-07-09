import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_appbar.dart';
import 'package:go_blind/app/data/api/firebase_nodes.dart';
import 'package:go_blind/app/data/models/message_model.dart';
import 'package:go_blind/app/modules/Home/home_controller.dart';
import 'package:go_blind/app/modules/chat/chat_view.dart';
import 'package:go_blind/app/routes/app_routes.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';
import 'package:go_blind/utils/formatters.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: ThemeColors.seeGreen,
        onPressed: () {
          Get.toNamed(Routes.ADDCHAT);
        },
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
      appBar: CustomAppBar(
        leading: Container(),
        title: 'Home',
        actions: const [],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : controller.messages.isEmpty
                ? Center(child: Text("No Chats Available", style: MyStyles.smallPoppinsBlack))
                : ListView.builder(
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      MessagesModels message = controller.messages[index];

                      String otherUserId = message.uids.firstWhere((uid) => uid != controller.uid);
                      final String username = controller.users.firstWhere((element) => element.firebaseKey == otherUserId).name;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: InkWell(
                          onLongPress: () async {
                            // await FirebaseFirestore.instance.collection(FirebaseNodes.MESSAGES).doc(message.firebaseKey!).delete();
                          },
                          onTap: () {
                            Get.to(ChatView(
                              receiverId: otherUserId,
                              senderId: controller.uid,
                              recieverName: username,
                              image: message.image,
                            ));
                          },
                          child: Card(
                            surfaceTintColor: Colors.white,
                            elevation: 10,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              title: Text(
                                username,
                                style: MyStyles.mediumPoppins,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                backgroundImage: NetworkImage(message.image),
                              ),
                              subtitle: Text(
                                message.lastMessage,
                                style: MyStyles.smallPoppinsBlack,
                              ),
                              trailing: Text(
                                Formatter.getTimeAgo(message.timeStamp),
                                style: MyStyles.smallPoppinsBlack.copyWith(color: Colors.grey[500], fontSize: 9),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
