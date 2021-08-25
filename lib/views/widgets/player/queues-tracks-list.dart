import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:provider/provider.dart';

class QueuesTracksList extends StatelessWidget {
  const QueuesTracksList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerViewModel, List<Track>>(
      selector: (_, provider) => provider.playlist,
      builder: (context, tracks, child) => ImplicitlyAnimatedReorderableList<Track>(
        padding: EdgeInsets.only(top: 16.0, bottom: 64.0),items: tracks,
        areItemsTheSame: (oldItem, newItem) => oldItem.filePath == newItem.filePath,
        itemBuilder: (context, animation, item, i) => Reorderable(
          key: ValueKey(item.filePath),
          builder: (context, animation, inDrag) => SizeFadeTransition(
            animation: animation,
            curve: Curves.easeIn,
            sizeFraction: 0.7,
            child: ListTile(
              leading: CardContainer(
                borderRadius: BorderRadius.circular(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(item.albumArt),
                ),
              ),
              title: Text(item.trackName, style: TextStyle(color: Colors.red),),
              subtitle: Text(item.albumName),
              trailing: Handle(
                delay: Duration(milliseconds: 100),
                child: Icon(Icons.menu),
                vibrate: true,
              ),
            ),
          ),
          child: SizeFadeTransition(
            animation: animation,
            curve: Curves.easeIn,
            sizeFraction: 0.7,
            child: ListTile(
              leading: CardContainer(
                borderRadius: BorderRadius.circular(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(item.albumArt),
                ),
              ),
              title: Text(item.trackName, style: TextStyle(color: Theme.of(context).textTheme.headline4.color),),
              subtitle: Text(item.albumName,style: TextStyle(color: Theme.of(context).textTheme.headline4.color.withOpacity(0.7)),),
              trailing: Handle(
                delay: Duration(milliseconds: 100),
                child: Icon(Icons.menu),
                vibrate: true,
              ),
            ),
          ),
        ),
        onReorderFinished: (item, from, to, newItems) => PlayerPresenter.getInstance(context).reorderPlaylist(newItems),
      ),
    );
  }
}
