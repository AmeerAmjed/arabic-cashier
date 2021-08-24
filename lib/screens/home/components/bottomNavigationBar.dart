import 'package:flutter/material.dart';
import 'package:cashier/screens/scanner/scanner.dart';

class BottomScann extends StatelessWidget {
  final List<String>? data;
  BottomScann({Key? key, this.data}) : super(key: key);

  // List<String>? get data => _data;

  dataItem() => data;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_outlined),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scanners(),
          ),
        );
      },
    );
  }
}
