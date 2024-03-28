import 'package:cashier/model/Product.dart';
import 'package:flutter/foundation.dart';

class Data with ChangeNotifier {
  List<Product>? listItem;

  get getListItem => this.listItem;

  set setListItem(listItem) {
    this.listItem = listItem;
    notifyListeners();
  }
}
