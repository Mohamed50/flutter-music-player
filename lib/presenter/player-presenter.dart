import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/views/widgets/player/queue-bottom-sheet.dart';
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

  void playTrack(Track track){
    _playerViewModel.playTrack(track);
  }

  void playPlaylist(List<Track> newPlaylist, [int index]){
    if(index == null)
      _playerViewModel.shufflePlaylist(newPlaylist);
    else
      _playerViewModel.playPlaylist(newPlaylist, index);
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

  showPlaylist(){
    showBottomSheet(context: _context, builder: (context) => QueueBottomSheet(),);
  }


  reorderPlaylist(List<Track> playlist){
    _playerViewModel.changePlaylist(playlist);
  }

}
