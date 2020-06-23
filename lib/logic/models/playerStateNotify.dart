import 'package:flutter/foundation.dart';

class PlayerStateNotify with ChangeNotifier{


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

  bool _playerVisible;

  bool get playerVisible => _playerVisible;

  set playerVisible(bool visibility){
    _playerVisible = visibility;
    notifyListeners();
  }


}