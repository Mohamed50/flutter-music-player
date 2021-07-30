import 'package:flutter/material.dart';
import 'package:local_music_player/viewModel/setting-view-model.dart';
import 'package:provider/provider.dart';


class CardContainer extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final BoxShape shape;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;
  final double blur;

  const CardContainer({Key key, this.color, this.borderRadius, this.child, this.shape, this.padding, this.margin, this.elevation : 4, this.blur : 4,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SettingViewModel, bool>(
      selector: (_, provider) => provider.isDark(),
      builder: (context, isDark, child) => Container(
        padding: padding ?? EdgeInsets.all(0.0),
        margin: margin ?? EdgeInsets.all(0.0),
        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).backgroundColor,
          borderRadius: borderRadius != null ? borderRadius :  shape == BoxShape.circle ? null : BorderRadius.circular(8.0),
          shape: shape ?? BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
                color: !isDark ? Color.fromRGBO(0, 0, 0, 0.1) : Colors.black.withOpacity(0.1),
                offset: Offset(elevation, elevation),
                blurRadius: blur,
            ),
            BoxShadow(
              color: !isDark ? Color.fromRGBO(0, 0, 0, 0.1) : Colors.black.withOpacity(0.1),
                offset: Offset(-elevation, -elevation),
                blurRadius: blur,
            )
          ]
        ),
        child: child,
      ),
      child: child,
    );
  }
}
