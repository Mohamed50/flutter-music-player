import 'package:flutter/material.dart';
import 'package:flutter_visualizers/Visualizers/LineVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:local_music_player/model/schema/media-type.dart';
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
  final Track track;

  const PlayerPage({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Visualizer(
              builder: (BuildContext context, List<int> wave) {
                return new CustomPaint(
                  painter: LineVisualizer(
                    waveData: wave,
                    height: MediaQuery.of(context).size.height,
                    width : MediaQuery.of(context).size.width,
                    color: Colors.blueAccent,
                  ),
                  child: new Container(),
                );
              },
              id: PlayerViewModel.playerId,
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
    );
  }
}
