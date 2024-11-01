import 'package:flutter/material.dart';

class PulsatingImage extends StatefulWidget {
  const PulsatingImage({super.key});

  @override
  _PulsatingImageState createState() => _PulsatingImageState();
}

class _PulsatingImageState extends State<PulsatingImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Image.asset('assets/images/로딩이미지.png'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}