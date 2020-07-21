class ModelLyrics{
  int id;
  String lyrics;
  String songName;
  String artistName;
  ModelLyrics({this.id, this.lyrics, this.songName, this.artistName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lyrics': lyrics,
      'songName': songName,
      'artistName': artistName
    };
  }

  @override
  String toString() {
    return 'ModelLyrics("id": ${this.id}, "lyrics":${this.lyrics}, "songName":${this.songName}, "artistName":${this.artistName},);';
  }
}