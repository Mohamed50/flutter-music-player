import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/home-presenter.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:provider/provider.dart';

import 'playlist-cover.dart';

class AddToPlaylistBottomSheet extends StatelessWidget {
  final Track track;

  const AddToPlaylistBottomSheet({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add to playlist",
              style: Theme.of(context).textTheme.headline5,
            ),
            Divider(
              color: Theme.of(context).textTheme.headline4.color,
              height: 64.0,
            ),
            ListTile(
              onTap: (){
                PlayerPresenter.getInstance(context).showNewPlaylistBottomSheet(track);
              },
              leading: CardContainer(
                width: 56.0,
                height: 56.0,
                color: Theme.of(context)
                    .textTheme
                    .headline4
                    .color
                    .withOpacity(0.5),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).textTheme.headline4.color,
                ),
              ),
              title: Text(
                "New playlist",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 16.0),
            Selector<TrackViewModel, List<Playlist>>(
              selector: (_, provider) => provider.playlists,
              builder: (context, playlists, child) => ListView.separated(
                shrinkWrap: true,
                itemCount: playlists.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    PlayerPresenter.getInstance(context).addToPlaylist(track, playlists[index]);
                  },
                  child: ListTile(
                    leading: PlaylistCover(playlist: playlists[index]),
                    title: Text(
                      playlists[index].playlistName,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
