import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cashier/database/database.dart';
import 'package:cashier/screens/scanner/scanner_effect.dart';
import 'package:cashier/screens/scanner/scanners_controller.dart';
import 'package:cashier/widget/AppBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

enum ScannerAction { ADD, DELETE, READ }

class Scanners extends StatefulWidget {
  final ScannerAction action;
  final ScannerEffect effect;

  const Scanners({
    Key? key,
    this.action = ScannerAction.READ,
    required this.effect,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ScannersState();
}

class _ScannersState extends State<Scanners>
    with SingleTickerProviderStateMixin {
  late ScannerAction action;

  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Animation<int>? animation;
  AnimationController? animationController;
  double sizeScannerCamare = 300.0;
  double sizeScanner = 250.0;

  bool cameraBack = true;
  bool flash = false;
  bool empty = true;
  late ScannerEffect effect;

  late final bool scanMoreItems;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
    action = widget.action;
    effect = widget.effect;
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
    final scannersController = context.watch<ScannersController>();
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Scaffold(
      appBar: AppbarBack(
        nameScreen: "قرأءة باركود",
        action: true,
        onPressed: () => newMethod(context),
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 20,
              borderWidth: 10,
              cutOutSize: scanArea,
            ),
          ),
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
      floatingActionButton: scannersController.productLabel.isNotEmpty
          ? FloatingActionButton(
              child: Icon(
                Icons.done,
                size: 33.0,
              ),
              onPressed: () {
                // Navigator.pop(context);
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

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      this.qrController = qrController;
    });

    qrController.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        if (action == ScannerAction.READ) {
          effect.addNewProductLabel(scanData.code!);
        }
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
