import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';
import 'package:mosqueconnect/views/widgets/custom_textfield.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Add Member"),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 10,
        ),
        child: Column(
          children: [
            Spacing.y(2),
            CustomTextField(
              label: "Full Name",
              controller: TextEditingController(),
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Email Address",
              controller: TextEditingController(),
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Confirm Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            Spacing.y(3),
            CustomButton(onPressed: () {}, text: "Done"),
          ],
        ),
      ),
    );
  }
}
