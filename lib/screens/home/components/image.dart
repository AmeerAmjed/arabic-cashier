import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
  final String urlAssetImage;

  const ContainerImage({
    Key? key,
    this.urlAssetImage = 'assets/images/shoppingCart.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 3,
          image: new ExactAssetImage(urlAssetImage),
        ),
      ),
    );
  }
}
