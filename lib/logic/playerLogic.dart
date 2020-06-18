
import 'package:flutter/services.dart';

class PlayerLogic{
  static const platform = const MethodChannel("com.Raysummee.raylex/audio");
  
  void playMusic(String uri){
    platform.invokeMethod("playMusic", <String, Object>{
      "url": uri,
    });
  }

  void pauseMusic(){
    platform.invokeMethod("pauseMusic");
  }

  void seekToMusic(double seek){
    platform.invokeMethod("seekToMusic",<String, Object>{
      "seek": seek,
    });
  }
}