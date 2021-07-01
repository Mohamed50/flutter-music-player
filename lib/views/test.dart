import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_music_player/viewModel/files-view-model.dart';
import 'package:provider/provider.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<FilesViewModel, List<FileSystemEntity>>(
        selector: (_, provider) => provider.files,
        builder: (context, files, child) => ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(files[index].path),
          ),
        ),
      ),
    );
  }
}
