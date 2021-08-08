import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/viewModel/album-view-model.dart';
import 'package:local_music_player/views/widgets/tracks-list.dart';
import 'package:provider/provider.dart';
import 'package:stretchy_header/stretchy_header.dart';

class AlbumPage extends StatelessWidget {
  final Album album;

  const AlbumPage({Key key, this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(album.dominateColor.toString());
    return ChangeNotifierProvider(
      create: (context) => AlbumViewModel(),
      builder: (context, child) => child,
      child: Scaffold(
        backgroundColor: album.dominateColor,
        body: StretchyHeader.singleChild(
          headerData: HeaderData(
            header: Hero(
              tag: album.albumName,
              child: Image.file(
                album.albumArt,
                width: double.infinity,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.overlay,
                color: Colors.black38,
              ),
            ),
            headerHeight: MediaQuery.of(context).size.height * 2 / 5,
            highlightHeader: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.black54,
                      Colors.black26,
                      Colors.black12,
                      Colors.black12,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      album.albumName,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(
                      album.albumArtistName,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: TracksListWidget(
            tracks: album.tracks,
            textColor: album.accentColor,
          ),
        ),
      ),
    );
  }
}
