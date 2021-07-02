import 'package:flutter/material.dart';
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
    return SleekCircularSlider(
      min: 0,
      max: 1000,
      initialValue: 50,
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
    );
  }
}
