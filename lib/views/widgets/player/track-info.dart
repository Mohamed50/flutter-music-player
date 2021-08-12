import 'package:flutter/material.dart';

class TrackInfo extends StatelessWidget {
  final String title;
  final String artistName;
  const TrackInfo({Key key, this.title, this.artistName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center,),
        SizedBox(height: 8.0),
        Text(artistName, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center,),
      ],
    );
  }
}
