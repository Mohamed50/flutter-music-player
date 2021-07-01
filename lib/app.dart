import 'package:flutter/material.dart';
import 'package:local_music_player/utils/routes.dart';
import 'package:local_music_player/viewModel/files-view-model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilesViewModel(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        color: Colors.orangeAccent,
        title: "Fifty Music Player",
        routes: routes,
      ),
    );
  }
}
