import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cashier/screens/scanner/scanner_effect.dart';
import 'package:cashier/screens/scanner/scanner_interaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScannersController extends ChangeNotifier
    implements ScannerEffect, ScannerInteraction {
  List<String> productLabel = [];


  @override
  addNewProductLabel(String label) {
    productLabel.add(label);
    _notify();
    notifyListeners();
  }

  _notify() {
    AssetsAudioPlayer.playAndForget(Audio('assets/soundAlerts/done.ogg'));
  }
}
