import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:provider/provider.dart';

class PlaylistManager extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const PlaylistManager({Key key, this.primaryColor, this.secondaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
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
    );
  }
}
