import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/views/customs/customs-container.dart';

class PlaylistCover extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCover({Key key, this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CardContainer(
        borderRadius: BorderRadius.circular(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1,
            children: [
              Image.file(
                playlist.tracks.first.albumArt,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.overlay,
                color: Colors.black38,
              ),
              Image.file(
                playlist.tracks.length > 1 ? playlist.tracks[1].albumArt : playlist.tracks.first.albumArt,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.overlay,
                color: Colors.black38,
              ),
              Image.file(
                playlist.tracks.length > 2 ? playlist.tracks[2].albumArt : playlist.tracks.first.albumArt,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.overlay,
                color: Colors.black38,
              ),
              Image.file(
                playlist.tracks.length > 3 ? playlist.tracks[3].albumArt : playlist.tracks.first.albumArt,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.overlay,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
