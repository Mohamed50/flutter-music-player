import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:local_music_player/model/schema/artist.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tinycolor/tinycolor.dart';

class Track{
  String name;
  final String path;
  Artist artist;
  Uint8List coverArt;
  Metadata metadata;
  MetadataRetriever retriever;
  Color dominateColor;
  Color secondaryColor;
  Color accentColor;

  Track(this.path){
    init();
  }

  init() async{
    name = path.split("/").last.split(".").first;
    metadata = await fetchMetaData(path);
    coverArt = await fetchCoverArt();
    dominateColor = await fetchDominateColor();
    accentColor = fetchAccentColor();
  }

  Future<Metadata> fetchMetaData(String path) async {
    retriever = new MetadataRetriever();
    await retriever.setFile(new File(path));
    return await retriever.metadata;
  }

  Future<Uint8List> fetchCoverArt() async {
    return retriever.albumArt;
  }

  Future<Color> fetchDominateColor() async{
    Size size = Size(120.0, 120.0);
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      MemoryImage(coverArt),
      size: size,
      region: Offset.zero & size,
      maximumColorCount: 1,
    );
    secondaryColor = paletteGenerator.dominantColor.titleTextColor;
    return paletteGenerator.dominantColor.color;
  }

  Color fetchAccentColor(){
    return TinyColor(dominateColor).isDark()
        ? Colors.white
        : Colors.grey[900];
  }

}