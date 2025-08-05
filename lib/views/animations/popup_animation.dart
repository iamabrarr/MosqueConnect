import 'package:flutter/material.dart';

class PopupAnimation extends StatefulWidget {
  final Widget child; // The widget to animate
  final int delay; // Delay before the animation starts (in milliseconds)
  final Duration duration; // Animation duration
  final double startScale; // Initial scale value (default is 0.8)

  const PopupAnimation({
    Key? key,
    required this.child,
    required this.delay,
    this.duration = const Duration(milliseconds: 500),
    this.startScale = 0,
  }) : super(key: key);

  @override
  _PopupAnimationState createState() => _PopupAnimationState();
}

class _PopupAnimationState extends State<PopupAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.startScale,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // Creates a smooth "pop" effect
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(milliseconds: widget.delay));
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
