import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import '../player.dart';

class TracksListWidget extends StatelessWidget {
  final List<Track> tracks;
  final Color textColor;

  const TracksListWidget({Key key, this.tracks, this.textColor})
      : super(key: key);

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
                color: textColor ?? Theme.of(context).textTheme.headline4.color,
                onPressed: () =>
                    PlayerPresenter.getInstance(context).playPlaylist(tracks),
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
              PlayerPresenter.getInstance(context).playPlaylist(tracks, index);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerPage(),
                ),
              );
            },
            leading: CardContainer(
              borderRadius: BorderRadius.circular(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Hero(
                  tag: tracks[index].filePath,
                  child: tracks[index].albumArt != null
                      ? Image.file(
                          tracks[index].albumArt ?? tracks[index].filePath.split("/").removeLast() + "Cover.jpg" ,
                          key: ValueKey(index),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.overlay,
                          color: Colors.black12,
                        )
                      : Image.asset("assets/images/collection-album.jpg"),
                ),
              ),
            ),
            title: Text(
              tracks[index].trackName,
              style: TextStyle(
                  color:
                      textColor ?? Theme.of(context).textTheme.headline4.color),
            ),
            subtitle: Text(
              tracks[index].albumArtistName,
              style: TextStyle(
                  color: textColor != null
                      ? textColor.withOpacity(0.7)
                      : Theme.of(context)
                          .textTheme
                          .headline4
                          .color
                          .withOpacity(0.7)),
            ),
            trailing: IconButton(
              color: Theme.of(context).textTheme.headline4.color,
              onPressed: () => PlayerPresenter.getInstance(context)
                  .showTrackOptionBottomSheet(tracks[index]),
              icon: Icon(Icons.more_vert),
            ),
          ),
        )
      ],
    );
  }
}
