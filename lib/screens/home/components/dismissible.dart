import 'package:flutter/material.dart';

class DismissibleItem extends StatelessWidget {
  final Widget child;
  // final Key keyItem;
  // final Future<Function> confirmDismiss;
  const DismissibleItem({
    required Key key,
    // required this.keyItem,
    required this.child,
    // required this.confirmDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      child: child,
      background: functionSlideRight(),
      secondaryBackground: functionSlideLeft(),
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
                                                text:"sss",
                                                    // ' ${listItem![index].name}؟',
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
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                               Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              // setState(() {
                                              //   listItem!.removeAt(index);
                                              // });
                                               Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                // final bool res =

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
                                                    // int currentValue =
                                                    //     int.parse(
                                                    //         _textcontroller
                                                    //             .text);
                                                    // setState(() {
                                                    //   currentValue--;
                                                    //   _textcontroller.text =
                                                    //       (currentValue > 1
                                                    //               ? currentValue
                                                    //               : 1)
                                                    //           .toString();
                                                    // });
                                                  },
                                                  child: Icon(Icons.remove)),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 4.0,
                                                ),
                                                width: 50,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  // controller: _textcontroller
                                                  //   ..text = 's',
                                                        // "${listItem![index].much}",
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                    signed: true,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    // int currentValue =
                                                    //     int.parse(
                                                    //         _textcontroller
                                                    //             .text);
                                                    // setState(() {
                                                    //   currentValue++;
                                                    //   _textcontroller.text =
                                                    //       (currentValue)
                                                    //           .toString(); // incrementing value
                                                    // });
                                                  },
                                                  child: Icon(Icons.add)),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              "Ok",
                                              // style: TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              // setState(() {
                                              //   listItem![index].much =
                                              //       int.parse(
                                              //           _textcontroller.text);
                                              // });
                                              //  Navigator.pop(context);
                                              // // _controller.text = 1.toString();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                // return res;
                                // print(listItem![index].price!);

                                // setState(() {
                                //   listItem![index].price = 300;
                                // });
                              }
                            });
    
  }

  Widget functionSlideRight() {
    return Container(
      color: Colors.green,
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
              "تكرار المنتج",
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

  Widget functionSlideLeft() {
    return Container(
      color: Colors.red,
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
