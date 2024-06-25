import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blind/app/components/custom_appbar.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/app/data/models/callsModel.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CallsModel> calls = [
      CallsModel(isMine: true, missed: true, name: 'Abrar', email: 'hello@gmail.com'),
      CallsModel(isMine: false, missed: false, name: 'Abrar', email: 'hello@gmail.com'),
      CallsModel(isMine: true, missed: true, name: 'Abrar', email: 'hello@gmail.com'),
      CallsModel(isMine: false, missed: false, name: 'Abrar', email: 'hello@gmail.com'),
      CallsModel(isMine: true, missed: true, name: 'Abrar', email: 'hello@gmail.com'),
      CallsModel(isMine: false, missed: false, name: 'Abrar', email: 'hello@gmail.com')
    ];
    return Scaffold(
      appBar: CustomAppBar(leading: Container(), title: 'Calls', actions: const [],),
      body: ListView.builder(
        itemBuilder: (context, index) {
          CallsModel call = calls[index];
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
                      call.name,
                      style: MyStyles.mediumPoppins,
                    ),
                    subtitle: Text(
                      call.email,
                      style: MyStyles.smallPoppinsBlack,
                    ),
                    trailing: Icon(
                      call.isMine
                          ? call.missed
                              ? Icons.call_missed_outgoing
                              : Icons.call_made
                          : call.missed
                              ? Icons.call_missed
                              : Icons.call_received,
                      color: call.isMine
                          ? call.missed
                              ? Colors.red
                              : Colors.green
                          : call.missed
                              ? Colors.red
                              : Colors.green,
                      size: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Card(
                elevation: 10,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () {},
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
        itemCount: calls.length,
      ),
    );
  }
}
