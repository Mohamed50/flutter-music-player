import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:local_music_player/viewModel/collection.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path;

 Configuration configuration;


abstract class ConfigurationKeys {
  Directory collectionDirectory;
  Directory cacheDirectory;
  String homeAddress;
  ThemeMode themeMode;
  CollectionSort collectionSortType;
  bool automaticAccent;
  bool notificationLyrics;
  TargetPlatform platform;
  List<dynamic> collectionSearchRecent;
  List<dynamic> discoverSearchRecent;
  List<dynamic> discoverRecent;
}


const Map<String, dynamic> DEFAULT_CONFIGURATION = {
  'collectionDirectory': '/storage/emulated/0/Music',
  'homeAddress': '',
  'languageRegion': 0,
  'accent': 0,
  'themeMode': 0,
  'collectionSortType': 0,
  'automaticAccent': false,
  'notificationLyrics': true,
  'platform': 2,
  'collectionSearchRecent': [],
  'discoverSearchRecent': [],
  'discoverRecent': [],
};


class Configuration extends ConfigurationKeys {
  
  File configurationFile;

  static Future<void> init() async {
    configuration = new Configuration();
    configuration.configurationFile = File(
      path.join(
        (await path.getExternalStorageDirectory()).path,
        'configuration.JSON',
      ),
    );
    if (!await configuration.configurationFile.exists()) {
      await configuration.configurationFile.create(recursive: true);
      await configuration.configurationFile.writeAsString(convert.jsonEncode(DEFAULT_CONFIGURATION));
    }
    await configuration.read();
    configuration.cacheDirectory = new Directory('/storage/emulated/0/Android/data/com.fifty.local_music_player/files');
  }

  Future<void> save({
    Directory collectionDirectory,
    String homeAddress,
    ThemeMode themeMode,
    bool showOutOfBoxExperience,
    CollectionSort collectionSortType,
    bool automaticAccent,
    bool notificationLyrics,
    TargetPlatform platform,
    List<dynamic> collectionSearchRecent,
    List<dynamic> discoverSearchRecent,
    List<dynamic> discoverRecent,
    }) async {
    if (collectionDirectory != null) {
      this.collectionDirectory = collectionDirectory;
    }
    if (homeAddress != null) {
      this.homeAddress = homeAddress;
    }
    if (themeMode != null) {
      this.themeMode = themeMode;
    }
    if (collectionSortType != null) {
      this.collectionSortType = collectionSortType;
    }
    if (collectionSearchRecent != null) {
      this.collectionSearchRecent = collectionSearchRecent;
    }
    if (discoverSearchRecent != null) {
      this.discoverSearchRecent = discoverSearchRecent;
    }
    if (collectionSearchRecent != null) {
      this.discoverRecent = discoverRecent;
    }
    if (automaticAccent != null) {
      this.automaticAccent = automaticAccent;
    }
    if (notificationLyrics != null) {
      this.notificationLyrics = notificationLyrics;
    }
    if (platform != null) {
      this.platform = platform;
    }
    await configuration.configurationFile.writeAsString(convert.jsonEncode({
      'collectionDirectory': this.collectionDirectory.path,
      'homeAddress': this.homeAddress,
      'themeMode': this.themeMode.index,
      'collectionSortType': this.collectionSortType.index,
      'automaticAccent': this.automaticAccent,
      'notificationLyrics': this.notificationLyrics,
      'platform': this.platform.index,
      'collectionSearchRecent': this.collectionSearchRecent,
      'discoverSearchRecent': this.discoverSearchRecent,
      'discoverRecent': this.discoverRecent,
    }));
  }

  Future<dynamic> read() async {
    Map<String, dynamic> currentConfiguration = convert.jsonDecode(await this.configurationFile.readAsString());
    DEFAULT_CONFIGURATION.keys.forEach((String key) {
      if (!currentConfiguration.containsKey(key)) {
        currentConfiguration[key] = DEFAULT_CONFIGURATION[key];
      }
    });
    this.collectionDirectory = Directory(currentConfiguration['collectionDirectory']);
    this.homeAddress = currentConfiguration['homeAddress'];
    this.themeMode = ThemeMode.values[currentConfiguration['themeMode']];
    this.collectionSortType = CollectionSort.values[currentConfiguration['collectionSortType']];
    this.automaticAccent = currentConfiguration['automaticAccent'];
    this.notificationLyrics = currentConfiguration['notificationLyrics'];
    this.platform = TargetPlatform.values[currentConfiguration['platform']];
    this.collectionSearchRecent = currentConfiguration['collectionSearchRecent'];
    this.discoverSearchRecent = currentConfiguration['discoverSearchRecent'];
    this.discoverRecent = currentConfiguration['discoverRecent'];
  }
}
