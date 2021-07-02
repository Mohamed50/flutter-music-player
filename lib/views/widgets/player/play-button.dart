import 'package:flutter/material.dart';
import 'package:local_music_player/presenter/player-presenter.dart';

class PlayButton extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const PlayButton({Key key, this.primaryColor, this.secondaryColor})
      : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.play_pause, progress: Tween(begin: 0.0, end: 1.0).animate(animationController),
      ),
      iconSize: 70.0,
      color: widget.primaryColor,
      onPressed: () {
        PlayerPresenter.getInstance(context).handlePLayButton();
        if(animationController.status == AnimationStatus.forward || animationController.status == AnimationStatus.completed)
          animationController.reverse();
        else
          animationController.forward();
      },
    );
  }
}
