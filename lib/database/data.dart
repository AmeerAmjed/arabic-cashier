import 'package:cashier/model/modelDB.dart';
import 'package:flutter/foundation.dart';

class Data with ChangeNotifier {
  List<ModelDB>? listItem;

  get getListItem => this.listItem;

  set setListItem(listItem) {
    this.listItem = listItem;
    notifyListeners();
  }
}
