import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? songName;
  String? currentSongPath;

  bool get isPlaying => _isPlaying;

  AudioPlayerService() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        _isPlaying = true;
      }
      if (state == PlayerState.completed) {
        _isPlaying = false;
      }
      if (state == PlayerState.disposed) {
        _isPlaying = false;
      }
      if (state == PlayerState.paused) {
        _isPlaying = false;
      }
      if (state == PlayerState.stopped) {
        _isPlaying = false;
      }
      notifyListeners();
    });
  }

  setSongNameAnd(String name) {
    songName = name;
    notifyListeners();
  }

  setPlaying(bool isPlay) {
    _isPlaying = isPlay;
    notifyListeners();
  }

  AudioPlayer get player => _audioPlayer;

  void pause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    }
  }

  void playPause(String url) {
    if (_isPlaying) {
      _audioPlayer.pause();
      _audioPlayer.play(AssetSource(url));
    } else {
      _audioPlayer.play(AssetSource(url));
    }
    _isPlaying = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
