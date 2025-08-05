import 'package:flutter/material.dart';

class SlideInFromBottomAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SlideInFromBottomAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  _SlideInFromBottomAnimationState createState() =>
      _SlideInFromBottomAnimationState();
}

class _SlideInFromBottomAnimationState extends State<SlideInFromBottomAnimation>
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
      begin: const Offset(0.0, 2.0),
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
