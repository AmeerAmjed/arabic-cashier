import 'package:cashier/database/product_database.dart';
import 'package:cashier/model/Product.dart';
import 'package:cashier/screens/add_product/add_product_interaction.dart';
import 'package:flutter/material.dart';

class AddProductController extends ChangeNotifier
    implements AddProductInteraction {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController much = TextEditingController();
  String? _label;
  ProductDatabase productDatabase = ProductDatabase();

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "مطلوب *";
    }
    return null;
  }

  setLabel(String value) {
    _label = value;
  }

  @override
  Future<AddProductState> saveProduct() async {
    if (_label != null) {
      if (formKey.currentState!.validate()) {
        try {
          await productDatabase.insert(Product(
            title: title.text,
            price: int.tryParse(price.text),
            much: int.tryParse(much.text),
            lable: _label,
          ));
          return AddProductState.LABEL_IS_EXISTS;
        } catch (error) {
          return AddProductState.ADDED;
        }
      } else
        return AddProductState.ERROR_ALL_FIELD_REQUIRED;
    } else {
      return AddProductState.ERROR_LABEL_NULL;
    }
  }
}
