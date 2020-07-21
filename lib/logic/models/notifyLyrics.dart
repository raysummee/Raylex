import 'package:flutter/foundation.dart';

class NotifyLyrics extends ChangeNotifier{
  String _lyrics;

  String get lyrics=>_lyrics;

  set lyrics(String lyrics){
    _lyrics = lyrics;
    notifyListeners();
  }
}