import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/widgets/albums-list.dart';
import 'package:provider/provider.dart';
import 'widgets/tracks-list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        color: Theme.of(context).backgroundColor,
        duration: Duration(milliseconds: 0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 24.0, bottom: 64.0),
          children: [
            AlbumsList(),
            Selector<TrackViewModel, List<Track>>(
              selector: (_, provider) => provider.tracks,
              shouldRebuild: (previous, next) => true,
              builder: (context, tracks, child) {
                return TracksListWidget(tracks: tracks);
              },
            ),
          ],
        ),
      ),
    );
  }
}
