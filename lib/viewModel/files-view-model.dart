import 'dart:io';
import 'package:flutter/material.dart';

List<String> supportedAudioExtensions = ["mp3", "flac"];

class FilesViewModel with ChangeNotifier {

  List<FileSystemEntity> _files = [];
  List<FileSystemEntity> get files => _files;

  FilesViewModel() {
    fetchAllAudioFilesFromInternalStorage();
  }

  fetchAllAudioFilesFromInternalStorage() async {
    Directory externalStorageDir = Directory("/storage/emulated/0/");
    List<FileSystemEntity> allFiles =
        externalStorageDir.listSync(recursive: true, followLinks: false);
    _files = allFiles
        .where((file) => supportedAudioExtensions
            .any((extension) => file.path.endsWith(extension)))
        .toList();
    print(externalStorageDir);
    notifyListeners();
  }

}
