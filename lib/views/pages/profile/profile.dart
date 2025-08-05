import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/add%20member/add_member.dart';
import 'package:mosqueconnect/views/pages/add%20post/add_post.dart';
import 'package:mosqueconnect/views/pages/edit%20profile/edit_profile.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.y(6),
          CustomAppbar(title: "Profile"),
          Spacing.y(3),
          Center(
            child: CircleAvatar(
              radius: SizeConfig.widthMultiplier * 12,
              backgroundImage: AssetImage(Assets.images.onboarding.path),
            ),
          ),
          Spacing.y(1),
          Center(
            child: Text(
              "John Doe",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall,
            ),
          ),
          Center(
            child: Text(
              "john.doe@example.com",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall!.copyWith(
                color: Colors.grey,
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
            ),
          ),
          Spacing.y(1),
          Center(
            child: CustomButton(
              onPressed: () {
                Get.to(() => const EditProfileScreen());
              },
              height: SizeConfig.heightMultiplier * 3.5,
              width: SizeConfig.widthMultiplier * 30,
              color: Colors.black,
              isShadow: false,
              fontSize: SizeConfig.textMultiplier * 1.2,
              text: "Edit Profile",
            ),
          ),
          Spacing.y(5),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 8,
            ),
            child: Text(
              "Manage Mosque",
              style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Spacing.y(2),
          ProfileOption(
            icon: HugeIcons.strokeRoundedImageAdd01,
            text: "Add Post",
            onTap: () => Get.to(() => const AddPostScreen()),
          ),
          Spacing.y(1.5),
          ProfileOption(
            icon: HugeIcons.strokeRoundedUserAdd01,
            text: "Add Members",
            onTap: () => Get.to(() => const AddMemberScreen()),
          ),
          Spacing.y(3),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 8,
            ),
            child: Text(
              "Legal & Support",
              style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Spacing.y(2),
          ProfileOption(
            icon: HugeIcons.strokeRoundedShield02,
            text: "Privacy Policy",
            onTap: () => Get.to(() => const AddPostScreen()),
          ),
          Spacing.y(1.5),
          ProfileOption(
            icon: HugeIcons.strokeRoundedDocumentValidation,
            text: "Terms & Conditions",
            onTap: () => Get.to(() => const AddMemberScreen()),
          ),
          Spacing.y(1.5),
          ProfileOption(
            icon: HugeIcons.strokeRoundedHelpSquare,
            text: "Contact Support",
            onTap: () => Get.to(() => const AddMemberScreen()),
          ),
          Spacing.y(3),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 8,
            ),
            child: Text(
              "Manage Account",
              style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Spacing.y(2),
          ProfileOption(
            icon: HugeIcons.strokeRoundedUser,
            text: "Delete Account",
            onTap: () => Get.to(() => const AddPostScreen()),
          ),
          Spacing.y(1.5),
          ProfileOption(
            icon: HugeIcons.strokeRoundedLogout01,
            text: "Logout",
            isLogout: true,
            onTap: () => Get.to(() => const AddMemberScreen()),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.isLogout = false,
  });
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 8),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            child: Icon(
              icon,
              size: 16,
              color: isLogout ? Colors.red : Colors.grey,
            ),
          ),
          Spacing.x(2),
          Text(
            text,
            style: textTheme.bodySmall!.copyWith(
              color: isLogout ? Colors.red : Colors.black,
            ),
          ),
          const Spacer(),
          Icon(HugeIcons.strokeRoundedArrowRight01, color: Colors.grey),
        ],
      ),
    );
  }
}
