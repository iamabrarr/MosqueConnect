import 'dart:developer';

import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/controllers/home.dart';
import 'package:mosqueconnect/models/post.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/animations/popup_animation.dart';
import 'package:mosqueconnect/views/pages/add%20post/add_post.dart';
import 'package:mosqueconnect/views/pages/home/components/header.dart';
import 'package:mosqueconnect/views/pages/home/components/tile.dart';
import 'package:mosqueconnect/views/widgets/loading.dart';
import 'package:mosqueconnect/views/widgets/no_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchKey = "";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (adsController.isInterstitialAdLoaded.value) {
        adsController.interstitialAd.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection(DbCollections.mosquePosts)
              .where('createdBy', isEqualTo: authController.currentUser?.uid)
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
                  // if (!kDebugMode &&
                  //     adsController.isInterstitialAdLoaded.value) {
                  //   await adsController.interstitialAd.show();
                  // }
                  Get.to(() => AddPostScreen());
                },
                backgroundColor: AppColors.primary,
                child: Icon(HugeIcons.strokeRoundedAdd01),
              ),
            );
          },
        ),
        body: Column(
          children: [
            HomeHeader(),
            FutureBuilder(
              future: adsController.bannerAd.load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                }
                return SizedBox(
                  height: adsController.bannerAd.size.height.toDouble(),
                  width: adsController.bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: adsController.bannerAd),
                );
              },
            ),
            Spacing.y(1),
            Padding(
              padding: EdgeInsets.symmetric(
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
                  if (value.isNotEmpty) {
                    searchKey = value.toLowerCase().trim();
                  } else {
                    searchKey = "";
                  }
                  setState(() {});
                },
              ),
            ),
            Spacing.y(1),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _getMosquePostsQuery(searchKey).snapshots(),
                builder: (context, snapshot) {
                  // // Set the add button visibility based on data availability
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  //     controller.showAddButton.value = true;
                  //   } else {
                  //     controller.showAddButton.value = false;
                  //   }
                  // });
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  }
                  if (snapshot.hasError) {
                    if (kDebugMode) {
                      log(snapshot.error.toString());
                    }
                    return NoDataWidget(
                      title: "Error",
                      subtitle: "Something went wrong",
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return NoDataWidget(
                      title: "No posts yet!",
                      subtitle:
                          authController.currentUser!.role == UserRole.member
                          ? "No posts found. You'll see posts from your mosque here."
                          : "No posts found. Create a post to get started.",
                      buttonText:
                          authController.currentUser!.role == UserRole.member
                          ? null
                          : "Create Post",
                      onButtonTap:
                          authController.currentUser!.role == UserRole.member
                          ? null
                          : () async {
                              // if (!kDebugMode &&
                              //     adsController.isInterstitialAdLoaded.value) {
                              //   await adsController.interstitialAd.show();
                              // }
                              Get.to(() => AddPostScreen());
                            },
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 2,
                      left: SizeConfig.widthMultiplier * 2,
                      right: SizeConfig.widthMultiplier * 2,
                      bottom: SizeConfig.heightMultiplier * 12,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return PostTile(
                        post: PostModel.fromDocumentSnapshot(
                          snapshot.data!.docs[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Query _getMosquePostsQuery(String searchKey) {
    final isMosque = authController.currentUser!.role == UserRole.mosque;
    final uid = authController.currentUser?.uid;
    final mosqueID = authController.currentUser?.mosqueID;

    final collection = firestore.collection(DbCollections.mosquePosts);
    Query query = collection.where(
      'createdBy',
      isEqualTo: isMosque ? uid : mosqueID,
    );

    if (!isMosque) {
      query = query.where('isActive', isEqualTo: true);
    }

    if (searchKey.isNotEmpty) {
      query = query.where('searchKey', isGreaterThanOrEqualTo: searchKey);
    }

    return query.orderBy('createdAt', descending: true);
  }
}
