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

class ChooseMediaType extends StatelessWidget {
  const ChooseMediaType({
    super.key,
    required this.onPhoto,
    required this.onVideo,
  });
  final VoidCallback onPhoto;
  final VoidCallback onVideo;
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
                        "Choose Type",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Spacing.y(4),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onPhoto,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: SizeConfig.widthMultiplier * 6,
                                  backgroundColor: Colors.orangeAccent,
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
                                  "Photo",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Spacing.x(6),
                          GestureDetector(
                            onTap: onVideo,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: SizeConfig.widthMultiplier * 6,
                                  backgroundColor: Colors.purpleAccent,
                                  child: Icon(
                                    FluentIcons.video_16_filled,
                                    size: 30,
                                    color: context.isDarkMode
                                        ? Colors.grey.shade900
                                        : Colors.white,
                                  ),
                                ),
                                Spacing.y(1),
                                Text(
                                  "Video",
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
}
