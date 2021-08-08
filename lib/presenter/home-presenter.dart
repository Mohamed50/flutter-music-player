import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/views/album.dart';

class HomePresenter{
  BuildContext context;

  static HomePresenter _mInstance;

  static HomePresenter getInstance(){
    if(_mInstance == null)
      _mInstance = HomePresenter();
    return _mInstance;
  }

  init(BuildContext context){
    this.context = context;
  }

  void albumClickHandler(Album album){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AlbumPage(album: album),
        )
    );
  }


}