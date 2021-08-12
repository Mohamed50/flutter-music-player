import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:local_music_player/model/schema/track.dart';

enum RepeatMode { RepeatOne, Repeat }

class PlayerViewModel with ChangeNotifier {
  AudioPlayer _audioPlayer;
  static const int playerId = 1;

  PlayerState _state = PlayerState.COMPLETED;

  PlayerState get state => _state;

  RepeatMode _repeatMode = RepeatMode.Repeat;

  RepeatMode get repeatMode => _repeatMode;

  Duration _position = Duration(seconds: 0);

  Duration get position => _position;

  Duration _duration = Duration(seconds: 100);

  Duration get duration => _duration;

  Track _track;

  Track get track => _track;

  List<Track> _playlist;

  List<Track> get playlist => _playlist;

  ValueChanged<Track> onTrackChanged;

  PlayerViewModel(ValueChanged<Track> onTrackChanged) {
    this.onTrackChanged = onTrackChanged;
    init();
    listenToPlayerState();
    listenToDuration();
    listenToPosition();
  }

  init() {
    _audioPlayer = AudioPlayer(
        mode: PlayerMode.MEDIA_PLAYER, playerId: playerId.toString());
    _audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
  }

  listenToDuration() {
    _audioPlayer.onDurationChanged.listen((event) {
      _duration = event;
      notifyListeners();
    });
  }

  listenToPosition() {
    _audioPlayer.onAudioPositionChanged.listen((event) {
      _position = event;
      notifyListeners();
    });
  }

  listenToPlayerState() {
    _audioPlayer.onPlayerStateChanged.listen((event) {
      _state = event;
      handleSongCompleted();
      print(event);
      notifyListeners();
    });
  }

  void handleSongCompleted() {
    if (_state == PlayerState.COMPLETED) {
      if (repeatMode == RepeatMode.Repeat)
        playNextTrack();
      else
        repeat();
    }
  }

  playNextTrack() {
    if (playlist.isNotEmpty) {
      int index = playlist.indexOf(track);
      if (index < playlist.length - 1)
        playTrack(playlist[++index]);
      else
        playTrack(playlist.first);
    }
  }

  playPrevTrack() {
    if (playlist.isNotEmpty) {
      int index = playlist.indexOf(track);
      if (index > 0)
        playTrack(playlist[--index]);
      else
        playTrack(playlist.last);
    }
  }

  playTrack(Track track) {
    _track = track;
    notifyListeners();
    play();
    onTrackChanged(track);
  }

  shufflePlaylist(List<Track> newPlaylist) {
    _playlist = newPlaylist;
    playlist.shuffle();
    playTrack(_playlist.first);
  }

  playPlaylist(List<Track> newPlaylist, int index) {
    _playlist = newPlaylist;
    playTrack(_playlist[index]);
  }

  play() {
    _audioPlayer.play(
      track.filePath,
      stayAwake: true,
      volume: 1.0,
    );
  }

  pause() {
    _audioPlayer.pause();
  }

  resume() {
    _audioPlayer.resume();
  }

  stop() {
    _audioPlayer.stop();
  }

  repeat() {
    seek(0);
    play();
  }

  seek(int toSecond) {
    _audioPlayer.seek(Duration(seconds: toSecond));
  }

  forward(int numOfSeconds) {
    seek(_position.inSeconds + numOfSeconds);
  }

  rewind(int numOfSeconds) {
    seek(_position.inSeconds - numOfSeconds);
  }

  bool isPlaying(Track track) {
    return _state == PlayerState.PLAYING && _track.filePath == track.filePath;
  }

  void handlePlayButton() {
    if (_state == PlayerState.COMPLETED || _state == PlayerState.STOPPED)
      play();
    else if (_state == PlayerState.PAUSED)
      resume();
    else
      pause();
  }

  void handleRepeatMode() {
    if (_repeatMode == RepeatMode.Repeat)
      _repeatMode = RepeatMode.RepeatOne;
    else
      _repeatMode = RepeatMode.Repeat;
    notifyListeners();
  }

  void setTrack(Track track) {
    _track = track;
    _audioPlayer.setUrl(_track.filePath);
    notifyListeners();
  }

  void changePlaylist(List<Track> playlist) {
    _playlist = playlist;
    notifyListeners();
  }

  void addToQueue(Track track) {
    if (!isInPlaylist(track)) {
      _playlist.add(track);
      notifyListeners();
    }
  }

  void playNext(Track track) {
    if (isInPlaylist(track))
      _playlist.removeWhere((element) => element.filePath == track.filePath);
    _playlist.insert(playlist.indexOf(_track) + 1, track);
    notifyListeners();
  }

  bool isInPlaylist(Track track) {
    return playlist.any((element) => element.filePath == track.filePath);
  }

}
