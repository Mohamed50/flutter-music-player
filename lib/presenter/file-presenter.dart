import 'dart:io';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:local_music_player/viewModel/files-view-model.dart';
import 'package:provider/provider.dart';

class FilesPresenter{

  final BuildContext context;
  FilesViewModel _filesViewModel;

  FilesPresenter(this.context){
    _filesViewModel = Provider.of(context, listen: false);
  }

  Future<Directory> pickMusicDirectory() async {
    String path = await FilesystemPicker.open(
      title: 'Save to folder',
      context: context,
      fsType: FilesystemType.folder,
      pickText: 'select music directory',
      folderIconColor: Colors.teal,
      rootDirectory: Directory("/storage/emulated/0/"),
    );
    return Directory(path);
  }

  addNewDirectory() async {
    Directory directory = await pickMusicDirectory();
    _filesViewModel.addDirectory(directory);
  }

}
