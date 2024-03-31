import 'package:flutter/material.dart';

enum ActionDismissible { RIGHT, LEFT }

class BackgroundDismissible extends StatelessWidget {
  const BackgroundDismissible({
    super.key,
    required this.title,
    required this.icon,
    required this.colorBackground,
    required this.action,
  });

  final String title;
  final IconData icon;
  final Color colorBackground;
  final ActionDismissible action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 2.0,
      ),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: action == ActionDismissible.RIGHT
            ? BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: action == ActionDismissible.RIGHT
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: action == ActionDismissible.RIGHT
                  ? TextAlign.left
                  : TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: action == ActionDismissible.RIGHT
            ? Alignment.centerLeft
            : Alignment.centerRight,
      ),
    );
  }
}
