import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';

class QueueFloatingButton extends StatelessWidget {
  const QueueFloatingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).textTheme.headline4.color,
      onPressed: () => DefaultBottomBarController.of(context).swap(),
      label: GestureDetector(
        onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
        onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
        child: AnimatedBuilder(
          animation: DefaultBottomBarController.of(context).state,
          builder: (context, child) => Icon(
            Icons.playlist_play_rounded,
            size: 32.0,
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }
}
