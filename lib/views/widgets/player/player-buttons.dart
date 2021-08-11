import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';

import 'play-button.dart';

class PlayerButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: ValueKey("prev button"),
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Entypo.controller_fast_backward),
              iconSize: 32.0,
              color: Theme.of(context).textTheme.headline4.color,
              onPressed: PlayerPresenter.getInstance(context).prev,
            ),
          ),
        ),
        SizedBox(width: 24.0),
        Hero(
          tag: ValueKey("play button"),
          child: Material(
            color: Colors.transparent,
            child: PlayButton(),
          ),
        ),
        SizedBox(width: 24.0),
        Hero(
          tag: ValueKey("next button"),
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Entypo.controller_fast_forward),
              iconSize: 32.0,
              color: Theme.of(context).textTheme.headline4.color,
              onPressed: PlayerPresenter.getInstance(context).next,
            ),
          ),
        ),
      ],
    );
  }
}

class MiniPlayerButtons extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: ValueKey("play button"),
          child: Material(
            color: Colors.transparent,
            child: PlayButton(
              isMini: true,
            ),
          ),
        ),
        Hero(
          tag: ValueKey("next button"),
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Entypo.controller_fast_forward),
              iconSize: 16.0,
              color: Theme.of(context).textTheme.headline4.color,
              onPressed: PlayerPresenter.getInstance(context).next,
            ),
          ),
        ),
      ],
    );
  }
}
