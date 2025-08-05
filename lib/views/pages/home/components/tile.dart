import 'dart:ui';

import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: .05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(26),
      ),
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
            child: Row(
              children: [
                CircleAvatar(
                  radius: SizeConfig.widthMultiplier * 5,
                  backgroundImage: AssetImage(Assets.images.onboarding.path),
                ),
                Spacing.x(2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Abu Bakar Mosque",
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.3,
                      ),
                    ),
                    Text(
                      "9 minutes ago",
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                        fontSize: SizeConfig.textMultiplier * 1.1,
                      ),
                    ),
                    Spacing.y(.5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2,
                      ),
                      child: Text(
                        "Active",
                        style: textTheme.bodySmall!.copyWith(
                          color: Colors.green,
                          fontSize: SizeConfig.textMultiplier * 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Transform.scale(
                  scale: .6,
                  child: CupertinoSwitch(value: true, onChanged: (value) {}),
                ),
                PopupMenuButton(
                  elevation: 1,
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.grey.shade700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: AppColors.primary),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedEdit02, size: 16),
                            Spacing.x(3),
                            Text("Edit", style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedDelete02,
                              size: 16,
                              color: Colors.red,
                            ),
                            Spacing.x(3),
                            Text(
                              "Delete",
                              style: textTheme.bodySmall!.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          Spacing.y(1),
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 4,
              right: SizeConfig.widthMultiplier * 4,
              bottom: SizeConfig.heightMultiplier * 1,
            ),
            child: AnimatedReadMoreText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. I'm good boy",
              maxLines: 2,
              readMoreText: 'Read More',
              readLessText: 'Read Less',

              textStyle: textTheme.bodySmall!.copyWith(
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
              buttonTextStyle: textTheme.bodySmall!.copyWith(
                fontSize: SizeConfig.textMultiplier * 1.1,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              "https://imgs.search.brave.com/aDomXpa2pRRKibUdi5U5weWjA9mvsh-jYTYTlC-6I3Y/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTI4/NjIyNTMxMS9waG90/by90b3dlci1vZi1u/YWJhd2ktbW9zcXVl/LW1lZGluYS1zYXVk/aS1hcmFiaWEuanBn/P3M9NjEyeDYxMiZ3/PTAmaz0yMCZjPWxR/ek05bjNFZUpHMlVE/R3A1bkhveHNTdGhC/akg0cndzOUFpZGtv/clRuTWc9",
              fit: BoxFit.cover,
              height: SizeConfig.heightMultiplier * 20,
              width: SizeConfig.widthMultiplier * 80,
            ),
          ),
        ],
      ),
    );
  }
}
