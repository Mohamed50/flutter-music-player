import 'package:afnan_ivr_portal/data/service/announcement-service.dart';
import 'package:afnan_ivr_portal/data/model/announcement.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioViewModel with ChangeNotifier{
  AnnouncementService _announcementService = AnnouncementService();
  AudioPlayer _audioPlayer;

  Announcement _announcement;
  Announcement get announcement => _announcement;

  AudioPlayerState _state = AudioPlayerState.COMPLETED;
  AudioPlayerState get state => _state;

  Duration _position = Duration(seconds: 0);
  Duration get position => _position;

  Duration _duration = Duration(seconds: 0);
  Duration get duration => _duration;

  AudioViewModel(){
    init();
    listenToPlayerState();
    listenToDuration();
    listenToPosition();
  }

  init(){
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER, playerId: "ivr-portal");
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

  playAnnouncement(Announcement announcement){
    _announcement = announcement;
    notifyListeners();
    play();
  }

  play(){
    _audioPlayer.play(
      _announcementService.getAnnouncementURL(_announcement.title),
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

  bool isPlaying(Announcement announcement){
    return _state == AudioPlayerState.PLAYING && _announcement.id == announcement.id;
  }

  void handlePlayButton(bool value, Announcement announcement) {
    if(_state == AudioPlayerState.COMPLETED || _state == AudioPlayerState.STOPPED || _announcement.id != announcement.id)
      playAnnouncement(announcement);
    else if(_state == AudioPlayerState.PAUSED)
      resume();
    else
      pause();
  }

}