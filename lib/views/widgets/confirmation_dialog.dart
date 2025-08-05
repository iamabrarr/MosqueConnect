import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/animations/popup_animation.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.confirmBtnText,
    this.confirmButtonColor,
    this.cancelButtonColor,
  });
  final Color? confirmButtonColor, cancelButtonColor;
  final String title, subtitle;
  final VoidCallback onConfirm;
  final String? confirmBtnText;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool isLoading = false;
  _loading() {
    isLoading = !isLoading;
    setState(() {});
  }

  Future<void> _onConfirm() async {
    _loading();
    widget.onConfirm();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopupAnimation(
              delay: 100,
              child: Container(
                width: SizeConfig.widthMultiplier * 80,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5,
                  vertical: SizeConfig.heightMultiplier * 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Spacing.y(1),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Spacing.y(3),

                    InkWell(
                      onTap: _onConfirm,
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: SizeConfig.heightMultiplier * 6,
                        width: SizeConfig.widthMultiplier * 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isLoading
                              ? Colors.grey.shade300
                              : widget.confirmButtonColor ?? AppColors.red,
                        ),
                        child: Center(
                          child: isLoading
                              ? Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        strokeCap: StrokeCap.round,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  widget.confirmBtnText ?? "Confirm",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                ),
                        ),
                      ),
                    ),
                    Spacing.y(1),
                    InkWell(
                      onTap: () => isLoading ? null : Get.back(),
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: SizeConfig.heightMultiplier * 6,
                        width: SizeConfig.widthMultiplier * 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
