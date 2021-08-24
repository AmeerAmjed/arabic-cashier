import 'package:cashier/database/data.dart';
import 'package:cashier/model/modelDB.dart';
import 'package:cashier/screens/insertdata/insertData.dart';
import 'package:flutter/material.dart';
import 'package:cashier/screens/home/components/ListTile.dart';
import 'package:cashier/screens/home/components/appBar.dart';

import 'package:flutter/foundation.dart';
import 'package:cashier/screens/home/components/button.dart';
import 'package:cashier/screens/home/components/image.dart';
import 'package:cashier/screens/scanner/scanner.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final List<ModelDB>? datas;
  const Home({
    Key? key,
    required this.datas,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textcontroller = TextEditingController();
  // AudioPlayer advancedPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    List<ModelDB>? listItem = widget.datas;
    final dat = context.watch<Data>();
    int? price = 0;
    if (dat.getListItem != null) {
      for (var item in listItem!) {
        price = (price! + (item.price! * item.much!));
      }
    }
    double buttonWidth = MediaQuery.of(context).size.width *
        0.5; //getting half of the current width for each button
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(),
      body: listItem != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                  child: Row(
                    children: [
                      Stack(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 28,
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.only(top: 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.amber[200],
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14.0,
                                minHeight: 14.0,
                              ),
                              child: Text(
                                listItem.length.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "سلة التسوق",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'Tajawal_Regular', fontSize: 22),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: (listItem.length * 0.4).toInt(),
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
                      itemCount: listItem.length,
                      itemBuilder: (context, index) {
                        // return DismissibleItem(

                        //     key: Key(listItem![index].toString()),
                        //     child: Card(
                        //       margin: EdgeInsets.all(2.0),
                        //       clipBehavior: Clip.antiAliasWithSaveLayer,
                        //       child: ListTiles(
                        //         name: listItem![index].name,
                        //         id: listItem![index].id,
                        //         price: listItem![index].price,
                        //         much: listItem![index].much,
                        //       ),
                        //     ),
                        // );
                        return Dismissible(
                          key: Key(listItem[index].toString()),
                          child: Card(
                            margin: EdgeInsets.all(2.0),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ListTiles(
                              title: listItem[index].title,
                              lable: listItem[index].lable,
                              price: listItem[index].price,
                              much: listItem[index].much,
                            ),
                          ),
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
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
                                                  ' ${listItem[index].title}؟',
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
                                            style:
                                                TextStyle(color: Colors.black),
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
                                              listItem.removeAt(index);
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  int currentValue = int.parse(
                                                      _textcontroller.text);
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
                                                      "${listItem[index].much}",
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                  decimal: false,
                                                  signed: true,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                int currentValue = int.parse(
                                                    _textcontroller.text);

                                                setState(() {
                                                  currentValue++;
                                                  _textcontroller.text =
                                                      (currentValue)
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
                                                listItem[index].much = much;
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
                            ' $priceد.ع',
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
                              List<ModelDB>? data = listItem;
                              dat.setListItem = null;
                              print(dat.getListItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'تم حذف عناصر سلة تسوق',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  action: SnackBarAction(
                                    label: 'تراجع',
                                    textColor: Colors.yellow,
                                    onPressed: () {
                                      dat.setListItem = data;
                                    },
                                  ),
                                ),
                              );
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
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: ContainerImage(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Button(
                            width: buttonWidth,
                            label: 'أضافة',
                            icon: Icons.add_outlined,
                            color: Colors.pink[200]!,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scan(),
                                ),
                              );
                            },
                          ),
                          Button(
                            width: buttonWidth,
                            label: 'تعديل',
                            icon: Icons.edit_outlined,
                            color: Colors.teal[300]!,
                            onPressed: () {
                              SystemSound.play(SystemSoundType.alert);
                            },
                          ),
                        ],
                      ),
                      Button(
                        width: buttonWidth,
                        label: 'قرأءة كود',
                        icon: Icons.qr_code_scanner_outlined,
                        color: Colors.indigo,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scanners(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: listItem != null
          ? FloatingActionButton(
              child: Icon(Icons.add_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scanners(),
                  ),
                );
              },
            )
          : Container(),
    );
  }

  Widget slideRightBackground() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 2.0,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              "مضاعفه المنتج",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 2.0,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        ),
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " حذف المنتج",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
