import 'package:cashier/model/Product.dart';
import 'package:flutter/cupertino.dart';

class ProductsClientController extends ChangeNotifier {
  final List<Product> products = [
    Product(
      title: "ameer2",
      price: 1000,
      much: 10002,
      lable: "1",
    ),
    Product(
      title: "ameer1",
      price: 1000,
      much: 10002,
      lable: "2",
    )
  ];


  List<Product>? listItem;

  get getListItem => this.listItem;

  set setListItem(listItem) {
    this.listItem = listItem;
    notifyListeners();
  }
}
