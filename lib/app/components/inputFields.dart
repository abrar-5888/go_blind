// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class InputFormField extends StatelessWidget {
  final String hintTextLabel;
  final TextEditingController? controller;
  final bool? isEnable;
  final TextInputType inputType;

  const InputFormField({
    super.key,
    required this.hintTextLabel,
    this.controller,
    this.isEnable,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        keyboardType: inputType,
        cursorColor: ThemeColors.seeGreen,
        autofocus: false,
        enabled: isEnable,
        style: MyStyles.mediumPoppins,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ThemeColors.gray, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ThemeColors.gray, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ThemeColors.gray, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
