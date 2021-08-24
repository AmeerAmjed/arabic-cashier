import 'dart:io';
import 'package:cashier/screens/insertdata/components/input.dart';
import 'package:cashier/widget/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:cashier/database/database.dart';
import 'package:cashier/model/modelDB.dart';

// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanState();
}

class _ScanState extends State<Scan> with SingleTickerProviderStateMixin {
  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Animation<int>? animation;
  AnimationController? animationController;
  double sizeScannerCamare = 300.0;
  double sizeScanner = 250.0;

  bool cameraBack = true;
  bool flash = false;

  bool _isQRScanned = false;

  String? result;
  late List<String> listLableDone;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = IntTween(begin: 0, end: 200).animate(animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController?.forward();
        }
      });

    animationController?.forward();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController!.pauseCamera();
    }
    qrController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBack(nameScreen: "أضافة باركود"),
      body: Stack(
        children: [
          _buildQrView(context),
          Center(
            child: Container(
              width: sizeScanner,
              height: sizeScanner,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    top: animation?.value.toDouble(),
                    child: Container(
                      color: Colors.red,
                      width: sizeScanner,
                      height: 3,
                    ),
                    duration: const Duration(seconds: 1),
                    curve: Curves.linear,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onLongPress: () {
          print('doneee');
          newMethod(context);
        },
        child: FloatingActionButton(
          child: Icon(
            Icons.done,
            size: 33.0,
          ),
          onPressed: () {
            print('ok');
          },
        ),
      ),
    );
  }

  Future<dynamic> newMethod(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: cameraBack
                    ? Icon(Icons.cameraswitch_rounded)
                    : Icon(Icons.camera_front_sharp),
                title: Text("تدوير الكامرة"),
                onTap: () async {
                  await qrController
                      ?.flipCamera()
                      .then((value) => cameraBack = !cameraBack);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: flash ? Icon(Icons.flash_on) : Icon(Icons.flash_off),
                title: Text("فلاش"),
                onTap: () async {
                  await qrController
                      ?.toggleFlash()
                      .then((value) => flash = !flash);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQrView(BuildContext context) {
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 150.0
    //     : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: sizeScannerCamare,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      this.qrController = qrController;
    });
    qrController.scannedDataStream.listen((scanData) {
      newMethodss(scanData.code);
    });
  }

  newMethodss(String scanData) async {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _titlecontroller = TextEditingController();
    final TextEditingController _pricecontroller = TextEditingController();
    if (!_isQRScanned) {
      _isQRScanned = true;

      qrController?.pauseCamera();
      animationController?.stop();
      // FlutterRingtonePlayer.playNotification();

      showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                      Text(
                        "أضافة",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        scanData,
                        style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.w100,
                            fontSize: 10),
                      ),
                      // SizedBox(
                      //   height: 24.0,
                      // ),
                      Input(
                        labelText: 'أسم العنصر',
                        validator: (value) {
                          print("object");
                          if (value == null || value.isEmpty) {
                            return "الأسم  فارغ مطلوب*";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        controller: _titlecontroller,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                      ),
                      Input(
                        labelText: 'السعر',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "السعر فارغ مطلوب *";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        controller: _pricecontroller,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                      ),
                      // SizedBox(
                      //   height: 16.0,
                      // ),
                      Center(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await DB.insert(
                                  tableName,
                                  ModelDB.add(
                                    title: _titlecontroller.text.toString(),
                                    price: int.parse(_pricecontroller.text),
                                    lable: scanData,
                                  ),
                                );
                              } catch (error) {
                                print(error);
                              }
                              await DB
                                  .insert(
                                tableName,
                                ModelDB.add(
                                  title: _titlecontroller.text.toString(),
                                  price: int.parse(_pricecontroller.text),
                                  lable: scanData,
                                ),
                              )
                                  .then((value) {
                                Navigator.pop(context);
                                qrController!.resumeCamera();
                                animationController?.reset();
                                _isQRScanned = false;
                              }).catchError((eror) async {
                                Navigator.pop(context);
                                await showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                          "ليبل مضاف سابقا",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              qrController!.resumeCamera();
                                              animationController?.reset();
                                              _isQRScanned = false;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              });
                            }
                          },
                          height: 50.0,
                          minWidth: 150,
                          child: Text(
                            'حفظ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    qrController?.dispose();
    super.dispose();
  }
}
