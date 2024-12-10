import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class SoundManager {
  SoundManager.soundManagerConstructor();

  static final SoundManager instance = SoundManager.soundManagerConstructor();

  final Soundpool soundpool1 = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);

  final Soundpool soundpool2 = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);

  bool firstSoundPoolIsBusy = false;
  final AudioPlayer longAudioPlayer = AudioPlayer();
  Map<String, int> soundsIds = {};

  void playSound(String key) async {
    if (!soundsIds.containsKey(key)) return;

    if (firstSoundPoolIsBusy) {
      soundpool2.play(soundsIds[key]!);
      return;
    }

    firstSoundPoolIsBusy = true;
    soundpool1.play(soundsIds[key]!);
    Future.delayed(Durations.long2).then((value) => firstSoundPoolIsBusy = false);
  }

  Future<void> loadSound(String path, String key) async {
    int soundId1 = await rootBundle.load(path).then((ByteData soundData) {
      return soundpool1.load(soundData);
    });
    int soundId2 = await rootBundle.load(path).then((ByteData soundData) {
      return soundpool2.load(soundData);
    });

    if (soundId1 != soundId2) throw Exception("Sounds ids do not match");
    soundsIds[key] = soundId1;
  }

  void playBackgroundAudio() {
    // longAudioPlayer.play(AssetSource("audio/game_loop_background_audio.wav"));
  }

  void pauseBackgroundAudio() {
    // longAudioPlayer.pause();
  }

  void endBackgroundAudio() {
    // print("stopping background sound");
    // longAudioPlayer.stop();
    // longAudioPlayer.release();
  }
}
