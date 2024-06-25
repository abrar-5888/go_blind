// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_blind/app/data/models/conversationMode.dart';
import 'package:go_blind/config/theme/themeColors.dart';
import 'package:google_fonts/google_fonts.dart';

class SentMessage extends StatefulWidget {
  final ConseverationModel message;

  const SentMessage({
    super.key,
    required this.message,
  });

  @override
  State<SentMessage> createState() => _SentMessageState();
}

class _SentMessageState extends State<SentMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 250.0,
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
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              color: ThemeColors.seeGreen,
            ),
            child: Text(
              widget.message.message,
              maxLines: 10,
              style: GoogleFonts.karla(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
