import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';

import 'play-button.dart';

class PlayerButtons extends StatelessWidget {
  final bool isMini;
  final Color primaryColor;
  final Color secondaryColor;

  const PlayerButtons({Key key, this.primaryColor, this.secondaryColor, this.isMini : false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Entypo.controller_fast_backward),
          iconSize: isMini ? 16.0 : 56.0,
          color: secondaryColor,
          onPressed: PlayerPresenter.getInstance(context).next,
        ),
        PlayButton(
          primaryColor: primaryColor,
        ),
        IconButton(
          icon: Icon(Entypo.controller_fast_forward),
          iconSize: isMini ? 16.0 : 56.0,
          color: secondaryColor,
          onPressed: PlayerPresenter.getInstance(context).prev,
        ),
      ],
    );
  }
}
