import 'dart:io';
import 'dart:ui';
import 'package:local_music_player/config/configuration.dart';
import 'package:path/path.dart' as path;
import 'package:local_music_player/model/schema/track.dart';
import 'media-type.dart';

List<Album> albumsFromJson(List<dynamic> json) =>
    List<Album>.from(json.map((x) => Album.fromMap(x)));

List<dynamic> albumsToJson(List<Album> data) =>
    List<dynamic>.from(data.map((x) => x.toMap()));

class Album extends MediaType {
  String albumName;
  int year;
  String albumArtistName;
  List<Track> tracks = <Track>[];
  String albumArtHigh;
  String albumArtMedium;
  String albumArtLow;
  String albumId;

  File get albumArt {
    File albumArtFile = File(path.join(
        configuration.cacheDirectory.path,
        'albumArts',
        '${this.albumArtistName}_${this.albumName}'
                .replaceAll(new RegExp(r'[^\s\w]'), ' ') +
            '.PNG'));
    if (albumArtFile.existsSync())
      return albumArtFile;
    else
      return null;
  }

  String type = 'Album';
  Color dominateColor;
  Color secondaryColor;
  Color accentColor;

  @override
  Map<String, dynamic> toMap() {
    return {
      'albumName': this.albumName,
      'year': this.year,
      'albumArtistName': this.albumArtistName,
      'tracks': tracksToJson(tracks),
      'albumArtHigh': this.albumArtHigh,
      'albumArtMedium': this.albumArtHigh,
      'albumArtLow': this.albumArtHigh,
      'albumId': this.albumId,
      'type': this.type,
    };
  }

  static Album fromMap(Map<String, dynamic> albumMap) {
    return new Album(
      albumName: albumMap['albumName'] ?? 'Unknown Album',
      year: albumMap['year'],
      albumArtistName: albumMap['albumArtistName'] ?? 'Unknown Artist',
      albumArtHigh: albumMap['albumArtHigh'],
      albumArtMedium: albumMap['albumArtMedium'],
      albumArtLow: albumMap['albumArtLow'],
      albumId: albumMap['albumId'],
      tracks: tracksFromJson(albumMap["tracks"]),
    );
  }

  Album(
      {this.tracks,
      this.albumName,
      this.year,
      this.albumArtistName,
      this.albumArtHigh,
      this.albumArtMedium,
      this.albumArtLow,
      this.albumId,
      this.dominateColor,
      this.secondaryColor,
      this.accentColor});
}
