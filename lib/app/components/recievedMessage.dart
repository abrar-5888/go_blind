// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_blind/app/data/models/conversationMode.dart';
import 'package:go_blind/utils/global.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceivedMessage extends StatefulWidget {
  final String userName;
  final ConseverationModel message;

  const ReceivedMessage({
    super.key,
    required this.message,
    required this.userName,
  });

  @override
  State<ReceivedMessage> createState() => _ReceivedMessageState();
}

class _ReceivedMessageState extends State<ReceivedMessage> {
  final FlutterTts flutterTts = FlutterTts();
  bool playing = false;
  Future<void> speak(String text) async {
    setState(() {
      playing = true;
    });
    await flutterTts.setLanguage(locale);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    flutterTts.setCompletionHandler(() {
      setState(() {
        playing = false;
      });
    });
  }

  Future<void> pause() async {
    await flutterTts.pause();

    playing = false;
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 270.0,
                ),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10.0,
                      spreadRadius: 0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                  color: const Color.fromARGB(217, 255, 255, 255),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.userName, style: const TextStyle(color: Colors.red, fontSize: 10)),
                    const SizedBox(height: 10),
                    Text(
                      widget.message.message,
                      maxLines: 10,
                      style: GoogleFonts.karla(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              )),
          IconButton(
            onPressed: () {
              if (playing == false) {
                speak(widget.message.message);
              } else {
                pause();
              }
            },
            icon: Icon(playing ? Icons.pause : Icons.mic),
          ),
        ],
      ),
    );
  }
}
