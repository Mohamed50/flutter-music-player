import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import '../player.dart';

class TracksListWidget extends StatelessWidget {
  final List<Track> tracks;
  final Color textColor;

  const TracksListWidget({Key key, this.tracks, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tracks",
                style: TextStyle(
                  color: textColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              IconButton(
                icon: Icon(Entypo.shuffle),
                iconSize: 20.0,
                onPressed: (){
                  List<Track> newPlaylist  = [];
                  newPlaylist.add(tracks.first);
                  newPlaylist.add(tracks[tracks.length ~/ 2]);
                  newPlaylist.add(tracks.last);
                  PlayerPresenter.getInstance(context).playPlaylist(newPlaylist);
                },
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: tracks.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              PlayerPresenter.getInstance(context).setTrack(tracks[index]);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerPage(),
                ),
              );
            },
            title: Text(
              tracks[index].trackName,
              style: TextStyle(color: textColor),
            ),
            subtitle:  Text(
              tracks[index].albumArtistName,
              style: TextStyle(color: textColor?.withOpacity(0.7)),
            ),
            leading: CardContainer(
              borderRadius: BorderRadius.circular(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Hero(
                  tag: tracks[index].filePath,
                  child: Image.file(
                    tracks[index].albumArt,
                    key: ValueKey(index),
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.overlay,
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
