import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/controllers/add_member.dart';
import 'package:mosqueconnect/controllers/members.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/add%20member/add_member.dart';
import 'package:mosqueconnect/views/widgets/confirmation_dialog.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({super.key, required this.index, required this.user});
  final int index;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MembersController>();
    final textTheme = Theme.of(context).textTheme;
    final color = AppColors.randomColors[index % AppColors.randomColors.length];
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      width: SizeConfig.widthMultiplier * 100,
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
        vertical: SizeConfig.heightMultiplier * 1.5,
        horizontal: SizeConfig.widthMultiplier * 4,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: .2),
            child: Icon(FluentIcons.person_12_filled, color: color),
          ),
          Spacing.x(3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall,
                ),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey,
                    fontSize: SizeConfig.textMultiplier * 1.2,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            elevation: 1,
            icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade700),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: AppColors.primary),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(HugeIcons.strokeRoundedEdit02, size: 16),
                      Spacing.x(3),
                      Text("Edit", style: textTheme.bodySmall),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
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
                        style: textTheme.bodySmall!.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (val) {
              if (val == 0) {
                Get.to(() => AddMemberScreen(user: user));
              } else if (val == 1) {
                Get.dialog(
                  ConfirmationDialog(
                    title: "Delete Member",
                    subtitle:
                        "Are you sure you want to delete this member? This action cannot be undone.",
                    onConfirm: () {
                      controller.deleteMember(context, user.uid);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
