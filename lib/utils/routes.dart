import 'package:flutter/material.dart';
import 'package:local_music_player/views/player.dart';
import 'package:local_music_player/views/splash.dart';
import 'package:local_music_player/views/test.dart';


String splashRoute = "/";

Map<String, WidgetBuilder> routes = {
  splashRoute: (context) => TestWidget(),
};