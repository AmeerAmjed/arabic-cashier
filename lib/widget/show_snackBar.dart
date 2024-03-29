import 'package:flutter/material.dart';

SnackBar showSnackBar(String title, {required void Function() onPressed}) {
  return SnackBar(
    content: Text(title),
    action: SnackBarAction(
      label: 'ok',
      onPressed: onPressed,
    ),
  );
}
