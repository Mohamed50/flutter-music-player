import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/views/customs/customs-container.dart';

class TrackOptionBottomSheet extends StatelessWidget {
  final Track track;

  const TrackOptionBottomSheet({Key key, @required this.track})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 3 / 1,
                child: Row(
                  children: [
                    CardContainer(
                      borderRadius: BorderRadius.circular(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.file(
                          track.albumArt,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.overlay,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.trackName,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline4.color,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            track.albumName,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline4.color,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            track.albumArtistName,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .color
                                  .withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Theme.of(context).textTheme.headline4.color),
            CustomButton(
              label: "Add to queue",
              iconData: Icons.playlist_play_rounded,
              onPressed: () => PlayerPresenter.getInstance(context).addToQueue(track),
            ),
            CustomButton(
              label: "Play next",
              iconData: Icons.skip_next_rounded,
              onPressed: () => PlayerPresenter.getInstance(context).playNext(track),
            ),
            CustomButton(
              label: "Add to playlist",
              iconData: Icons.playlist_add,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function onPressed;

  const CustomButton({Key key, this.label, this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          SizedBox(width: 8.0),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
