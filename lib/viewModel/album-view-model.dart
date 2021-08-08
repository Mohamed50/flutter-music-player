import 'package:flutter/foundation.dart';
import 'package:local_music_player/model/schema/album.dart';

class AlbumViewModel with ChangeNotifier{
  Album _selectedAlbum;
  Album get selectedAlbum => _selectedAlbum;


  void selectAlbum(Album album){
    _selectedAlbum = album;
    notifyListeners();
  }


}