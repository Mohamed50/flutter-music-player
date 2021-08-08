import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const PlayButton({Key key, this.primaryColor, this.secondaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerViewModel,bool>(
      selector: (_, provider) => provider.state == PlayerState.PLAYING,
      builder: (context, value, child) => IconToggle(
        value: value,
        selectedIconData: FontAwesome.pause,
        unselectedIconData: FontAwesome.play,
        activeColor: primaryColor,
        inactiveColor: primaryColor,
        onChanged: (value) {
          PlayerPresenter.getInstance(context).handlePLayButton();
        },
      ),
    );
  }
}
