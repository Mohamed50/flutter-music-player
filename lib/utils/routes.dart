import 'package:flutter/material.dart';
import 'package:local_music_player/views/home.dart';
import 'package:local_music_player/views/player.dart';
import 'package:local_music_player/views/splash.dart';
import 'package:local_music_player/views/test.dart';


String splashRoute = "/";
String homeRoute = "/home";

Map<String, WidgetBuilder> routes = {
  splashRoute: (context) => SplashPage(),
  homeRoute: (context) => HomePage(),
};