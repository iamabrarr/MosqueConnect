import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/data.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/add%20post/add_post.dart';
import 'package:mosqueconnect/views/pages/home/components/header.dart';
import 'package:mosqueconnect/views/pages/home/components/tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => AddPostScreen()),
          backgroundColor: AppColors.primary,
          child: Icon(HugeIcons.strokeRoundedAdd01),
        ),
        body: Column(
          children: [
            HomeHeader(),
            Spacing.y(1),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 6,
              ),
              child: CupertinoSearchTextField(
                style: textTheme.bodyMedium,
                placeholder: "Search",
                prefixIcon: Icon(HugeIcons.strokeRoundedSearch01),
                placeholderStyle: textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
                onChanged: (value) {},
              ),
            ),
            Spacing.y(1),

            Expanded(
              child: ListView.builder(
                itemCount: 12,
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2,
                  horizontal: SizeConfig.widthMultiplier * 6,
                ),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return PostTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
