import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  final bool isMini;

  const PlayButton({Key key, this.isMini : false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerViewModel,bool>(
      selector: (_, provider) => provider.state == PlayerState.PLAYING,
      builder: (context, value, child) => CardContainer(
        shape: BoxShape.circle,
        color: Theme.of(context).textTheme.headline4.color,
        alignment: Alignment.center,
        padding: EdgeInsets.all(isMini ? 0.0 : 8.0),
        child: IconToggle(
          value: value,
          selectedIconData: Icons.pause_rounded,
          unselectedIconData: Icons.play_arrow_rounded,
          activeColor: Theme.of(context).backgroundColor,
          inactiveColor: Theme.of(context).backgroundColor,
          onChanged: (value) {
            PlayerPresenter.getInstance(context).handlePLayButton();
          },
        ),
      ),
    );
  }
}
