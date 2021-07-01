import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

List<String> supportedAudioExtensions = ["mp3", "flac"];

class FilesViewModel with ChangeNotifier{

  List<FileSystemEntity> _files = [];
  List<FileSystemEntity> get files => _files;

  FilesViewModel(){
    fetchAllAudioFilesFromInternalStorage();
  }

  fetchAllAudioFilesFromInternalStorage() async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    Directory externalStorageDir = Directory(storageInfo.first.rootDir);
    List<FileSystemEntity> allFiles = externalStorageDir.listSync(recursive: true, followLinks: false);
    _files = allFiles.where((file) => supportedAudioExtensions.any((extension) => file.path.endsWith(extension))).toList();
    print(externalStorageDir);
    notifyListeners();
  }

}