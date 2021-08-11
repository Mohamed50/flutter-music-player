import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/presenter/home-presenter.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/customs/customs-container.dart';
import 'package:provider/provider.dart';

class AlbumsList extends StatelessWidget {
  const AlbumsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest albums",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
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
      ],
    );
  }
}
