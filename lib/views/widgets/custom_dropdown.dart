import 'package:flutter/material.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/utils/size_config.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.isExpanded = true,
  });

  final String label;
  final String hintText;

  final dynamic value;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic)? onChanged;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 8),
      child: DropdownButtonFormField(
        value: value,
        items: items,
        onChanged: onChanged,
        isExpanded: isExpanded,
        alignment: AlignmentDirectional.centerStart,
        decoration: InputDecoration(
          label: Text(label, style: TextStyle(fontFamily: 'Poppins')),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: SizeConfig.textMultiplier * 1.5,
          ),
          labelStyle: TextStyle(
            color: Colors.black26,
            fontFamily: 'Poppins',
            fontSize: SizeConfig.textMultiplier * 1.5,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Colors.black26,
            fontSize: SizeConfig.textMultiplier * 1.5,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 3,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.unFocusGreyClr),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.unFocusGreyClr),
          ),
        ),
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: SizeConfig.textMultiplier * 1.5,
        ),
      ),
    );
  }
}
