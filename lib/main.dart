import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'config/configuration.dart';
import 'viewModel/collection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Configuration.init();
  // await Collection.init(
  //   collectionDirectory: configuration.collectionDirectory,
  //   cacheDirectory: configuration.cacheDirectory,
  //   collectionSortType: configuration.collectionSortType,
  // );
  runApp(App());
}