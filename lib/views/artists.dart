import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/artist.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:provider/provider.dart';
import 'customs/customs-container.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Selector<TrackViewModel, List<Artist>>(
      selector: (_, provider) => provider.artists,
      shouldRebuild: (previous, next) => true,
      builder: (context, artists, child) => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 24.0, bottom: 64.0),
        itemCount: artists.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => InkWell(
        onTap: () {
          // HomePresenter.getInstance().albumClickHandler(albums[index]);
        },
        child: Column(
          children: [
            Expanded(
              child: CardContainer(
                shape: BoxShape.circle,
                child: ClipOval(
                  child: Hero(
                    tag: artists[index].artistName ?? artists[index].toString(),
                    child: Image.file(
                      artists[index].tracks.first.albumArt,
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
              artists[index].artistName ?? "",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),),
    );
  }
}
