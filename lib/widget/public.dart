import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';

enum Alerts { done, error }

notfi(Alerts state) {
  return AssetsAudioPlayer.playAndForget(
      Audio('assets/soundAlerts/${describeEnum(state)}.ogg'));
}
