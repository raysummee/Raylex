import 'package:Raylex/logic/models/songInfo.dart';
import 'package:flutter/foundation.dart';

class PlayerStateNotify with ChangeNotifier{



  List<SongInfo> _songinfos;

  List<SongInfo> get songinfos => _songinfos;

  set songinfos(List<SongInfo> songinfolist){
    _songinfos = songinfolist;
    notifyListeners();
  }



}