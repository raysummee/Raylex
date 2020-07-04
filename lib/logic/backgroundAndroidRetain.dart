import 'package:flutter/services.dart';

const MethodChannel _platform = const MethodChannel("com.Raysummee.raylex/androidRetain");
class BackgroundAndroidRetain{
  void appRetain() async{
    _platform.invokeMethod("sendToBackground");
  }
}