import 'package:flutter/material.dart';
import 'package:local_music_player/presenter/player-presenter.dart';
import 'package:local_music_player/viewModel/audio-view-model.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularSlider extends StatelessWidget {
  final Color progressBarColor;
  final Color dotColor;
  final Color trackColor;
  final Widget child;

  const CircularSlider(
      {Key key,
      this.child,
      this.progressBarColor,
      this.dotColor,
      this.trackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PlayerViewModel, Model>(
      selector: (_, provider) => Model(provider.duration, provider.position),
      builder: (context, model, child) => SleekCircularSlider(
        min: 0,
        max: model.duration.inSeconds.toDouble(),
        initialValue: model.position.inSeconds.toDouble(),
        appearance: CircularSliderAppearance(
          size: MediaQuery.of(context).size.width,
          customWidths: CustomSliderWidths(
            progressBarWidth: 20.0,
          ),
          customColors: CustomSliderColors(
              progressBarColor: progressBarColor,
              dotColor: dotColor,
              trackColor: trackColor,
              shadowColor: trackColor,
              shadowStep: 2),
        ),
        innerWidget: (double value) => child,
        onChange: (value) {
          // PlayerPresenter.getInstance(context).seek(value);
        },
      ),
      child: child,
    );
  }
}

class Model{
  final Duration duration;
  final Duration position;

  Model(this.duration, this.position);
}
