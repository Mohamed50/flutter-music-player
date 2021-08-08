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
}

const Map<String, dynamic> DEFAULT_CONFIGURATION = {
  'collectionDirectory': '/storage/emulated/0/Music',
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
      await configuration.configurationFile
          .writeAsString(convert.jsonEncode(DEFAULT_CONFIGURATION));
    }
    await configuration.read();
    configuration.cacheDirectory = new Directory('/storage/emulated/0/Android/data/com.fifty.local_music_player/files');
    Directory albumArtsDirectory = new Directory('/storage/emulated/0/Android/data/com.fifty.local_music_player/files/albumArts');
    if (!await albumArtsDirectory.exists())
      albumArtsDirectory.create();
  }

  Future<void> save({Directory collectionDirectory}) async {
    if (collectionDirectory != null) {
      this.collectionDirectory = collectionDirectory;
    }
    await configuration.configurationFile.writeAsString(convert.jsonEncode({
      'collectionDirectory': this.collectionDirectory.path,
    }));
  }

  Future<dynamic> read() async {
    Map<String, dynamic> currentConfiguration =
        convert.jsonDecode(await this.configurationFile.readAsString());
    DEFAULT_CONFIGURATION.keys.forEach((String key) {
      if (!currentConfiguration.containsKey(key)) {
        currentConfiguration[key] = DEFAULT_CONFIGURATION[key];
      }
    });
    this.collectionDirectory = Directory(currentConfiguration['collectionDirectory']);
  }
}
