import 'package:flutter/material.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onButtonTap,
    this.buttonWidth,
    this.height,
    this.buttonText,
  });
  final String title;
  final String subtitle;
  final double? height;
  final double? buttonWidth;
  final VoidCallback? onButtonTap;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    final bool isButton = buttonText != null;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height ?? SizeConfig.heightMultiplier * 60,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.noData.path,
              height: SizeConfig.heightMultiplier * 15,
            ),
            Text(
              title,
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
            Spacing.y(.5),
            Text(subtitle, style: textTheme.bodySmall),
            isButton
                ? Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 2,
                    ),
                    child: CustomButton(
                      onPressed: onButtonTap ?? () {},
                      height: SizeConfig.heightMultiplier * 4,
                      width: buttonWidth ?? SizeConfig.widthMultiplier * 32,
                      text: buttonText!,
                      isShadow: false,
                      color: Colors.black,
                      fontSize: SizeConfig.textMultiplier * 1.5,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
