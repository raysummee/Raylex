
import 'dart:async';
import 'package:Raylex/logic/models/songInfo.dart';
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
  final StreamController<int> _playlistPositionController = StreamController.broadcast();

  PlayerState _playerState = PlayerState.STOPPED;
  Duration _duration = const Duration();
  Duration _audioPosition = const Duration();
  int _playlistPosition = 0;

  PlayerLogic(){
    
    print("constructor");
  }

  void setMethodCallHandler(){
    _platform.setMethodCallHandler(_audioPlayerStateChange);
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

  Future<int> getAudioSessionID() async{
    return await _platform.invokeMethod("getSessionMusicId");
  }

  void seekToMusic(double seek) async{
    await _platform.invokeMethod("seekTo",<String, Object>{
      "seek": seek,
    });
  }

  void nextSong(List<SongInfo> songinfos, int currentpos) async{
    if(currentpos<songinfos.length){
      playMusic(songinfos.elementAt(++currentpos).uri);
      print("nextsong ${++currentpos}");
    }else{
      print("no more songs");
    }
  }

  void prevSong(List<SongInfo> songinfos, int currentpos) async{
    if(currentpos>0){
      playMusic(songinfos.elementAt(--currentpos).uri);
      print("nextsong ${--currentpos}");
    }else{
      print("no more songs");
    }
  }

  Stream<PlayerState> get onPlayerStateChanged => _playerStateController.stream;

  PlayerState get state => _playerState;

  
  Stream<bool> get onPlayerSecondaryStateChanged => _playerStateSecondaryController.stream;

  Stream<Duration> get onDurationChanged => _songDurationController.stream;

  Duration get duration => _duration;

  Duration get audioPosition => _audioPosition;

  Stream<Duration> get onAudioPositionChanged => _playerPositionController.stream;

  int get playlistPosition => _playlistPosition;

  Stream<int> get onPlaylistPositionChanged => _playlistPositionController.stream;

  Future<bool> onInstanceIsPlaying() async{
    return await _platform.invokeMethod("onInstanceIsPlaying");
  }

  Future<int> getPlaylistPosition() async{
    _playlistPosition = await _platform.invokeMethod("getPlaylistPosition");
    _playlistPositionController.add(_playlistPosition);
   // print("getplaylistposition $_playlistPosition");
    return _playlistPosition;
  }

  void setPlaylistPostion(int pos) async{
    _playlistPosition = pos;
    print("initital set");
    _playlistPositionController.add(pos);
    print("stream set");
    await _platform.invokeMethod("setPlaylistPosition", <String, Object>{
      "pos": pos,
    });
    print("adroid setted");
  }




  Future<void> _audioPlayerStateChange(MethodCall call) async{
    switch(call.method){
      case "audio.onCurrentPosition":
        //assert(_playerState == PlayerState.PLAYING);
        _playerPositionController.add(Duration(milliseconds: call.arguments));
        _audioPosition = Duration(milliseconds: call.arguments);
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
        //if(audioPosition == duration)
        //  nextSong(songinfos);
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