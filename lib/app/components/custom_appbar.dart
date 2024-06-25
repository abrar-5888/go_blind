import 'package:flutter/material.dart';
import 'package:go_blind/config/theme/my_styles.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final String title;
  final List<Widget> actions;
  const CustomAppBar({super.key, required this.leading, required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 12),
        child: leading,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: ThemeColors.seeGreen,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(
          title,
          style:
              MyStyles.largePoppinsWhite.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      actions: actions
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(70.0); // Specify desired height
}
