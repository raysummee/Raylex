import 'package:flutter/foundation.dart';

class ModelPlaylistData{
  String title;
  String imageuri;
  VoidCallback future;

  ModelPlaylistData(
    this.title,
    this.imageuri,
    this.future
  );
}