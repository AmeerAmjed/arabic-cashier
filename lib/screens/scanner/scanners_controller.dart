import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cashier/screens/scanner/scanner_effect.dart';
import 'package:flutter/foundation.dart';

class ScannersController extends ChangeNotifier implements ScannerEffect {
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
