import 'media-type.dart';
import 'track.dart';

List<Playlist> playlistsFromJson(List<dynamic> json) => List<Playlist>.from(json.map((x) => Playlist.fromMap(x))) ?? [];

List<dynamic> playlistsToJson(List<Playlist> data) => List<dynamic>.from(data.map((x) => x.toMap()));


class Playlist extends MediaType {
  String playlistName;
  int playlistId;
  List<Track> tracks = <Track>[];
  String type = 'Playlist';

  @override
  Map<String, dynamic> toMap() {
    return {
      'playlistName': this.playlistName,
      'playlistId': this.playlistId,
      'tracks': tracksToJson(tracks),
      'type': this.type,
    };
  }

  Playlist({this.playlistName, this.playlistId, this.tracks});

  static Playlist fromMap(Map<String, dynamic> playlistMap) {
    return Playlist(
        playlistId: playlistMap['playlistId'],
        playlistName: playlistMap['playlistName'],
        tracks: tracksFromJson(playlistMap['tracks']),
    );
  }

}
