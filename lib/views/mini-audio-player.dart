import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:local_music_player/views/player.dart';
import 'package:local_music_player/views/widgets/player/play-button.dart';
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
      closedBuilder: (context, action) => Container(
        margin:
            EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0, top: 8.0),
        child: AspectRatio(
          aspectRatio: 6 / 1,
          child: Selector<PlayerViewModel, Track>(
            selector: (_, provider) => provider.track,
            builder: (context, track, child) => track != null
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CardContainer(
                        borderRadius: BorderRadius.circular(64.0),
                        padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: SizedBox(),
                            ),
                            SizedBox(width: 16.0),
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
                                        color:
                                            track.accentColor.withOpacity(0.7),
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            MiniPlayerButtons()
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: ClipOval(
                          child: Image.file(track.albumArt),
                        ),
                      ),
                    ],
                  )
                : Container(
                    color: Colors.transparent,
                  ),
          ),
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
        body,
        MiniAudioPlayer(),
      ],
    );
  }
}
