import 'package:cashier/model/base_model.dart';

class Product extends BaseModel {
  int? id;
  String? lable;
  String? title;
  int? price;
  int? much;

  Product({
    required this.lable,
    required this.title,
    required this.price,
    required this.much,
  }) : super(null);

  Product.add({
    this.id,
    required this.lable,
    required this.title,
    required this.price,
  }) : super(id);

  Product.scanner({
    this.id,
    required this.lable,
    required this.title,
    required this.price,
    this.much = 1,
  }) : super(id);
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'lable': lable,
      'title': title,
      'price': price,
      // 'much': much,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product.scanner(
      id: map['id'],
      lable: map['lable'],
      title: map['title'],
      price: map['price'],
      much: 1,
    );
  }
}
