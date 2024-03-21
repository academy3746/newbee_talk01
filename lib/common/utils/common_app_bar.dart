import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    required this.isLeading,
    this.backBtn,
    this.actions,
    this.centerTitle,
    required this.backgroundColor,
    required this.iconColor,
    required this.fontColor,
  });

  final String title;

  final bool isLeading;

  final Function? backBtn;

  final List<Widget>? actions;

  final bool? centerTitle;

  final Color backgroundColor;

  final Color iconColor;

  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      toolbarHeight: Sizes.size48,
      automaticallyImplyLeading: isLeading,
      titleSpacing: isLeading ? 0 : Sizes.size16,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: isLeading
          ? GestureDetector(
              onTap: () {
                backBtn != null ? backBtn!.call() : Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: iconColor,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: fontColor,
          fontSize: Sizes.size20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
