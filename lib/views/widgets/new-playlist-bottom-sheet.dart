import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/home-presenter.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:provider/provider.dart';

import 'playlist-cover.dart';

class NewPlaylistBottomSheet extends StatefulWidget {
  final Track track;

  NewPlaylistBottomSheet({Key key, this.track}) : super(key: key);

  @override
  _NewPlaylistBottomSheetState createState() => _NewPlaylistBottomSheetState();
}

class _NewPlaylistBottomSheetState extends State<NewPlaylistBottomSheet> {
  final TextEditingController _playlistNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: (){},
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "New playlist",
              style: Theme.of(context).textTheme.headline5,
            ),
            Divider(
              color: Theme.of(context).textTheme.headline4.color,
              height: 64.0,
            ),
            TextField(
              controller: _playlistNameController,
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline4.color),
              decoration: InputDecoration(
                hintText: "Playlist name",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).textTheme.headline4.color)),
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .headline4
                        .color
                        .withOpacity(0.5)),
                fillColor: Theme.of(context).textTheme.headline4.color,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    textStyle: TextStyle(color: Theme.of(context).backgroundColor)),
                onPressed: () {
                  Playlist newPlaylist = Playlist();
                  newPlaylist.playlistName = _playlistNameController.value.text;
                  newPlaylist.tracks = [];
                  newPlaylist.tracks.add(widget.track);
                  PlayerPresenter.getInstance(context).addNewPlaylist(newPlaylist);
                  Navigator.of(context).pop();
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
