import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/utils/size_config.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.isPassword,
    this.suffix,
    this.autoFocus = false,
    this.onTap,
    this.cursorColor,
    this.hideHintText = false,
    this.maxLines = 1,
  });
  final String label;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Widget? suffix;
  final bool autoFocus;
  final Color? cursorColor;
  final int maxLines;
  final bool hideHintText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: cursorColor,
        autofocus: autoFocus,
        enabled: onTap == null,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.6),
        decoration: InputDecoration(
          label: Text(label),
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: SizeConfig.textMultiplier * 1.5,
          ),
          labelStyle: TextStyle(
            color: Colors.black26,
            fontSize: SizeConfig.textMultiplier * 1.5,
          ),
          hintText: hideHintText ? null : label,

          // suffixIconConstraints: BoxConstraints(
          //   maxWidth: SizeConfig.widthMultiplier * 12,
          // ),
          suffixIcon: suffix,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black26,
            fontSize: SizeConfig.textMultiplier * 1.5,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 3,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: AppColors.unFocusGreyClr),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: AppColors.unFocusGreyClr),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: AppColors.unFocusGreyClr),
          ),
        ),
      ),
    );
  }
}
