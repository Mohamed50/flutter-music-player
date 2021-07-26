// import 'dart:io';
// import 'package:flutter/material.dart';
//
// List<String> supportedAudioExtensions = ["mp3", "flac","m4a"];
//
// class FilesViewModel with ChangeNotifier {
//   List<FileSystemEntity> _files = [];
//   List<FileSystemEntity> get files => _files;
//
//   List<Directory> _directories = [];
//   List<Directory> get directories => _directories;
//
//   FilesViewModel(){
//     directories.add(Directory("/storage/emulated/0/"));
//     fetchAllAudioFilesFromDirectories();
//   }
//
//   fetchAllAudioFilesFromDirectory(Directory directory) async {
//     List<FileSystemEntity> allFiles = directory.listSync(recursive: true, followLinks: false);
//     _files.addAll(allFiles.where((file) => supportedAudioExtensions.any((extension) => file.path.endsWith(extension))));
//     notifyListeners();
//   }
//
//   addDirectory(Directory directory) {
//     _directories.add(directory);
//     fetchAllAudioFilesFromDirectory(directory);
//   }
//
//   fetchAllAudioFilesFromDirectories(){
//     _files.clear();
//     directories.forEach((directory) {
//       fetchAllAudioFilesFromDirectory(directory);
//     });
//   }
//
//
// }
