import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

class Loadinganimation extends StatefulWidget {
  const Loadinganimation({super.key});

  @override
  State<Loadinganimation> createState() => _LoadinganimationState();
}

class _LoadinganimationState extends State<Loadinganimation> with TickerProviderStateMixin {
  late AnimationController animationController;
  late final Ticker? _ticker;

  double initAngle = 0.0;
  final double speed = 120;
  double _angle = 0;

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    initAngle = 0.0;
    _ticker = Ticker((elapsed) {
      setState(() {
        _angle = speed * elapsed.inMilliseconds / 1000;
      });
    });
    _ticker?.start();

    super.initState();
  }
  @override
  void dispose() {
    _ticker?.stop();
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle / 180 * pi, // radian
      child: Image.asset('assets/images/1007해변.png'),
    );
  }
}
