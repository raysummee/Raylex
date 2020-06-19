import 'package:Raylex/logic/models/playlistData.dart';
import 'package:flutter/foundation.dart';

class Playlist with ChangeNotifier{
  String _playlistName;

  String get playlistName => _playlistName;

  set playlistName(String playlistName){
    _playlistName = playlistName;
    notifyListeners();
  }

  List<PlaylistData> _currentPlaylist;

  List<PlaylistData> get currentPlaylist => _currentPlaylist;

  set currentPlaylist(List<PlaylistData> currentPlaylist){
    _currentPlaylist = currentPlaylist;
    notifyListeners();
  }

}