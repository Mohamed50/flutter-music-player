import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/widgets/tracks-list.dart';
import 'package:provider/provider.dart';

class QueueBottomSheet extends StatelessWidget {
  const QueueBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      onClosing: () {},
      builder: (context) => Selector<PlayerViewModel, List<Track>>(
        selector: (_, provider) => provider.playlist,
        builder: (context, tracks, child) => TracksListWidget(tracks: tracks),
      ),
    );
  }
}
