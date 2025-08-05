import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.onBack, this.title, this.actions});
  final VoidCallback? onBack;
  final String? title;
  final List<Widget>? actions;
  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.heightMultiplier * 5);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: Colors.black,
      leading: Padding(
        padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
        child: IconButton(
          onPressed: onBack ?? () => Get.back(),
          icon: Icon(HugeIcons.strokeRoundedArrowLeft02),
        ),
      ),
      centerTitle: true,
      title: Text(
        title ?? "",
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
      ),
      actions: actions,
    );
  }
}
