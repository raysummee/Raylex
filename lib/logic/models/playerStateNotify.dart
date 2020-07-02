import 'package:Raylex/logic/models/songInfo.dart';
import 'package:flutter/foundation.dart';

class PlayerStateNotify with ChangeNotifier{



  List<SongInfo> _songinfos;

  List<SongInfo> get songinfos => _songinfos;

  set songInfos(List<SongInfo> songinfolist){
    _songinfos = songinfolist;
    notifyListeners();
  }

  int _index;

  int get index=>_index;

  set index(int pos){
    _index = pos;
    notifyListeners();
  }


}