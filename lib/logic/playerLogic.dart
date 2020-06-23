
import 'dart:async';
import 'package:flutter/services.dart';

//channel id for the audio operation
const MethodChannel _platform = const MethodChannel("com.Raysummee.raylex/audio");


enum PlayerState{
  STOPPED,
  PLAYING,
  PAUSED,
  BUFFERING,
}

class PlayerLogic{
  
  final StreamController<PlayerState> _playerStateController = StreamController.broadcast();
  final StreamController<bool> _playerStateSecondaryController = StreamController.broadcast();
  final StreamController<Duration> _playerPositionController = StreamController.broadcast();
  final StreamController<Duration> _songDurationController = StreamController.broadcast();

  PlayerState _playerState = PlayerState.STOPPED;
  Duration _duration = const Duration();

  PlayerLogic(){
    _platform.setMethodCallHandler(_audioPlayerStateChange);
    
    print("constructor");
  }

  void getInitDuration() async{
    int initDuration = await _platform.invokeMethod("getDuration");
    
    _duration = Duration(milliseconds: initDuration);
    _songDurationController.add(Duration(milliseconds: initDuration));
  }
  
  void playMusic(String uri) async{
    await _platform.invokeMethod("playMusic", <String, Object>{
      "url": uri,
    });
  }

  void pauseMusic() async{
    await _platform.invokeMethod("pauseMusic");
  }

  void playPausedMusic() async{
    await _platform.invokeMethod("playPausedMusic");
  }

  void seekToMusic(double seek) async{
    await _platform.invokeMethod("seekTo",<String, Object>{
      "seek": seek,
    });
  }

  Stream<PlayerState> get onPlayerStateChanged => _playerStateController.stream;

  PlayerState get state => _playerState;

  
  Stream<bool> get onPlayerSecondaryStateChanged => _playerStateSecondaryController.stream;

  Stream<Duration> get onDurationChanged => _songDurationController.stream;

  Duration get duration => _duration;

  Stream<Duration> get onAudioPositionChanged => _playerPositionController.stream;

  Future<bool> onInstanceIsPlaying() async{
    return await _platform.invokeMethod("onInstanceIsPlaying");
  }

  Future<void> _audioPlayerStateChange(MethodCall call) async{
    switch(call.method){
      case "audio.onCurrentPosition":
        //assert(_playerState == PlayerState.PLAYING);
        _playerPositionController.add(Duration(milliseconds: call.arguments));
        break;
      case "audio.onStart":
        _playerState = PlayerState.PLAYING;
        _playerStateController.add(PlayerState.PLAYING);
        _playerStateSecondaryController.add(true);
        print('PLAYING ${call.arguments}');
        _duration = Duration(milliseconds: call.arguments);
        _songDurationController.add(Duration(milliseconds: call.arguments));
        break;
      case "audio.onPause":
        _playerState = PlayerState.PAUSED;
        _playerStateController.add(PlayerState.PAUSED);
        _playerStateSecondaryController.add(false);
        break;
      case "audio.onStop":
        _playerState = PlayerState.STOPPED;
        _playerStateController.add(PlayerState.STOPPED);
        _playerStateSecondaryController.add(false);
        break;
      case "audio.onBuffer":
        _playerState = PlayerState.BUFFERING;
        _playerStateController.add(PlayerState.BUFFERING);
        _playerStateSecondaryController.add(false);
        break;
      case "audio.onError":
        _playerState = PlayerState.STOPPED;
        _playerStateController.add(call.arguments);
        _playerStateSecondaryController.add(false);
        break;
      default:
        throw ArgumentError("Unknown method ${call.method}");
      
    }
  }
}