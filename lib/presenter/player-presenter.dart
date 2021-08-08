import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:provider/provider.dart';

class PlayerPresenter{
  static PlayerPresenter _mInstance;
  static BuildContext _context;
  PlayerViewModel _playerViewModel;


  PlayerPresenter(BuildContext context){
    _context = context;
    _playerViewModel = Provider.of(context, listen: false);
  }

  static PlayerPresenter getInstance(BuildContext context){
    if(_mInstance == null)
      _mInstance = PlayerPresenter(context);
    else
      _context = context;
    return _mInstance;
  }



  void setTrack(Track track){
    _playerViewModel.setTrack(track);
  }

  void playPlaylist(List<Track> newPlaylist){
    _playerViewModel.playPlaylist(newPlaylist);
  }

  void next(){
    _playerViewModel.playNextTrack();
  }

  void prev(){
    _playerViewModel.playPrevTrack();
  }


  handlePLayButton(){
    _playerViewModel.handlePlayButton();
  }

}
