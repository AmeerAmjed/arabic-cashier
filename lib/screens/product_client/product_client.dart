import 'package:cashier/screens/home/components/appBar.dart';
import 'package:cashier/screens/product_client/components/background_dismissible.dart';
import 'package:cashier/screens/product_client/components/item_product.dart';
import 'package:cashier/screens/product_client/components/product_count.dart';
import 'package:cashier/screens/product_client/product_client_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsClient extends StatefulWidget {
  const ProductsClient({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ProductsClient> {
  final TextEditingController _textcontroller = TextEditingController();

  // AudioPlayer advancedPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    final productsControllers = context.watch<ProductsClientController>();

    double buttonWidth = MediaQuery.of(context).size.width *
        0.5; //getting half of the current width for each button
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ProductCount(
            count: productsControllers.products.length.toString(),
          ),
          Expanded(
            flex: (productsControllers.products.length * 0.4).toInt(),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: productsControllers.products.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(productsControllers.products[index].toString()),
                    child: Card(
                      margin: EdgeInsets.all(2.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ItemProduct(
                        product: productsControllers.products[index],
                      ),
                    ),
                    background: BackgroundDismissible(
                      title: "مضاعفه المنتج",
                      icon: Icons.add,
                      colorBackground: Colors.green,
                      action: ActionDismissible.RIGHT,
                    ),
                    // secondaryBackground: slideLeftBackground(),
                    secondaryBackground: BackgroundDismissible(
                      title: " حذف المنتج",
                      icon: Icons.delete,
                      colorBackground: Colors.red,
                      action: ActionDismissible.LEFT,
                    ),

                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text.rich(
                                  TextSpan(
                                    text: " هل تريد حذف المنتج",
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${productsControllers.products[index].title}؟',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        productsControllers.products
                                            .removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  " عدد مرات تكرار المنتج ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            int currentValue =
                                                int.parse(_textcontroller.text);
                                            setState(() {
                                              currentValue--;
                                              _textcontroller.text =
                                                  (currentValue > 1
                                                          ? currentValue
                                                          : 1)
                                                      .toString();
                                            });
                                          },
                                          child: Icon(Icons.remove)),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        width: 50,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          textAlign: TextAlign.center,
                                          controller: _textcontroller
                                            ..text =
                                                "${productsControllers.products[index].much}",
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                            decimal: false,
                                            signed: true,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          int currentValue =
                                              int.parse(_textcontroller.text);

                                          setState(() {
                                            currentValue++;
                                            _textcontroller.text = (currentValue)
                                                .toString(); // incrementing value
                                          });
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      int much =
                                          int.parse(_textcontroller.text);
                                      if (much != 1)
                                        setState(() {
                                          productsControllers
                                              .products[index].much = much;
                                        });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      "المبلغ الكلي",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      ' 3د.ع',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: InkWell(
                      onLongPress: () {
                        // List<ModelDB>? data = listItem;
                        // dat.setListItem = null;
                        // print(dat.getListItem);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     backgroundColor: Colors.red,
                        //     content: Text(
                        //       'تم حذف عناصر سلة تسوق',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     action: SnackBarAction(
                        //       label: 'تراجع',
                        //       textColor: Colors.yellow,
                        //       onPressed: () {
                        //         dat.setListItem = data;
                        //       },
                        //     ),
                        //   ),
                        // );
                      },
                      child: RawMaterialButton(
                        onPressed: () {
                          print("objectu");
                        },
                        elevation: 2.0,
                        fillColor: Colors.indigo[700],
                        child: Icon(
                          Icons.print,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_outlined),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Scanners(),
          //   ),
          // );
        },
      ),
    );
  }
}
