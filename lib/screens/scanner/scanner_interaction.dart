import 'package:cashier/model/Product.dart';

abstract class ScannerInteraction {

}

enum ScannerAction {
  ADD,
  DELETE,
  READ;

  String getTitle() {
    if (this == ADD)
      return "أضافة باركود";
    else if (this == READ)
      return "قرأءة باركود";
    else if (this == DELETE)
      return "حذف باركود";
    else
      return "";
  }
}
