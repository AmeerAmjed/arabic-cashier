abstract class AddProductInteraction {
  Future<AddProductState> saveProduct();
}

enum AddProductState {
  ADDED,
  ERROR_LABEL_NULL,
  ERROR_ALL_FIELD_REQUIRED,
  LABEL_IS_EXISTS;

  String getTitle() {
    if (this == ADDED)
      return "تم اضافة المنتج بنجاح.";
    else if (this == ERROR_LABEL_NULL)
      return "اليبل فارغ يرجى مسح المنتج مجددا.";
    else if (this == ERROR_ALL_FIELD_REQUIRED)
      return "املاء كل مدخلات مطلبوبة.";
    else if (this == LABEL_IS_EXISTS)
      return "اليبل مضاف مسبقا.";
    else
      return "";
  }
}
