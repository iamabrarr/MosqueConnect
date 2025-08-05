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
  const AddMemberScreen({super.key, this.user});
  final UserModel? user;

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final controller = Get.put(AddMemberController());

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      controller.getData(widget.user!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.user != null ? "Update Member" : "Add Member",
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
              label: "Full Name",
              controller: controller.nameController,
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Email Address",
              controller: controller.emailController,
              suffix: widget.user == null
                  ? null
                  : Icon(FluentIcons.lock_closed_16_filled, size: 18),
            ),
            Spacing.y(2),
            widget.user != null
                ? SizedBox()
                : CustomTextField(
                    label: "Password",
                    isPassword: true,
                    controller: controller.passwordController,
                  ),
            widget.user != null ? SizedBox() : Spacing.y(2),
            widget.user != null
                ? SizedBox()
                : CustomTextField(
                    label: "Confirm Password",
                    isPassword: true,
                    controller: controller.confirmPasswordController,
                  ),
            Spacing.y(3),
            Obx(
              () => CustomButton(
                isLoading: controller.isLoading.value,
                onPressed: () {
                  if (widget.user != null) {
                    controller.onUpdateMember(context, widget.user!);
                  } else {
                    controller.onAddMember(context);
                  }
                },
                text: widget.user != null ? "Update" : "Done",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
