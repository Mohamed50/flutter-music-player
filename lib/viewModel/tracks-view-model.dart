import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:local_music_player/config/configuration.dart';
import 'package:local_music_player/model/schema/album.dart';
import 'package:local_music_player/model/schema/artist.dart';
import 'package:local_music_player/model/schema/collection.dart';
import 'package:local_music_player/model/schema/playlist.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/utils/utils.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

const List<String> SUPPORTED_FILE_TYPES = [
  'OGG',
  'OGA',
  'OGX',
  'AAC',
  'M4A',
  'MP3',
  'WMA',
  'WAV',
  'FLAC',
  'OPUS',
];

class TrackViewModel with ChangeNotifier {
  // List<Track> _tracks = [];
  //
  // List<Track> get tracks => _tracks;

  List<Playlist> playlists = <Playlist>[];
  List<Album> _albums = <Album>[];
  List<Track> _tracks = <Track>[];
  List<Artist> _artists = <Artist>[];
  List<Track> _favorites = <Track>[];

  List<Album> get albums => _albums;

  List<Track> get tracks => _tracks;

  List<Track> get favorites => _favorites;

  List<Artist> get artists => _artists;

  Album lastAlbum;
  Track lastTrack;
  Artist lastArtist;

  int _progress = 0;

  int get progress => _progress;

  int _length = 0;

  int get length => _length;

  List<Directory> _directories = [];

  List<Directory> get directories => _directories;

  List<File> collectionDirectoryContent = <File>[];

  TrackViewModel() {
    directories.add(Directory("/storage/emulated/0/Music"));
  }

  init() async {
    Collection collection = await fetchCollectionFromCache();
    if(collection.tracks != null && collection.tracks.isNotEmpty){
      _tracks = collection.tracks;
      _albums = collection.albums;
      _artists = collection.artists;
      playlists = collection.playlists;
      _favorites = playlists.first.tracks;
      notifyListeners();
    }
    else {
      await refresh();
    }
  }

  Future<void> refresh() async {
    if (await Permission.storage.request().isGranted) {
      Directory directory = directories.first;
      for (FileSystemEntity object in directory.listSync(recursive: true)) {
        if (isFileSupported(object) && object is File) {
          print("file supported: ${object.path}");
          collectionDirectoryContent.add(object);
        }
      }
      _length = collectionDirectoryContent.length;
      await fetchTracks();
      saveCollectionToCache();
      notifyListeners();
    }
  }

  addFavoritesToPlaylist(){
    playlists.add(Playlist(
      playlistName: "Favorites",
      tracks: favorites,
    ));
    notifyListeners();
  }

  fetchTracks() async {
    if (collectionDirectoryContent.length != _tracks.length) {
      for (int i = 0; i < collectionDirectoryContent.length; i++) {
        File file = collectionDirectoryContent[i];
        await addTrack(file);
      }
    }
  }

  addTrack(File file) async {
    MetadataRetriever retriever = new MetadataRetriever();
    await retriever.setFile(file);
    Track track = await Track.fromMap((await retriever.metadata).toMap());
    track.filePath = file.path;
    if (track.trackName == 'Unknown Track') {
      track.trackName = path.basename(file.path).split('.').first;
    }
    if (retriever.albumArt != null) {
      File albumArtFile = new File(path.join(
          configuration.cacheDirectory.path,
          'albumArts',
          '${track.albumArtistName}_${track.albumName}'
                  .replaceAll(new RegExp(r'[^\s\w]'), ' ') +
              '.PNG'));
      await albumArtFile.writeAsBytes(retriever.albumArt);
    }
    tracks.add(track);
    addTrackToAlbum(track);
    onProgress();
  }

  addTrackToAlbum(Track track) {
    if (albums.isNotEmpty) {
      Album album = albums.firstWhere(
        (element) =>
            element.albumName == track.albumName &&
                (element.albumArtistName == track.albumArtistName || element.albumArtistName.toLowerCase() == "unknown artist" || track.albumArtistName.toLowerCase() == "unknown artist"),
        orElse: () => null,
      );
      if (album != null) {
        album.tracks.add(track);
        return;
      }
    }
    Album album = Album(
      albumName: track.albumName,
      albumArtistName: track.albumArtistName,
      albumArtHigh: track.albumArtHigh,
      albumArtLow: track.albumArtLow,
      albumArtMedium: track.albumArtMedium,
      dominateColor: track.dominateColor,
      secondaryColor: track.secondaryColor,
      accentColor: track.accentColor,
    )..tracks.add(track);
    albums.add(album);
    addAlbumToArtist(album);
  }

  addAlbumToArtist(Album album) {
    if (artists.isNotEmpty) {
      Artist artist = artists.firstWhere(
        (element) => element.artistName == album.albumArtistName,
        orElse: () => null,
      );
      if (artist != null) {
        artist.albums.add(album);
        return;
      }
    }
    artists.add(Artist(artistName: album.albumArtistName)
      ..albums.add(album)
      ..tracks.addAll(album.tracks));
  }

  onProgress() {
    ++_progress;
    notifyListeners();
  }

  Future saveCollectionToCache() async {
    if(playlists.isEmpty || !playlists.any((element) => element.playlistName.toLowerCase() == "favorites"))
      addFavoritesToPlaylist();
    print(playlists);
    await writeContentToFile(
        configuration.collectionFile,
        Collection(
          tracks: tracks,
          albums: albums,
          artists: artists,
          playlists: playlists,
        ).toMap());
  }

  Future<Collection> fetchCollectionFromCache() async {
    Map mapCollection = await readContentFromFile(configuration.collectionFile);
    return Collection.fromMap(mapCollection);
  }

  void handleFavorites(Track track) {
    bool found = favorites.any((element) => element.filePath == track.filePath);
    if(found)
      _favorites.removeWhere((element) => element.filePath == track.filePath);
    else
      _favorites.add(track);
    saveCollectionToCache();
    notifyListeners();
  }

  bool isFavorite(Track track){
    print("isFavorite: ${favorites.any((element) => element.filePath == track.filePath)}");
    return favorites.any((element) => element.filePath == track.filePath);
  }

  void addToPlaylist(Track track, Playlist playlist) {
    playlists.firstWhere((element) => element.playlistName == playlist.playlistName).tracks.add(track);
    notifyListeners();
    saveCollectionToCache();
  }

  void addNewPlaylist(Playlist playlist) {
    playlists.add(playlist);
    notifyListeners();
    saveCollectionToCache();
  }


}
