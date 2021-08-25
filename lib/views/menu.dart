import 'package:flutter/material.dart';
import 'package:local_music_player/presenter/home-presenter.dart';
import 'package:local_music_player/views/albums.dart';
import 'package:local_music_player/views/artists.dart';
import 'package:local_music_player/views/home.dart';
import 'package:local_music_player/views/mini-audio-player.dart';
import 'package:local_music_player/views/playlists.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePresenter.getInstance().init(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Music"),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Theme.of(context).textTheme.headline4.color,
            unselectedLabelColor: Theme.of(context).textTheme.headline4.color.withOpacity(0.7),
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                text: "Home",
                // icon: Icon(FontAwesome.home),
              ),
              Tab(
                text: "Albums",
                // icon: Icon(FontAwesome.home),
              ),
              Tab(
                text: "Artists",
                // icon: Icon(FontAwesome.home),
              ),
              Tab(
                text: "Playlist",
                // icon: Icon(FontAwesome.home),
              ),
            ],
          ),
        ),
        drawer: Drawer(),
        body: ControllerPage(
          body: TabBarView(
            children: [
              HomePage(),
              AlbumsPage(),
              ArtistsPage(),
              PlaylistsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
