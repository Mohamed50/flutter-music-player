import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:local_music_player/views/widgets/player/playlist-manger.dart';

import 'queues-tracks-list.dart';

class PlayerBottomNav extends StatelessWidget {
  const PlayerBottomNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomExpandableAppBar(
      controller: DefaultBottomBarController.of(context),
      bottomAppBarColor: Theme.of(context).textTheme.headline4.color,
      expandedHeight: MediaQuery.of(context).size.height - 160.0,
      horizontalMargin: 16.0,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(),
        StadiumBorder(
          side: BorderSide(),
        ),
      ),
      expandedBackColor: Theme.of(context).primaryColor,
      bottomAppBarBody: PlaylistManager(),
      expandedBody: QueuesTracksList(),
    );
  }
}
