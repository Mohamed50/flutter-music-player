import 'package:local_music_player/model/schema/artist.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/model/schema/track.dart';

import 'album.dart';

class Collection{
  List<Track> tracks;
  List<Album> albums;
  List<Artist> artists;
  List<Playlist> playlists;


  Collection({this.tracks, this.albums, this.artists, this.playlists});

  Map<String, dynamic> toMap() {
    return {
      'tracks': tracksToJson(tracks),
      'albums': albumsToJson(albums),
      'artists': artistsToJson(artists),
      'playlists': playlistsToJson(playlists),
    };
  }

  static Collection fromMap(Map<String, dynamic> collectionMap) {
    return new Collection(
      tracks: tracksFromJson(collectionMap['tracks']),
      albums: albumsFromJson(collectionMap['albums']),
      artists: artistsFromJson(collectionMap['artists']),
      playlists: playlistsFromJson(collectionMap['playlists']),
    );
  }


}