import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tinycolor/tinycolor.dart';

class UtilViewModel with ChangeNotifier {
  PaletteGenerator paletteGenerator;

  PaletteColor _color = PaletteColor(Colors.grey[900],3);
  PaletteColor get color => _color;

  Color _titleColor;
  Color get titleColor => _titleColor;

  Future updatePaletteGenerator(ImageProvider imageProvider) async {
    try {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        maximumColorCount: 3,
      );
      _color = paletteGenerator.dominantColor ?? PaletteColor(Colors.grey[900],3);
      _titleColor = TinyColor(_color.color).isDark()
          ? Colors.white
          : Colors.grey[900];
    }
    catch(err){
      print("error: ${err.toString()}");
      _color = PaletteColor(Colors.grey[900],3);
    }
    notifyListeners();
  }


}
