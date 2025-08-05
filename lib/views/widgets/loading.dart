import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/views/animations/popup_animation.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          color: AppColors.primary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: Colors.black,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}

class ShowLoading extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;
  final Color? boxColor;
  const ShowLoading({
    super.key,
    this.boxColor,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.1,
    this.color = Colors.transparent,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.transparent),
          ),
          Container(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 100,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          // ignore: prefer_const_constructors
          PopupAnimation(
            delay: 200,
            child: LoadingWidget(height: SizeConfig.heightMultiplier * 100),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }
}
