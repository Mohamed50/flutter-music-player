import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/home-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/customs/app-bar.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:local_music_player/views/mini-audio-player.dart';
import 'package:local_music_player/views/widgets/tracks-list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePresenter.getInstance().init(context);
    return Selector<PlayerViewModel, Track>(
      selector: (_, provider) => provider.track,
      builder: (context, track, child) => Scaffold(
        appBar: CustomAppbar(title: "Music", backgroundColor: track?.dominateColor,),
        body: AnimatedContainer(
          color: track?.dominateColor,
          duration: Duration(milliseconds: 700),
          child: ControllerPage(
            body: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 24.0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last albums",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Selector<TrackViewModel, List<Album>>(
                  selector: (_, provider) => provider.albums,
                  shouldRebuild: (previous, next) => true,
                  builder: (context, albums, child) {
                    return AspectRatio(
                      aspectRatio: 2 / 1,
                      child: ListView.separated(
                        itemCount: albums.length,
                        padding: EdgeInsets.all(16.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            HomePresenter.getInstance().albumClickHandler(albums[index]);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: CardContainer(
                                  shape: BoxShape.circle,
                                  child: ClipOval(
                                    child: Hero(
                                      tag: albums[index].albumName,
                                      child: Image.file(
                                        albums[index].albumArt,
                                        key: ValueKey(index),
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.overlay,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                albums[index].albumName,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(width: 8.0),
                      ),
                    );
                  },
                ),
                Selector<TrackViewModel, List<Track>>(
                  selector: (_, provider) => provider.tracks,
                  shouldRebuild: (previous, next) => true,
                  builder: (context, tracks, child) {
                    return TracksListWidget(tracks: tracks,);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
