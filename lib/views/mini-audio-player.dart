import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:local_music_player/views/player.dart';
import 'package:local_music_player/views/widgets/player/player-buttons.dart';
import 'package:provider/provider.dart';

class MiniAudioPlayer extends StatelessWidget {
  const MiniAudioPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      closedElevation: 0.0,
      transitionDuration: Duration(milliseconds: 500),
      closedBuilder: (context, action) => AspectRatio(
        aspectRatio: 5 / 1,
        child: Selector<PlayerViewModel, Track>(
          selector: (_, provider) => provider.track,
          builder: (context, track, child) => track != null
              ? CardContainer(
                  color: track?.dominateColor,
                  borderRadius: BorderRadius.circular(64.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    children: [
                      ClipOval(child: Image.file(track.albumArt)),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.trackName,
                              style: TextStyle(color: track.accentColor),
                            ),
                            Text(
                              track.albumArtistName,
                              style: TextStyle(
                                  color: track.accentColor.withOpacity(0.7),
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      PlayerButtons(
                        isMini: true,
                        primaryColor: track.accentColor,
                        secondaryColor: track.secondaryColor,
                      ),
                    ],
                  ),
                )
              : Container(color: Colors.transparent,),
        ),
      ),
      openBuilder: (context, action) => PlayerPage(),
    );
  }
}

class ControllerPage extends StatelessWidget {
  final Widget body;

  const ControllerPage({
    Key key,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            body,
            AspectRatio(
              aspectRatio: 6 / 1,
              child: Container(
                color: Colors.transparent,
              ),
            )
          ],
        ),
        MiniAudioPlayer(),
      ],
    );
  }
}
