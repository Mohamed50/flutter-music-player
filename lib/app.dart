import 'package:flutter/material.dart';
import 'package:local_music_player/presenter/setting-presenter.dart';
import 'package:local_music_player/utils/routes.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/setting-handler.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingHandler(
      builder: (context, setting) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TrackViewModel(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (context) => PlayerViewModel(SettingPresenter.getInstance().onTrackChanged),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          color: Colors.orangeAccent,
          title: "Fifty Music Player",
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: setting.themeData,
          routes: routes,
        ),
      ),
    );
  }
}
