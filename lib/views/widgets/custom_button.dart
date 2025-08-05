import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/utils/size_config.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;

  final bool isShadow;
  final double? height, width, fontSize;
  final String? payableAmount;
  final bool isLoading;
  final bool isBorder;
  final bool disable;
  final List<Color>? gradientColors;
  const CustomButton({
    required this.onPressed,
    super.key,
    required this.text,
    this.disable = false,
    this.fontSize,
    this.isBorder = false,
    this.isShadow = true,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.payableAmount,
    this.isLoading = false,
    this.borderColor,
    this.gradientColors,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
        if (!widget.disable) {
          widget.onPressed();
        }
      },
      child: Transform.scale(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: widget.height ?? SizeConfig.heightMultiplier * 5,
          width: widget.width ?? SizeConfig.widthMultiplier * 84,
          decoration: BoxDecoration(
            // gradient:
            //     widget.gradientColors != null
            //         ? LinearGradient(colors: widget.gradientColors!)
            //         : null,
            color: widget.isBorder
                ? null
                : widget.isLoading
                ? Colors.grey.shade300
                : widget.gradientColors != null
                ? AppColors.primary
                : widget.disable
                ? (widget.color ?? AppColors.primary).withOpacity(.2)
                : (widget.color ?? AppColors.primary),

            border: widget.isBorder
                ? Border.all(color: widget.borderColor ?? AppColors.primary)
                : null,
            boxShadow: widget.isLoading
                ? null
                : widget.disable
                ? []
                : !widget.isShadow
                ? null
                : [
                    BoxShadow(
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                      spreadRadius: 4,
                      color: widget.color ?? AppColors.primary.withOpacity(.2),
                    ),
                  ],
            borderRadius: BorderRadius.circular(100),
          ),
          child: widget.isLoading
              ? Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: widget.disable
                            ? (widget.color ?? AppColors.primary)
                            : widget.textColor ?? Colors.white,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    widget.payableAmount == null
                        ? const SizedBox()
                        : Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 2,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white60,
                            ),
                            child: Text(
                              widget.payableAmount!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
