import 'package:local_music_player/model/schema/artist.dart';
import 'package:local_music_player/model/schema/track.dart';

class Album{
  final Artist artist;
  final List<Track> tracks;
  Album(this.artist, this.tracks);
}