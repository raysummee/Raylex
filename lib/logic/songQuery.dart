import 'dart:async';

import 'package:Raylex/logic/models/songInfo.dart';
import 'package:flutter/services.dart';


class SongQuery{
  bool _handlePermissions = true;
  bool _executeAfterPermissionGranted = true;

  static const String CHANNEL = "com.Raysummee.raylex/finder";

  static const MethodChannel _channel = const MethodChannel(CHANNEL);

    
  SongQuery setHandlePermissions(bool handlePermissions) {
    _handlePermissions = handlePermissions;
    return this;
  }

  SongQuery setExecuteAfterPermissionGranted(
      bool executeAfterPermissionGranted) {
    _executeAfterPermissionGranted = executeAfterPermissionGranted;
    return this;
  }


    static Future<dynamic> allSongs() async {
    var completer = new Completer();

    // At some time you need to complete the future:
    //making it lazy wait for 1 sec
    await Future.delayed(Duration(seconds: 1));
    Map params = <String, dynamic>{
      "handlePermissions": true,
      "executeAfterPermissionGranted": true,
    };
    List<dynamic> songs = await _channel.invokeMethod('getSongs', params);
    print(songs.runtimeType);
    var mySongs = songs.map((m) => new SongInfo.fromMap(m)).toList();
    completer.complete(mySongs);
    return completer.future;
  }
  
}