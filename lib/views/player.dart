import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/views/customs/app-bar.dart';
import 'package:local_music_player/views/widgets/player/art-cover.dart';
import 'package:local_music_player/views/widgets/player/circular-slider.dart';
import 'package:local_music_player/views/widgets/player/duration-text.dart';
import 'package:local_music_player/views/widgets/player/player-buttons.dart';
import 'package:local_music_player/views/widgets/player/playlist-manger.dart';
import 'package:local_music_player/views/widgets/player/track-info.dart';

class PlayerPage extends StatelessWidget {
  final Track track;

  const PlayerPage({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: track.dominateColor,
      appBar: CustomAppbar(
        title: track.name,
        backgroundColor: track.dominateColor,
        titleColor: track.accentColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularSlider(
              progressBarColor: track.accentColor,
              dotColor: track.dominateColor,
              trackColor: track.secondaryColor,
              child: ArtCover(
                coverArt: track.coverArt,
                backgroundColor: track.dominateColor,
              ),
            ),
            DurationText(
              seconds: track.metadata.trackDuration,
              color: track.accentColor,
              fontSize: 18.0,
            ),
            SizedBox(height: 16.0),
            TrackInfo(
              title: track.name,
              artistName: track.metadata.albumArtistName,
              textColor: track.accentColor,
            ),
            SizedBox(height: 16.0),
            PlayerButtons(
              primaryColor: track.accentColor,
              secondaryColor: track.secondaryColor,
            ),
            PlaylistManager(
              primaryColor: track.accentColor,
              secondaryColor: track.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
