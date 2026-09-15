class AddSongPlaylistDataModel {
  int? status;
  String? message;
  int? playlistsongsId;
  int? playlistId;
  int? songId;

  AddSongPlaylistDataModel(
      {this.status,
      this.message,
      this.playlistsongsId,
      this.playlistId,
      this.songId});

  AddSongPlaylistDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    playlistsongsId = json['playlistsongs_id'];
    playlistId = json['playlist_id'];
    songId = json['song_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['playlistsongs_id'] = playlistsongsId;
    data['playlist_id'] = playlistId;
    data['song_id'] = songId;
    return data;
  }
}
