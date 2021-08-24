import 'package:cashier/screens/setting/setting.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text("الكاشير"),
      actions: [
        IconButton(
          icon: Icon(Icons.settings_outlined),
          tooltip: 'ألاعادات',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ),
            );
          },
        ),
      ],
    );
  }
}
