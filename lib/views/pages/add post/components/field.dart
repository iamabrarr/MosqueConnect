import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/controllers/add_post.dart';
import 'package:mosqueconnect/utils/size_config.dart';

class AddPostField extends StatelessWidget {
  const AddPostField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPostController>();
    final textTheme = Theme.of(context).textTheme;
    return TextField(
      controller: controller.postDescription,
      maxLength: 3000,
      maxLines: null,
      minLines: 5,
      autofocus: true,
      style: textTheme.bodySmall,
      decoration: InputDecoration(
        counterStyle: textTheme.bodySmall!.copyWith(
          fontSize: SizeConfig.textMultiplier * 1.2,
          color: Colors.grey,
        ),
        label: Text("Description"),

        alignLabelWithHint: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Write something...",

        hintStyle: textTheme.bodySmall!.copyWith(color: Colors.grey),
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
    );
  }
}
