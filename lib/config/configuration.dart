import 'dart:io';
import 'dart:convert' as convert;
import 'package:local_music_player/utils/utils.dart';
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
  File collectionFile;

  static Future<void> init() async {
    configuration = new Configuration();
    await initConfigurationFile();
    await initCollectionFile();
    await initCacheDirectory();
  }

  static initConfigurationFile() async {
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
  }

  static initCollectionFile() async {
    configuration.collectionFile = File(
      path.join(
        (await path.getExternalStorageDirectory()).path,
        'collection.JSON',
      ),
    );
    if (!await configuration.collectionFile.exists()) {
      await configuration.collectionFile.create(recursive: true);
      await configuration.collectionFile.writeAsString(convert.jsonEncode({}));
    }
  }

  static initCacheDirectory() async {
    configuration.cacheDirectory = new Directory('/storage/emulated/0/Android/data/com.fifty.local_music_player/files');
    Directory albumArtsDirectory = new Directory('/storage/emulated/0/Android/data/com.fifty.local_music_player/files/albumArts');
    if (!await albumArtsDirectory.exists()) albumArtsDirectory.create();
  }

  Future<void> save({Directory collectionDirectory}) async {
    if (collectionDirectory != null) {
      this.collectionDirectory = collectionDirectory;
    }
    await writeContentToFile(configuration.configurationFile, {
      'collectionDirectory': this.collectionDirectory.path,
    });
  }

  Future<dynamic> read() async {
    Map<String, dynamic> currentConfiguration =
        await readContentFromFile(this.configurationFile);
    DEFAULT_CONFIGURATION.keys.forEach((String key) {
      if (!currentConfiguration.containsKey(key)) {
        currentConfiguration[key] = DEFAULT_CONFIGURATION[key];
      }
    });
    this.collectionDirectory =
        Directory(currentConfiguration['collectionDirectory']);
  }
}
