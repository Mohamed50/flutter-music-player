import 'package:local_music_player/model/schema/track.dart';

import 'album.dart';

class Artist{

  final String name;
  final List<Album> albums;
  final List<Track> tracks = [];

  Artist({this.name, this.albums : const []}){
   albums.forEach((element) => tracks.addAll(element.tracks));
  }




}