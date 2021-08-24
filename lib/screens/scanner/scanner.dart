import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cashier/database/data.dart';
import 'package:cashier/database/database.dart';
import 'package:cashier/model/modelDB.dart';
import 'package:cashier/widget/AppBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';

class Scanners extends StatefulWidget {
  final bool scanMoreItems;
  const Scanners({
    Key? key,
    this.scanMoreItems = false,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ScannersState();
}

class _ScannersState extends State<Scanners>
    with SingleTickerProviderStateMixin {
  List<ModelDB> dataLables = [];
  List<String> lables = [];

  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Animation<int>? animation;
  AnimationController? animationController;
  double sizeScannerCamare = 300.0;
  double sizeScanner = 250.0;

  bool cameraBack = true;
  bool flash = false;
  bool empty = true;

  late final bool scanMoreItems;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
    scanMoreItems = widget.scanMoreItems;

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
    final dat = context.watch<Data>();
    return Scaffold(
      appBar: AppbarBack(
        nameScreen: "قرأءة باركود",
        action: true,
        onPressed: () => newMethod(context),
      ),
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
      floatingActionButton: dataLables.length != 0
          ? FloatingActionButton(
              child: Icon(
                Icons.done,
                size: 33.0,
              ),
              onPressed: () {
                if (scanMoreItems) {
                  List<ModelDB> lastItems = dat.getListItem;
                  List<ModelDB> newItems = new List.from(lastItems)
                    ..addAll(dataLables);
                  dat.setListItem = newItems;
                } else {
                  dat.setListItem = dataLables;
                }

                Navigator.pop(context);
              },
            )
          : Container(),
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
          cutOutSize: sizeScannerCamare),
    );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      this.qrController = qrController;
    });

    qrController.scannedDataStream.listen((scanData) async {
      try {
        await DB
            .query(
          table: tableName,
          columns: [columnId, columnTitle, columnLable, columnPrice],
          where: '$columnLable = ?',
          whereArgs: [scanData.code],
        )
            .then((value) async {
          ModelDB data = ModelDB.fromMap(value[0]);

          if (lables.isEmpty) {
            print("isEmpty");
            lables.add(scanData.code);
            dataLables.add(data);
            notfi(Alerts.done);
            // AssetsAudioPlayer.playAndForget(
            //     Audio('assets/soundAlerts/done.ogg'));
          } else {
            print("NotEmpty");
            if (!lables.contains(data.lable)) {
              dataLables.add(data);
              lables.add(scanData.code);
              notfi(Alerts.done);
              // AssetsAudioPlayer.playAndForget(
              //     Audio('assets/soundAlerts/done.ogg'));
            }
          }
        });
      } catch (error) {
        notfi(Alerts.error);
        // AssetsAudioPlayer.playAndForget(Audio('assets/soundAlerts/done.ogg'));
      }
    });
  }

  notfi(Alerts state) {
    return AssetsAudioPlayer.playAndForget(
        Audio('assets/soundAlerts/${describeEnum(state)}.ogg'));
  }

  @override
  void dispose() {
    animationController!.dispose();
    qrController?.dispose();
    super.dispose();
  }
}
