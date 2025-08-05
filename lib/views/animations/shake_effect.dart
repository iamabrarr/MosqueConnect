import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ShakeEffect extends StatefulWidget {
  final Widget child;
  final Duration interval;
  final double offset;

  const ShakeEffect({
    Key? key,
    required this.child,
    this.interval = const Duration(seconds: 1),
    this.offset = 4.0,
  }) : super(key: key);

  @override
  _ShakeEffectState createState() => _ShakeEffectState();
}

class _ShakeEffectState extends State<ShakeEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller and animation.
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 500,
      ), // Smoother, longer shake duration
      vsync: this,
    );

    // Adding an easing curve for smoother animation.
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth in-out curve
      ),
    );

    // Trigger the shake every interval.
    _timer = Timer.periodic(widget.interval, (_) {
      _controller.forward(from: 0); // Start the animation
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double progress = _animation.value;
        double offset =
            sin(progress * pi * 3) * widget.offset; // Smaller shake cycle

        return Transform.translate(
          offset: Offset(offset, 0),
          child: widget.child,
        );
      },
    );
  }
}
