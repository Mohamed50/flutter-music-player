import 'package:flutter/material.dart';
import 'package:local_music_player/presenter/setting-presenter.dart';
import 'package:local_music_player/viewModel/setting-view-model.dart';
import 'package:provider/provider.dart';

class SettingHandler extends StatelessWidget {
  final Widget Function(BuildContext context, SettingViewModel setting) builder;

  const SettingHandler({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingViewModel(),
      lazy: false,
      child: Consumer<SettingViewModel>(
        builder: (BuildContext context, SettingViewModel setting, Widget child) {
          SettingPresenter.getInstance().init(context);
          return builder(context, setting);
        },
      ),
    );
  }
}
