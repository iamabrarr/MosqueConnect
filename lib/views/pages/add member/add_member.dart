import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/controllers/add_member.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';
import 'package:mosqueconnect/views/widgets/custom_textfield.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final controller = Get.put(AddMemberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Add Member",
        onBack: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 10,
        ),
        child: Column(
          children: [
            Spacing.y(2),

            CustomTextField(
              label: "Email Address",
              controller: controller.emailController,
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Password",
              isPassword: true,
              controller: controller.passwordController,
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Confirm Password",
              isPassword: true,
              controller: controller.confirmPasswordController,
            ),
            Spacing.y(3),
            Obx(
              () => CustomButton(
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.onAddMember(context);
                },
                text: "Done",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
