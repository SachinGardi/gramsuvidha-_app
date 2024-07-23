import 'package:audioplayers/audioplayers.dart';

class Music {
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();

  Music._privateConstructor() {
    this.player.setVolume(0.5);
  }

  static final Music instance = Music._privateConstructor();

  Future playLoop(String filePath) async {
    await player.play(AssetSource(filePath));
  }

  void stopLoop() {
    player.stop();
  }
}
