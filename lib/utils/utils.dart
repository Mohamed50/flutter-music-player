import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/model/schema/artist.dart';
import 'package:local_music_player/model/schema/media-type.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:tinycolor/tinycolor.dart';

bool isFileSupported(FileSystemEntity file) {
  if (file is File &&
      SUPPORTED_FILE_TYPES.contains(file.path.split('.').last.toUpperCase())) {
    return true;
  } else {
    return false;
  }
}

String mediaTypeToLanguage(MediaType mediaType) {
  if (mediaType is Album)
    return "Album";
  else if (mediaType is Track)
    return "Track";
  else if (mediaType is Artist)
    return "Artist";
  else if (mediaType is Playlist)
    return "Playlist";
  else
    return null;
}

int binaryIndexOf(List<dynamic> collectionList, List<dynamic> keywordList) {
  int indexOfKeywordList = -1;
  for (int index = 0; index < collectionList.length; index++) {
    List<dynamic> object = collectionList[index];
    if (object[0] == keywordList[0] && object[1] == keywordList[1]) {
      indexOfKeywordList = index;
      break;
    }
  }
  return indexOfKeywordList;
}

bool binaryContains(List<dynamic> collectionList, List<dynamic> keywordList) => binaryIndexOf(collectionList, keywordList) != -1 ? true : false;


Future<void> writeContentToFile(File file, Map content) async {
  await file.writeAsString(json.encode(content));
}

Future<dynamic> readContentFromFile(File file) async {
  return json.decode(await file.readAsString());
}

bool isDarkColor(Color color){
  return TinyColor(color).isDark();
}