import 'package:cashier/widget/AppBar.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBack(nameScreen: "الأعدادت"),
    );
  }
}
