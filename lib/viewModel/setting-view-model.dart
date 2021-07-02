import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_music_player/model/resources/pref-manager.dart';
import 'package:package_info/package_info.dart';
import 'package:local_music_player/config/language.dart';


class SettingViewModel with ChangeNotifier{
  PrefManager _prefManager = PrefManager();

  PackageInfo _packageInfo;
  PackageInfo get packageInfo => _packageInfo;

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  Locale _locale = Locale("en");
  Locale get locale => _locale;

  List<Locale> _supportedLocales;
  List<Locale> get supportedLocales => _supportedLocales;

  Map _localizedValues;
  Map get localizedValues => _localizedValues;

  SettingViewModel(){
    fetchPackageInfo();
    fetchThemeMode();
    fetchSupportedLanguages();
  }

  Future fetchPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }


  // Theme Management_______________________________________________________
  void fetchThemeMode() async {
    String preferredTheme = await _prefManager.getString("theme") ?? "light";
    if (preferredTheme == "light") {
      toLight();
    } else {
      toDark();
    }
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }

  void toDark() async {
    await _prefManager.setString("theme", "dark");
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void toLight() async {
    await _prefManager.setString("theme", "light");
    _themeMode = ThemeMode.light;
    notifyListeners();
  }



  // Language Management_______________________________________________________
  void fetchSupportedLanguages() async {
    _supportedLocales = supportedLanguages
        .map((supportedLanguage) => Locale(supportedLanguage))
        .toList();
  }

  void fetchPreferredLanguage() async {
    String lang = await _prefManager.get('language',supportedLanguages[0]);
    _locale = Locale(lang);
    notifyListeners();
  }

  void setPreferredLanguage(String lang){
    _prefManager.set('language', lang);
  }

  void changeLanguage(String lang) async {
    _locale = Locale(lang);
    String jsonContent = await rootBundle.loadString("locale/i18n_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    notifyListeners();
  }

  void switchLanguage(){
    if (locale.languageCode == "en") {
      changeLanguage("ar");
    } else {
      changeLanguage("en");
    }
  }

  String translate(String key) {
    if(_localizedValues == null || _localizedValues[key] == null)
      return key;
    else
      return _localizedValues[key];
  }

  bool isRtl(){
    return _locale.languageCode == "ar";
  }

}