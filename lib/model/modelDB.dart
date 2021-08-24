const String tableName = 'cashier';
const String dbName = 'dbcashier.db';

const columnId = 'id';
const columnLable = 'lable';
const columnTitle = 'title';
const columnPrice = 'price';

class ModelDB {
  int? id;
  String? lable;
  String? title;
  int? price;
  int? much;

  ModelDB({
    required this.lable,
    required this.title,
    required this.price,
    required this.much,
  });
  ModelDB.add({
    this.id,
    required this.lable,
    required this.title,
    required this.price,
  });
  ModelDB.scanner({
    this.id,
    required this.lable,
    required this.title,
    required this.price,
    this.much = 1,
  });
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

  static ModelDB fromMap(Map<String, dynamic> map) {
    return ModelDB.scanner(
      id: map['id'],
      lable: map['lable'],
      title: map['title'],
      price: map['price'],
      much: 1,
    );
  }
}
