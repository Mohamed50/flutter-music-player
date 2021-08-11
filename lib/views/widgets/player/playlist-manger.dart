import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';

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
          IconToggle(
            value: false,
            selectedIconData: Icons.shuffle_rounded,
            unselectedIconData: Icons.repeat_rounded,
            activeColor: Theme.of(context).textTheme.headline4.color,
            inactiveColor: Theme.of(context).textTheme.headline4.color,
            onChanged: (value) {
            },
          ),
          IconButton(
            icon: Icon(Icons.playlist_play_rounded),
            iconSize: 32.0,
            color: Theme.of(context).textTheme.headline4.color,
            onPressed: () => PlayerPresenter.getInstance(context).showPlaylist(),
          ),
          IconToggle(
            value: true,
            selectedIconData: Icons.favorite_rounded,
            unselectedIconData: Icons.favorite_border_rounded,
            activeColor: Theme.of(context).textTheme.headline4.color,
            inactiveColor: Theme.of(context).textTheme.headline4.color,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
