import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';

class FilesPresenter{

  Future<Directory> pickMusicDirectory(BuildContext context) async {
    String? path = await FilesystemPicker.open(
      title: 'Save to folder',
      context: context,
      fsType: FilesystemType.folder,
      pickText: 'select music directory',
      folderIconColor: Colors.teal,
      rootDirectory: Directory(""),
    );
    return Directory(path!);
  }

}