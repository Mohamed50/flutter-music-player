import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/widgets/playlist-cover.dart';
import 'package:provider/provider.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TrackViewModel, List<Playlist>>(
      selector: (_, provider) => provider.playlists,
      builder: (context, playlists, child) => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 24.0, bottom: 64.0),
        itemCount: playlists.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            // HomePresenter.getInstance().albumClickHandler(albums[index]);
          },
          child: Column(
            children: [
              Expanded(
                child: playlists[index].tracks.isNotEmpty
                    ? PlaylistCover(playlist: playlists[index])
                    : Container(
                  width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Theme.of(context)
                                .textTheme
                                .headline4
                                .color
                                .withOpacity(0.2),
                        ),
                  child: Icon(Icons.library_add, size: 48.0,),
                      ),
              ),
              SizedBox(height: 8.0),
              Text(
                playlists[index].playlistName,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
