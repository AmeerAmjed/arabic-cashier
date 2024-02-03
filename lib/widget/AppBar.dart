import 'package:flutter/material.dart';

class AppbarBack extends StatelessWidget implements PreferredSizeWidget {
  final String nameScreen;
  final bool action;
  final VoidCallback? onPressed;
  const AppbarBack({
    Key? key,
    required this.nameScreen,
    this.action = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text(nameScreen),
      actions: [
        action == true
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.more_vert,
                  size: 33.0,
                ))
            : Container()
      ],
    );
  }
}
