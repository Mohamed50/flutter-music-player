import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/customs/app-bar.dart';
import 'package:local_music_player/views/widgets/player/art-cover.dart';
import 'package:local_music_player/views/widgets/player/circular-slider.dart';
import 'package:local_music_player/views/widgets/player/duration-text.dart';
import 'package:local_music_player/views/widgets/player/player-buttons.dart';
import 'package:local_music_player/views/widgets/player/playlist-manger.dart';
import 'package:local_music_player/views/widgets/player/track-info.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerViewModel,Track>(
      selector: (_, provider) => provider.track,
      builder: (context, track, child) => Scaffold(
        backgroundColor: track.dominateColor,
        appBar: CustomAppbar(
          title: track.trackName,
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
                  coverArt: track.albumArt,
                  backgroundColor: track.dominateColor,
                  heroTag: track.filePath,
                ),
              ),
              Selector<PlayerViewModel, Duration>(
                selector: (_, provider) => Duration(seconds: provider.duration.inSeconds - provider.position.inSeconds),
                builder: (context, duration, child) => DurationText(
                  duration: duration,
                  color: track.accentColor,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              TrackInfo(
                title: track.trackName,
                artistName: track.albumArtistName,
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
      ),
    );
  }
}
