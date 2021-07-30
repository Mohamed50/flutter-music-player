import 'dart:io';
import 'package:flutter/material.dart';
import '../rotated-widget.dart';

class ArtCover extends StatelessWidget {
  final File coverArt;
  final String heroTag;
  final Color backgroundColor;

  ArtCover({
    Key key,
    this.coverArt,
    this.backgroundColor, this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedWidget(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: Hero(
                  tag: heroTag,
                  child: Image.file(
                    coverArt,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.multiply,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
