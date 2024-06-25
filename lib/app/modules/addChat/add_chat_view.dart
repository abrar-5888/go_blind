import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_appbar.dart';
import 'package:go_blind/app/modules/addChat/add_chat_controller.dart';
import 'package:go_blind/app/modules/chat/chat_view.dart';
import 'package:go_blind/app/data/models/users_model.dart';

class AddChatView extends StatelessWidget {
  const AddChatView({super.key});

  @override
  Widget build(BuildContext context) {
    AddChatController controller = Get.put(AddChatController(), permanent: true);
    return Scaffold(
      appBar: CustomAppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: 'New Chat',
          actions: const []),
      body: Obx(
        () => controller.users.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  UsersModel user = controller.users[index];
                  if (user.firebaseKey != controller.uid) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(ChatView(
                            recieverName: user.name,
                            receiverId: user.firebaseKey!,
                            senderId: controller.uid,
                            image: user.pictureUrl,
                          ));
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 10,
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.pictureUrl),
                              radius: 25,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                itemCount: controller.users.length,
              )
            : const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
