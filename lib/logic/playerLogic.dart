
import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _platform = const MethodChannel("com.Raysummee.raylex/audio");

enum PlayerState{
  STOPPED,
  PLAYING,
  PAUSED,
  COMPLETED,
}

class PlayerLogic{
  
  final StreamController<PlayerState> _playerStateController = StreamController.broadcast();
  final StreamController<Duration> _playerPositionController = StreamController.broadcast();

  PlayerState _playerState = PlayerState.STOPPED;
  Duration _duration = const Duration();

  PlayerLogic(){
    _platform.setMethodCallHandler(_audioPlayerStateChange);
  }


  
  
  void playMusic(String uri){
    _platform.invokeMethod("playMusic", <String, Object>{
      "url": uri,
    });
  }

  void pauseMusic(){
    _platform.invokeMethod("pauseMusic");
  }

  void seekToMusic(double seek){
    _platform.invokeMethod("seekToMusic",<String, Object>{
      "seek": seek,
    });
  }

  Stream<PlayerState> get onPlayerStateChanged => _playerStateController.stream;

  PlayerState get state => _playerState;

  Duration get duration => _duration;

  Stream<Duration> get onAudioPositionChanged => _playerPositionController.stream;

  Future<void> _audioPlayerStateChange(MethodCall call) async{
    switch(call.method){
      case "audio.onCurrentPosition":
        _playerPositionController.add(Duration(milliseconds: call.arguments));
        break;
      case "audio.onStart":
        _playerState = PlayerState.PLAYING;
        _playerStateController.add(PlayerState.PLAYING);
        print('PLAYING ${call.arguments}');
        _duration = Duration(milliseconds: call.arguments);
        break;
      case "audio.onPause":
        _playerState = PlayerState.PAUSED;
        _playerStateController.add(PlayerState.PAUSED);
        break;
      case "audio.onStop":
        _playerState = PlayerState.STOPPED;
        _playerStateController.add(PlayerState.STOPPED);
        break;
      case "audio.onComplete":
        _playerState = PlayerState.COMPLETED;
        _playerStateController.add(PlayerState.COMPLETED);
        break;
      case "audio.onError":
        _playerState = PlayerState.STOPPED;
        _playerStateController.add(call.arguments);
        break;
      default:
        throw ArgumentError("Unknown method ${call.method}");
      
    }
  }
}