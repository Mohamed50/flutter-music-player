import 'package:flutter/material.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:local_music_player/views/widgets/add-to-playlist-bottom-sheet.dart';
import 'package:local_music_player/views/widgets/new-playlist-bottom-sheet.dart';
import 'package:local_music_player/views/widgets/player/track-option-bottom-sheet.dart';
import 'package:provider/provider.dart';

class PlayerPresenter{
  static PlayerPresenter _mInstance;
  static BuildContext _context;
  PlayerViewModel _playerViewModel;
  TrackViewModel _trackViewModel;


  PlayerPresenter(BuildContext context){
    _context = context;
    _playerViewModel = Provider.of(context, listen: false);
    _trackViewModel = Provider.of(context, listen: false);
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


  void handlePLayButton(){
    _playerViewModel.handlePlayButton();
  }

  void handleRepeatMode(){
    _playerViewModel.handleRepeatMode();
  }

  void reorderPlaylist(List<Track> playlist){
    _playerViewModel.changePlaylist(playlist);
  }

  void seek(double value) {
    _playerViewModel.seek(value.toInt());
  }

  void showTrackOptionBottomSheet(Track track) {
    showModalBottomSheet(context: _context, builder: (context) => TrackOptionBottomSheet(track: track,));
  }

  void showAddToPlaylistBottomSheet(Track track) {
    showModalBottomSheet(context: _context, builder: (context) => AddToPlaylistBottomSheet(track: track,));
  }

  void showNewPlaylistBottomSheet(Track track) {
    showModalBottomSheet(context: _context, builder: (context) => NewPlaylistBottomSheet(track: track,));
  }

  void addToQueue(Track track){
    _playerViewModel.addToQueue(track);
  }

  void playNext(Track track){
    _playerViewModel.playNext(track);
  }

  void handleFavoriteButton(Track track) {
      _trackViewModel.handleFavorites(track);
  }

  void addToPlaylist(Track track, Playlist playlist) {
    _trackViewModel.addToPlaylist(track, playlist);
  }

  void addNewPlaylist(Playlist newPlaylist) {
    _trackViewModel.addNewPlaylist(newPlaylist);
  }

}
