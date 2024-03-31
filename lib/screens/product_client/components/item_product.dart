import 'package:cashier/model/Product.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final Product product;

  const ItemProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          '${product.much!}X',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      title: Text(
        product.title!,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
      subtitle: Text(
        product.lable!,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
      trailing: product.much! == 1
          ? Text(
              '  ${product.price!} د.ع',
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
                  '  ${(product.price! * product.much!)} د.ع',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  '  ${product.price!} د.ع',
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
