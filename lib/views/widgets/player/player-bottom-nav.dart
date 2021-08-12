import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:provider/provider.dart';

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
      bottomAppBarBody: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Selector<PlayerViewModel, bool>(
            selector: (_, provider) => provider.repeatMode == RepeatMode.Repeat,
            builder: (context, value, child) => IconToggle(
              value: value,
              selectedIconData: Icons.repeat_rounded,
              unselectedIconData: Icons.repeat_one_rounded,
              activeColor: Theme.of(context).backgroundColor,
              inactiveColor: Theme.of(context).backgroundColor,
              onChanged: (value) => PlayerPresenter.getInstance(context).handleRepeatMode(),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          IconToggle(
            value: true,
            selectedIconData: Icons.favorite_rounded,
            unselectedIconData: Icons.favorite_border_rounded,
            activeColor: Theme.of(context).backgroundColor,
            inactiveColor: Theme.of(context).backgroundColor,
            onChanged: (value) {},
          ),
        ],
      ),
      expandedBody: QueuesTracksList(),
    );
  }
}
