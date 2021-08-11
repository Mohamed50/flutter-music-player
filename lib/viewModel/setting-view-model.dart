import 'package:flutter/material.dart';
import 'package:local_music_player/config/Theme.dart';
import 'package:local_music_player/model/resources/pref-manager.dart';
import 'package:local_music_player/utils/utils.dart';
import 'package:package_info/package_info.dart';


class SettingViewModel with ChangeNotifier{
  // PrefManager _prefManager = PrefManager();

  PackageInfo _packageInfo;
  PackageInfo get packageInfo => _packageInfo;

  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;

  SettingViewModel(){
    fetchPackageInfo();
    fetchThemeMode();
  }

  Future fetchPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }


  // Theme Management_______________________________________________________
  void fetchThemeMode() async {
    // String preferredTheme = await _prefManager.getString("theme") ?? "light";
    // if (preferredTheme == "light") {
    //   toLight();
    // } else {
    //   toDark();
    // }
  }

  void changeTheme(ThemeData newThemeData){
    _themeData = newThemeData;
    notifyListeners();
  }

  bool isDark(){
    return isDarkColor(themeData.backgroundColor);
  }


}