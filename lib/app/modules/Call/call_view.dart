import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_appbar.dart';
import 'package:go_blind/app/data/models/callsModel.dart';
import 'package:go_blind/app/modules/Call/call_controller.dart';
import 'package:go_blind/app/modules/Home/home_controller.dart';
import 'package:go_blind/app/modules/chat/chat_view.dart';
import 'package:go_blind/config/theme/my_styles.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CallsController controller = Get.put(CallsController());
    HomeController logic = Get.find<HomeController>();

    return Scaffold(
      appBar: CustomAppBar(
        leading: Container(),
        title: 'Calls',
        actions: const [],
      ),
      body: Obx(
        () => controller.calls.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  CallsModel call = controller.calls[index];

                  String otherUserId = call.uids.firstWhere((uid) => uid != FirebaseAuth.instance.currentUser!.uid);
                  final String username = logic.users.firstWhere((element) => element.firebaseKey == otherUserId).name;

                  return Row(
                    children: [
                      SizedBox(
                        width: Get.width - 100,
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 10,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                              username,
                              style: MyStyles.mediumPoppins,
                            ),
                            trailing: call.senderId == FirebaseAuth.instance.currentUser!.uid
                                ? Icon(
                                    Icons.call_received,
                                    size: 25,
                                    color: call.status == 'accepted' ? Colors.green : Colors.red,
                                  )
                                : Icon(
                                    Icons.call_made,
                                    size: 25,
                                    color: call.status == 'accepted' ? Colors.green : Colors.red,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      if (call.senderId != FirebaseAuth.instance.currentUser!.uid)
                        Card(
                          elevation: 10,
                          surfaceTintColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IconButton(
                              onPressed: () {
                                HomeController logic = Get.find<HomeController>();
                                final String username = logic.users.firstWhere((element) => element.firebaseKey == otherUserId).name;

                                Get.to(ChatView(
                                  receiverId: otherUserId,
                                  senderId: FirebaseAuth.instance.currentUser!.uid,
                                  recieverName: username,
                                  image: call.image,
                                ));
                              },
                              icon: const Icon(
                                Icons.message,
                                color: Colors.green,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                },
                itemCount: controller.calls.length,
              )
            : Center(child: Text("No Calls available", style: MyStyles.largePoppinsBlack)),
      ),
    );
  }
}
