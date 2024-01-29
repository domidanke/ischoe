import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

class AudioService {
  factory AudioService() {
    return _singleton;
  }
  AudioService._internal();
  static final AudioService _singleton = AudioService._internal();
  final _audioPlayer = AudioPlayer();

  Future<void> playRandomIschoe() async {
    Random random = Random();
    int randomIndex = random.nextInt(10) + 1;
    await _audioPlayer.play(AssetSource('audio/ischoe$randomIndex.mp4'));
  }
}
