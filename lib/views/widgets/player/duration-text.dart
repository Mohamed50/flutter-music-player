import 'package:flutter/material.dart';

class DurationText extends StatelessWidget {
  final int seconds;
  final Color color;
  final double fontSize;
  const DurationText({Key key, this.seconds, this.color, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String duration = _getDuration(Duration(seconds: seconds));
    return Text(duration, style: TextStyle(
      color: color, fontSize: fontSize,
    ),);
  }
  String _getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
