import 'package:flutter/material.dart';

class ListTiles extends StatelessWidget {
  final String? title;
  final String? lable;
  final int? price;
  final int? much;

  const ListTiles({
    Key? key,
    required this.title,
    required this.lable,
    required this.price,
    required this.much,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          '${much!}X',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      title: Text(
        title!,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
      subtitle: Text(
        lable!,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
      trailing: much! == 1
          ? Text(
              '  ${price!} د.ع',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '  ${(price! * much!)} د.ع',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  '  ${price!} د.ع',
                  style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
    );
  }
}
