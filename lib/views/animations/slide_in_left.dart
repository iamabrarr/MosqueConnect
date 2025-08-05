import 'package:flutter/material.dart';

class SlideInFromLeftAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SlideInFromLeftAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  _SlideInFromLeftAnimationState createState() =>
      _SlideInFromLeftAnimationState();
}

class _SlideInFromLeftAnimationState extends State<SlideInFromLeftAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
