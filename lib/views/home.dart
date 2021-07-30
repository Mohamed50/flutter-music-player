import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/media-type.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/customs/app-bar.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:provider/provider.dart';
import 'player.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Music"),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.shuffle_rounded),
      ),
      body: ListView(
        shrinkWrap: true,
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
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: CardContainer(
                            shape: BoxShape.circle,
                            child: ClipOval(
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
          // Selector<TrackViewModel, List<Track>>(
          //   selector: (_, provider) => provider.tracks,
          //   shouldRebuild: (previous, next) => true,
          //   builder: (context, tracks, child) {
          //     return GridView.builder(
          //       itemCount: tracks.length,
          //       shrinkWrap: true,
          //       padding: EdgeInsets.all(8.0),
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         crossAxisSpacing: 8.0,
          //         mainAxisSpacing: 8.0,
          //       ),
          //       itemBuilder: (context, index) => tracks[index].trackName != null
          //           ? InkWell(
          //               onTap: () {
          //                 PlayerPresenter.getInstance(context)
          //                     .setTrack(tracks[index]);
          //                 Navigator.of(context).push(
          //                   MaterialPageRoute(
          //                     builder: (context) =>
          //                         PlayerPage(track: tracks[index]),
          //                   ),
          //                 );
          //               },
          //               child: CardContainer(
          //                 borderRadius: BorderRadius.circular(8.0),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(8.0),
          //                   child: Stack(
          //                     alignment: Alignment.bottomCenter,
          //                     children: [
          //                       Image.file(
          //                         tracks[index].albumArt,
          //                         key: ValueKey(index),
          //                         fit: BoxFit.cover,
          //                         colorBlendMode: BlendMode.overlay,
          //                         color: Colors.black12,
          //                       ),
          //                       Text(
          //                         tracks[index].trackName,
          //                         style: TextStyle(color: Colors.white),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             )
          //           : Container(),
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tracks",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Selector<TrackViewModel, List<Track>>(
            selector: (_, provider) => provider.tracks,
            shouldRebuild: (previous, next) => true,
            builder: (context, tracks, child) {
              return ListView.builder(
                itemCount: tracks.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    PlayerPresenter.getInstance(context)
                        .setTrack(tracks[index]);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlayerPage(track: tracks[index]),
                      ),
                    );
                  },
                  title: Text(
                    tracks[index].trackName,
                  ),
                  subtitle:  Text(
                    tracks[index].albumArtistName,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
