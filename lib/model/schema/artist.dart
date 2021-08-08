import 'package:local_music_player/model/schema/track.dart';
import 'album.dart';
import 'media-type.dart';

List<Artist> artistsFromJson(List<dynamic> json) => List<Artist>.from(json.map((x) => Artist.fromMap(x))) ?? [];

List<dynamic> artistsToJson(List<Artist> data) => List<dynamic>.from(data.map((x) => x.toMap()));

class Artist extends MediaType {
  String artistName;
  List<Album> albums = <Album>[];
  List<Track> tracks = <Track>[];
  String type = 'Artist';

  @override
  Map<String, dynamic> toMap() {
    return {
      'trackArtistNames': this.artistName,
      'albums': albumsToJson(albums),
      'tracks': tracksToJson(tracks),
      'type': this.type,
    };
  }

  static Artist fromMap(Map<String, dynamic> artistMap) {
    return new Artist.fromCollection(
      artistName: artistMap['artistName'],
      albums: albumsFromJson(artistMap["albums"]),
      tracks: tracksFromJson(artistMap["tracks"])
    );
  }

  Artist({this.artistName});

  Artist.fromCollection({this.artistName, this.tracks, this.albums});
}
