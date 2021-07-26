import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_music_player/config/configuration.dart';
import 'package:local_music_player/utils/routes.dart';
import 'package:local_music_player/viewModel/tracks-view-model.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        padding: EdgeInsets.all(64.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                color: Colors.deepPurple,
              ),
            ),
            Selector<TrackViewModel, ProgressModel>(
                selector: (_, provider) => ProgressModel(provider.progress, provider.length),
                builder: (context, value, child) => Text("${value.progress} of ${value.length}", style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
    );
  }

  Future init() async {
    await Provider.of<TrackViewModel>(context, listen: false).refresh();
    Navigator.of(context).pushReplacementNamed(homeRoute);
  }
}

class ProgressModel{
  final int progress;
  final int length;

  ProgressModel(this.progress, this.length);
}

// <div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
