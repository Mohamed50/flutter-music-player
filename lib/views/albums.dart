import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/presenter/home-presenter.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:provider/provider.dart';

import 'customs/customs-container.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TrackViewModel, List<Album>>(
      selector: (_, provider) => provider.albums,
      builder: (context, albums, child) => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 24.0, bottom: 64.0),
        itemCount: albums.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            HomePresenter.getInstance().albumClickHandler(albums[index]);
          },
          child: Column(
            children: [
              Expanded(
                child: CardContainer(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
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
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
