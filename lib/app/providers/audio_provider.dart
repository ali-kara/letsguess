import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _backgroundMusicPlayer = AudioPlayer();
  final AudioPlayer _soundEffectsPlayer = AudioPlayer();

  bool _isMusicEnabled = true;
  bool _isSoundEnabled = true;
  bool _isMusicPlaying = true;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSoundEnabled => _isSoundEnabled;
  bool get isMusicPlaying => _isMusicPlaying;

  AudioProvider() {
    _initAudio();
  }

  void _initAudio() async {
    await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
    await _soundEffectsPlayer.setReleaseMode(ReleaseMode.stop);
  }

  void toggleMusic() async {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      await playBackgroundMusic();
    } else {
      await stopBackgroundMusic();
    }
    notifyListeners();
  }

  void toggleSound() {
    _isSoundEnabled = !_isSoundEnabled;
    notifyListeners();
  }

  Future<void> playBackgroundMusic() async {
    if (!_isMusicEnabled) return;

    try {
      await _backgroundMusicPlayer.play(AssetSource('audio/music.mp3'));
      _isMusicPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _backgroundMusicPlayer.stop();
      _isMusicPlaying = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping background music: $e');
    }
  }

  Future<void> playTapSound() async {
    if (!_isSoundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/tap.wav'));
    } catch (e) {
      debugPrint('Error playing tap sound: $e');
    }
  }

  @override
  void dispose() {
    _backgroundMusicPlayer.dispose();
    _soundEffectsPlayer.dispose();
    super.dispose();
  }
}
