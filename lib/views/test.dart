import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:local_music_player/presenter/file-presenter.dart';
import 'package:local_music_player/viewModel/files-view-model.dart';
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
                    title: Text(files[index].path),
                    subtitle: FutureBuilder<Metadata>(
                      future: fetchMetaData(files[index]),
                      builder: (BuildContext context,
                          AsyncSnapshot<Metadata> snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();
                        else
                          return Text(snapshot.data.albumName.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Metadata> fetchMetaData(FileSystemEntity fileSystemEntity) async {
    var retriever = new MetadataRetriever();
    await retriever.setFile(new File(fileSystemEntity.path));
    return await retriever.metadata;
  }


}
