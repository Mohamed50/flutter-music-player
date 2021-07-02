import 'package:flutter/material.dart';
import 'package:local_music_player/views/customs/app-bar.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Prise the lord",),
      body: Column(

      ),
    );
  }
}
