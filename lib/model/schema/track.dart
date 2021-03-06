import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_music_player/config/configuration.dart';
import 'package:local_music_player/utils/utils.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart' as path;
import 'media-type.dart';

List<Track> tracksFromJson(List<dynamic> json) => List<Track>.from(json.map((x) => Track.fromCollectionMap(x))) ?? [];

List<dynamic> tracksToJson(List<Track> data) => List<dynamic>.from(data.map((x) => x.toMap()));


class Track extends MediaType {
  String trackName;
  String albumName;
  int trackNumber;
  int year;
  String albumArtistName;
  List<String> trackArtistNames;
  String filePath;
  String albumArtHigh;
  String albumArtMedium;
  String albumArtLow;
  int trackDuration;
  String trackId;
  String albumId;
  File get albumArt {
    File albumArtFile = File(path.join(configuration.cacheDirectory.path, 'albumArts', '${this.albumArtistName}_${this.albumName}'.replaceAll(new RegExp(r'[^\s\w]'), ' ') + '.PNG'));
    if (albumArtFile.existsSync())
      return albumArtFile;
    else if (filePath != null){
      List<String> temp = filePath.split("/");
      temp.removeLast();
      String albumDirPath = temp.join("/");
      File albumArtFile = File(albumDirPath+ '/Cover.jpg');
      if(albumArtFile.existsSync())
        return albumArtFile;
    }
    return null;
  }
  String type = 'Track';
  Color dominateColor;
  Color secondaryColor;
  Color accentColor;

  @override
  Map<String, dynamic> toMap() {
    return {
      'trackName': this.trackName,
      'albumName': this.albumName,
      'trackNumber': this.trackNumber,
      'year': this.year,
      'albumArtistName': this.albumArtistName,
      'trackArtistNames': this.trackArtistNames ?? <dynamic>['Unknown Artist'],
      'filePath' : this.filePath,
      'albumArtHigh': this.albumArtHigh,
      'albumArtMedium': this.albumArtHigh,
      'albumArtLow': this.albumArtHigh,
      'trackDuration': this.trackDuration,
      'trackId': this.trackId,
      'albumId': this.albumId,
      'type': this.type,
      'dominateColor': this.dominateColor.value,
      'secondaryColor': this.secondaryColor.value,
      'accentColor': this.accentColor.value,
    };
  }

  static Future<Track> fromMap(Map<String, dynamic> trackMap) async {
    if (trackMap == null) return null;
    Track track = new Track(
      trackName: trackMap['trackName'] ?? 'Unknown Track',
      albumName: trackMap['albumName'] ?? 'Unknown Album',
      trackNumber: trackMap['trackNumber'],
      year: trackMap['year'],
      albumArtistName: trackMap['albumArtistName'] ?? 'Unknown Artist',
      trackArtistNames: ((trackMap['trackArtistNames'] ?? <String>['Unknown Artist']) as List).cast<String>(),
      filePath: trackMap['filePath'],
      albumArtHigh: trackMap['albumArtHigh'],
      albumArtMedium: trackMap['albumArtMedium'],
      albumArtLow: trackMap['albumArtLow'],
      trackDuration: trackMap['trackDuration'],
      trackId: trackMap['trackId'],
      albumId: trackMap['albumId'],
    );
    await track.fetchDominateColor();
    return track;
  }

  static Track fromCollectionMap(Map<String, dynamic> trackMap) {
    if (trackMap == null) return null;
    Track track = new Track(
      trackName: trackMap['trackName'] ?? 'Unknown Track',
      albumName: trackMap['albumName'] ?? 'Unknown Album',
      trackNumber: trackMap['trackNumber'],
      year: trackMap['year'],
      albumArtistName: trackMap['albumArtistName'] ?? 'Unknown Artist',
      trackArtistNames: ((trackMap['trackArtistNames'] ?? <String>['Unknown Artist']) as List).cast<String>(),
      filePath: trackMap['filePath'],
      albumArtHigh: trackMap['albumArtHigh'],
      albumArtMedium: trackMap['albumArtMedium'],
      albumArtLow: trackMap['albumArtLow'],
      trackDuration: trackMap['trackDuration'],
      trackId: trackMap['trackId'],
      albumId: trackMap['albumId'],
      dominateColor: Color(trackMap['dominateColor']),
      secondaryColor: Color(trackMap['secondaryColor']),
      accentColor: Color(trackMap['accentColor']),
    );
    return track;
  }

  Track({this.trackName, this.albumName, this.trackNumber, this.year, this.albumArtistName, this.trackArtistNames, this.filePath, this.albumArtHigh, this.albumArtMedium, this.albumArtLow, this.trackDuration, this.trackId, this.albumId, this.dominateColor, this.secondaryColor, this.accentColor});


  Future fetchDominateColor() async{
    if(albumArt != null) {
      Size size = Size(500.0, 500.0);
      PaletteGenerator paletteGenerator = await PaletteGenerator
          .fromImageProvider(
        FileImage(albumArt),
        size: size,
        region: Offset.zero & size,
        maximumColorCount: 20,
      );
      if(paletteGenerator.vibrantColor != null) {
        accentColor = paletteGenerator.dominantColor.color;
        secondaryColor = paletteGenerator.vibrantColor.titleTextColor;
        dominateColor = paletteGenerator.vibrantColor.color;
        if(dominateColor.value == accentColor.value)
          fetchAccentColor();
      }
      else{
        secondaryColor = paletteGenerator.dominantColor.titleTextColor;
        dominateColor = paletteGenerator.dominantColor.color;
        fetchAccentColor();
      }
      return;
    }
    accentColor = Colors.white;
    secondaryColor = Colors.grey[200];
    dominateColor = Colors.grey[900];
  }

  void fetchAccentColor(){
    accentColor = isDarkColor(dominateColor)
        ? Colors.white
        : Colors.grey[900];
  }


}
