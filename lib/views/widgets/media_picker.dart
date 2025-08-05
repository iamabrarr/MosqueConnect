import 'dart:developer';
import 'dart:ui';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/animations/popup_animation.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class MediaPicker extends StatelessWidget {
  const MediaPicker({super.key, this.isAllMedia = false});
  final bool isAllMedia;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(color: Colors.transparent),
        ),
        Positioned(
          bottom: SizeConfig.heightMultiplier * 2,
          child: PopupAnimation(
            delay: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // height: SizeConfig.heightMultiplier * 20,
                  width: SizeConfig.widthMultiplier * 90,
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 2.5,
                    horizontal: SizeConfig.widthMultiplier * 5,
                  ),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 5,
                    vertical: SizeConfig.heightMultiplier * 2.5,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Choose Media",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Spacing.y(4),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                _pickImage(context, ImageSource.camera),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: SizeConfig.widthMultiplier * 6,
                                  backgroundColor: Colors.orangeAccent,
                                  child: Icon(
                                    FluentIcons.camera_16_filled,
                                    size: 30,
                                    color: context.isDarkMode
                                        ? Colors.grey.shade900
                                        : Colors.white,
                                  ),
                                ),
                                Spacing.y(1),
                                Text(
                                  "Camera",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Spacing.x(6),
                          GestureDetector(
                            onTap: () =>
                                _pickImage(context, ImageSource.gallery),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: SizeConfig.widthMultiplier * 6,
                                  backgroundColor: Colors.purpleAccent,
                                  child: Icon(
                                    FluentIcons.image_16_filled,
                                    size: 30,
                                    color: context.isDarkMode
                                        ? Colors.grey.shade900
                                        : Colors.white,
                                  ),
                                ),
                                Spacing.y(1),
                                Text(
                                  "Gallery",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacing.y(2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _pickImage(BuildContext context, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final img = await picker.pickImage(source: source, imageQuality: 20);
      if (img != null) {
        Get.back(result: img.path);
      }
    } catch (e) {
      log(e.toString());
      showCustomSnackbar(context, true, "Something went wrong");
    }
  }
}
