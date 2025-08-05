import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/controllers/bottom_nav_bar.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/home/home.dart';
import 'package:mosqueconnect/views/pages/members/members.dart';
import 'package:mosqueconnect/views/pages/profile/profile.dart';
import 'package:mosqueconnect/views/widgets/loading.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

List<Widget> _mosqueBottomNavBarItems = [
  HomeScreen(),
  MembersScreen(),
  ProfileScreen(),
];

List<Widget> _memberbottomNavBarItems = [HomeScreen(), ProfileScreen()];

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavBarController());
    return Obx(
      () => Scaffold(
        bottomNavigationBar: ShowLoading(
          inAsyncCall: false,
          child: Scaffold(
            body: authController.currentUser?.role == UserRole.member
                ? _memberbottomNavBarItems[controller.selectedIndex.value]
                : _mosqueBottomNavBarItems[controller.selectedIndex.value],
            bottomNavigationBar: Container(
              height: SizeConfig.heightMultiplier * 11,
              color: Colors.white,
              child: Column(
                children: [
                  Divider(color: Colors.grey.shade200),
                  Spacing.y(1),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 10,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          authController.currentUser?.role == UserRole.member
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.spaceBetween,
                      children:
                          authController.currentUser?.role == UserRole.member
                          ? [
                              _bnbItem(
                                () {
                                  controller.selectedIndex.value = 0;
                                },
                                PhosphorIcon(
                                  PhosphorIcons.house(
                                    controller.selectedIndex.value == 0
                                        ? PhosphorIconsStyle.fill
                                        : PhosphorIconsStyle.regular,
                                  ),

                                  color: controller.selectedIndex.value == 0
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                ),
                                "Home",
                                controller.selectedIndex.value == 0,
                              ),
                              _bnbItem(
                                () {
                                  controller.selectedIndex.value = 1;
                                },
                                PhosphorIcon(
                                  PhosphorIcons.user(
                                    controller.selectedIndex.value == 1
                                        ? PhosphorIconsStyle.fill
                                        : PhosphorIconsStyle.regular,
                                  ),
                                  color: controller.selectedIndex.value == 1
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                ),
                                "Profile",
                                controller.selectedIndex.value == 1,
                              ),
                            ]
                          : [
                              _bnbItem(
                                () {
                                  controller.selectedIndex.value = 0;
                                },
                                PhosphorIcon(
                                  PhosphorIcons.house(
                                    controller.selectedIndex.value == 0
                                        ? PhosphorIconsStyle.fill
                                        : PhosphorIconsStyle.regular,
                                  ),

                                  color: controller.selectedIndex.value == 0
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                ),
                                "Home",
                                controller.selectedIndex.value == 0,
                              ),
                              _bnbItem(
                                () {
                                  controller.selectedIndex.value = 1;
                                },
                                PhosphorIcon(
                                  PhosphorIcons.person(
                                    controller.selectedIndex.value == 1
                                        ? PhosphorIconsStyle.fill
                                        : PhosphorIconsStyle.regular,
                                  ),
                                  color: controller.selectedIndex.value == 1
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                ),
                                "Members",
                                controller.selectedIndex.value == 1,
                              ),
                              _bnbItem(
                                () {
                                  controller.selectedIndex.value = 2;
                                },
                                PhosphorIcon(
                                  PhosphorIcons.user(
                                    controller.selectedIndex.value == 2
                                        ? PhosphorIconsStyle.fill
                                        : PhosphorIconsStyle.regular,
                                  ),
                                  color: controller.selectedIndex.value == 2
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                ),
                                "Profile",
                                controller.selectedIndex.value == 2,
                              ),
                            ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bnbItem(
    VoidCallback onTap,
    Widget icon,
    String title,
    bool isSelected,
  ) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: SizeConfig.widthMultiplier * 18,
        child: Column(
          children: [
            icon,
            Spacing.y(.5),
            Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 1.1,
                color: isSelected ? AppColors.primary : Colors.grey.shade400,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
