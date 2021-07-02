import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/presenter/file-presenter.dart';
import 'package:local_music_player/viewModel/files-view-model.dart';
import 'package:local_music_player/views/player.dart';
import 'package:provider/provider.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilesPresenter filesPresenter = FilesPresenter(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: filesPresenter.addNewDirectory,
                child: Text("Select Directory")),
            Selector<FilesViewModel, List<FileSystemEntity>>(
              selector: (_, provider) => provider.files,
              shouldRebuild: (previous, next) => true,
              builder: (context, files, child) => Expanded(
                child: ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () async {
                      Track track = Track(
                          Provider.of<FilesViewModel>(context, listen: false)
                              .files
                              .first
                              .path);
                      await Future.delayed(Duration(milliseconds: 300));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayerPage(track: track),
                      ));
                    },
                    title: Text(files[index].path),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
