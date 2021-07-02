import 'package:flutter/material.dart';

import 'play-button.dart';

class PlayerButtons extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const PlayerButtons({Key key, this.primaryColor, this.secondaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.fast_rewind_rounded),
          iconSize: 56.0,
          color: secondaryColor,
          onPressed: () {},
        ),
        PlayButton(
          primaryColor: primaryColor,
        ),
        IconButton(
          icon: Icon(Icons.fast_forward_rounded),
          iconSize: 56.0,
          color: secondaryColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
