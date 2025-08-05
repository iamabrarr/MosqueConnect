import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/controllers/bottom_nav_bar.dart';
import 'package:mosqueconnect/controllers/members.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/animations/popup_animation.dart';
import 'package:mosqueconnect/views/pages/add%20member/add_member.dart';
import 'package:mosqueconnect/views/pages/members/components/tile.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/loading.dart';
import 'package:mosqueconnect/views/widgets/no_data.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final controller = Get.put(MembersController());
  String searchKey = "";
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection(DbCollections.users)
            .where('mosqueID', isEqualTo: authController.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return SizedBox();
          }
          if (snapshot.data!.docs.isEmpty) {
            return SizedBox();
          }
          return PopupAnimation(
            delay: 100,
            child: FloatingActionButton(
              onPressed: () async {
                if (adsController.isInterstitialAdLoaded.value) {
                  await adsController.interstitialAd.show();
                }
                Get.to(() => AddMemberScreen());
              },
              backgroundColor: AppColors.primary,
              child: Icon(HugeIcons.strokeRoundedAdd01),
            ),
          );
        },
      ),

      body: Column(
        children: [
          Spacing.y(6),
          CustomAppbar(
            title: "Members",
            onBack: () =>
                Get.find<BottomNavBarController>().selectedIndex.value--,
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 1,
              horizontal: SizeConfig.widthMultiplier * 6,
            ),
            child: CupertinoSearchTextField(
              style: textTheme.bodyMedium,
              placeholder: "Search",
              prefixIcon: Icon(HugeIcons.strokeRoundedSearch01),
              placeholderStyle: textTheme.bodyMedium!.copyWith(
                color: Colors.grey,
              ),
              onChanged: (value) {
                setState(() {
                  searchKey = value;
                });
              },
            ),
          ),
          Spacing.y(1),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchKey.isNotEmpty
                  ? firestore
                        .collection(DbCollections.users)
                        .where(
                          'mosqueID',
                          isEqualTo: authController.currentUser?.uid,
                        )
                        .where('searchKey', isGreaterThanOrEqualTo: searchKey)
                        .snapshots()
                  : firestore
                        .collection(DbCollections.users)
                        .where(
                          'mosqueID',
                          isEqualTo: authController.currentUser?.uid,
                        )
                        .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (snapshot.hasError) {
                  return NoDataWidget(
                    title: "Error",
                    subtitle: "Something went wrong",
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return NoDataWidget(
                    title: "No members",
                    subtitle:
                        "No members found. Create a member to get started.",
                    buttonText: "Create Member",
                    buttonWidth: SizeConfig.widthMultiplier * 35,
                    onButtonTap: () async {
                      if (adsController.isInterstitialAdLoaded.value) {
                        await adsController.interstitialAd.show();
                      }
                      Get.to(() => AddMemberScreen());
                    },
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 6,
                  ),
                  itemBuilder: (context, index) => MemberTile(
                    index: index,
                    user: UserModel.fromDocumentSnapshot(
                      snapshot.data!.docs[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
