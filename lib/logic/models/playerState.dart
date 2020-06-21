import 'package:flutter/foundation.dart';

class PlayerState with ChangeNotifier{

  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  set isPlaying(bool isPlaying){
    _isPlaying = isPlaying;
    notifyListeners();
  }

  int _playlistPosition;

  int get playlistPosition => _playlistPosition;

  set playlistPosition(playlistPosition){
    _playlistPosition = playlistPosition;
    notifyListeners();
  }

  Duration _audioDuration;

  Duration get audioDuration => _audioDuration;

  set audioDuration(Duration audioDuration){
    _audioDuration = audioDuration;
    notifyListeners();
  }


}