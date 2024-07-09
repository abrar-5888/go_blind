import 'package:flutter/material.dart';
import 'package:go_blind/app/data/models/callsModel.dart';

class IncomingCallWidget extends StatelessWidget {
  Function? acceptCall;
  Function? denyCall;
  CallsModel call;
  String? caller;

  IncomingCallWidget({super.key, this.acceptCall, this.denyCall, this.caller, required this.call});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(call.image),
          radius: 80,
        ),
        const SizedBox(height: 20),
        const Text("Incoming Call"),
        const SizedBox(height: 20),
        Text(
          call.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                acceptCall!();
              },
              heroTag: const Key('FABAcceptCall'),
              elevation: 0,
              child: const Icon(Icons.call_outlined),
            ),
            FloatingActionButton(
              onPressed: () => denyCall!(),
              heroTag: const Key('FABDenyCall'),
              elevation: 0,
              backgroundColor: Colors.red[300],
              child: const Icon(Icons.call_end_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
