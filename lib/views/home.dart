import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/media-type.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/collection.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/customs/app-bar.dart';
import 'package:provider/provider.dart';
import 'player.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Music"),
      body: Selector<TrackViewModel, List<Track>>(
        selector: (_, provider) => provider.tracks,
        shouldRebuild: (previous, next) => true,
        builder: (context, tracks, child) {
          print("--------------------- ${tracks.length}");
          return GridView.builder(
            itemCount: tracks.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => tracks[index].trackName != null
                ? InkWell(
                    onTap: () {
                      PlayerPresenter.getInstance(context).setTrack(tracks[index]);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayerPage(track: tracks[index]),
                      ));
                    },
                    child: Card(
                        child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.file(
                          tracks[index].albumArt,
                          key: ValueKey(index),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.overlay,
                          color: Colors.black12,
                        ),
                        Text(
                          tracks[index].trackName,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
