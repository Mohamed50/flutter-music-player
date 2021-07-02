import 'package:flutter/material.dart';

class PlaylistManager extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  const PlaylistManager({Key key, this.primaryColor, this.secondaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.shuffle_rounded),
          iconSize: 32.0,
          color: secondaryColor,
          onPressed: () {},
        ),
        Row(
          children: [
            Icon(
              Icons.playlist_play_rounded,
              color: primaryColor,
              size: 28.0,
            ),
            Text(
              "Playlist",
              style: TextStyle(
                color: primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.repeat_rounded),
          iconSize: 32.0,
          color: secondaryColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
