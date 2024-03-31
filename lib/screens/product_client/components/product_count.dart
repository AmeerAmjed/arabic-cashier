import 'package:flutter/material.dart';

class ProductCount extends StatelessWidget {
  const ProductCount({
    super.key,
    required this.count,
  });

  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8.0),
      child: Row(
        children: [
          Stack(
            children: <Widget>[
              Icon(
                Icons.shopping_cart_outlined,
                size: 28,
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14.0,
                    minHeight: 14.0,
                  ),
                  child: Text(
                    count,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            "سلة التسوق",
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: 'Tajawal_Regular', fontSize: 22),
          ),
        ],
      ),
    );
  }
}
