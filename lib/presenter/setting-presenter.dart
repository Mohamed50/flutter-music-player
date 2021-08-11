import 'package:flutter/material.dart';
import 'package:local_music_player/config/Theme.dart';
import 'package:local_music_player/model/schema/track.dart';
import 'package:local_music_player/viewModel/setting-view-model.dart';
import 'package:provider/provider.dart';

class SettingPresenter {
  BuildContext context;
  SettingViewModel _settingViewModel;

  static SettingPresenter _mInstance;

  static SettingPresenter getInstance() {
    if (_mInstance == null) _mInstance = SettingPresenter();
    return _mInstance;
  }

  init(BuildContext context) {
    this.context = context;
    _settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
  }

  void onTrackChanged(Track track) {
    _settingViewModel.changeTheme(
      lightTheme.copyWith(
        primaryColor: track.secondaryColor,
        accentColor: track.secondaryColor,
        backgroundColor: track.dominateColor,
        appBarTheme: AppBarTheme(
            color: track.dominateColor,
            textTheme: getTextThemeWithColor(track.accentColor),
            iconTheme: IconThemeData(color: track.secondaryColor)),
        bottomAppBarTheme: BottomAppBarTheme(color: track.dominateColor),
        scaffoldBackgroundColor: track.dominateColor,
        textTheme: getTextThemeWithColor(track.accentColor),
      ),
    );
  }
}
