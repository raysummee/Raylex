import 'package:flutter/widgets.dart';

class PlaylistPosition extends ChangeNotifier{
  int _index;

  int get index=>_index;

  set index(int index){
    _index = index;
    notifyListeners();
  }
}