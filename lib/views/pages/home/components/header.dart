import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/data.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Container(
          height: SizeConfig.heightMultiplier * 23,
          width: SizeConfig.widthMultiplier * 100,
          margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 7),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
          ),
        ),
        Positioned(
          left: SizeConfig.widthMultiplier * 6,
          right: SizeConfig.widthMultiplier * 6,
          bottom: SizeConfig.heightMultiplier * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreetingWithEmoji(),
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacing.y(.5),
              SizedBox(
                width: SizeConfig.widthMultiplier * 70,
                child: Text(
                  "Stay connected with your masjid anytime, anywhere.",
                  style: textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
              ),
              Spacing.y(3),
              Center(
                child: Container(
                  height: SizeConfig.heightMultiplier * 10,
                  width: SizeConfig.widthMultiplier * 85,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 3,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: SizeConfig.heightMultiplier * 6,
                        width: SizeConfig.widthMultiplier * 14,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            Assets.icons.appLogoWithoutText.path,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacing.x(3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat(
                                'dd MMM, yyyy hh:mm a',
                              ).format(DateTime.now()),
                              style: textTheme.bodySmall!.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            Obx(
                              () => Text(
                                authController.currentUser?.name ??
                                    'Unknown User',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
