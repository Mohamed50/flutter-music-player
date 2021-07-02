import 'package:flutter/material.dart';
import 'package:local_music_player/utils/routes.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/viewModel/files-view-model.dart';
import 'package:local_music_player/views/setting-handler.dart';
import 'package:provider/provider.dart';
import 'config/Theme.dart';
import 'viewModel/setting-view-model.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => FilesViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerViewModel(),
          lazy: false,
        ),
      ],
      child: SettingHandler(
        builder: (context, setting) => MaterialApp(
          color: Colors.orangeAccent,
          title: "Fifty Music Player",
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: setting.themeMode,
          routes: routes,
        ),
      ),
    );
  }
}
