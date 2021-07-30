import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:local_music_player/model/schema/media-type.dart';

class PlayerViewModel with ChangeNotifier{
  AudioPlayer _audioPlayer;
  static const int playerId = 153554645;


  PlayerState _state = PlayerState.COMPLETED;
  PlayerState get state => _state;

  Duration _position = Duration(seconds: 0);
  Duration get position => _position;

  Duration _duration = Duration(seconds: 100);
  Duration get duration => _duration;

  Track _track;
  Track get track => _track;

  PlayerViewModel(){
    init();
    listenToPlayerState();
    listenToDuration();
    listenToPosition();
  }

  init(){
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER, playerId: playerId.toString());
    _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  listenToDuration(){
    _audioPlayer.onDurationChanged.listen((event) {
      _duration = event;
      notifyListeners();
    });
  }

  listenToPosition(){
    _audioPlayer.onAudioPositionChanged.listen((event) {
      _position = event;
      notifyListeners();
    });
  }

  listenToPlayerState(){
    _audioPlayer.onPlayerStateChanged.listen((event) {
      _state = event;
      print(event);
      notifyListeners();
    });
  }

  playTrack(Track track){
    _track = track;
    notifyListeners();
    play();
  }

  play(){
    _audioPlayer.play(
      track.filePath,
      stayAwake: true,
      volume: 1.0,
    );
  }

  pause(){
    _audioPlayer.pause();
  }

  resume(){
    _audioPlayer.resume();
  }

  stop(){
    _audioPlayer.stop();
  }

  seek(int toSecond){
    _audioPlayer.seek(Duration(seconds: toSecond));
  }

  forward(int numOfSeconds){
    seek(_position.inSeconds + numOfSeconds);
  }

  rewind(int numOfSeconds){
    seek(_position.inSeconds - numOfSeconds);
  }

  bool isPlaying(Track track){
    return _state == PlayerState.PLAYING && _track.filePath == track.filePath;
  }

  // void handlePlayButton(Track track) {
  //   if(_state == PlayerState.COMPLETED || _state == PlayerState.STOPPED || _track.path != _track.path)
  //     playTrack(track);
  //   else if(_state == PlayerState.PAUSED)
  //     resume();
  //   else
  //     pause();
  // }

  void handlePlayButton() {
    if(_state == PlayerState.COMPLETED || _state == PlayerState.STOPPED)
      play();
    else if(_state == PlayerState.PAUSED)
      resume();
    else
      pause();
  }

  void setTrack(Track track) {
    _track = track;
    _audioPlayer.setUrl(_track.filePath);
    notifyListeners();
  }

}