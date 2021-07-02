import 'package:flutter/material.dart';

class RotatedWidget extends StatefulWidget {
  final Widget child;

  const RotatedWidget({Key key, this.child}) : super(key: key);

  @override
  _RotatedWidgetState createState() => _RotatedWidgetState();
}

class _RotatedWidgetState extends State<RotatedWidget>
    with TickerProviderStateMixin {
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    rotationController.forward();
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        rotationController.forward(from: 0.0);
    });

    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
        child: widget.child,
    );
  }
}
