import 'package:flutter/material.dart';
import 'package:local_music_player/views/album.dart';
import 'package:local_music_player/views/home.dart';
import 'package:local_music_player/views/menu.dart';
import 'package:local_music_player/views/splash.dart';


String splashRoute = "/";
String menuRoute = "/menu";
String homeRoute = "/home";
String albumRoute = "/album";


Map<String, WidgetBuilder> routes = {
  splashRoute: (context) => SplashPage(),
  menuRoute: (context) => MenuPage(),
  homeRoute: (context) => HomePage(),
  albumRoute: (context) => AlbumPage(),
};