import 'dart:developer';
import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/controllers/add_post.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/models/post.dart';
import 'package:mosqueconnect/services/thumbnail.dart';
import 'package:mosqueconnect/utils/file_type.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/animations/fade_in.dart';
import 'package:mosqueconnect/views/pages/add%20post/components/field.dart';
import 'package:mosqueconnect/views/widgets/choose_media_type.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key, this.post});
  final PostModel? post;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final controller = Get.put(AddPostController());
  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      controller.getData(widget.post!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => PopScope(
        canPop:
            controller.compressionProgress.value == 0 &&
            !controller.isLoading.value,
        child: Scaffold(
          appBar: CustomAppbar(
            title: widget.post != null ? "Update Post" : "Add Post",
          ),
          bottomSheet: Container(
            width: SizeConfig.widthMultiplier * 100,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 10,
                vertical: SizeConfig.heightMultiplier * 6,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //COMPRESSING PROGRESS
                  controller.compressionProgress.value != 0
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.heightMultiplier * 1,
                          ),
                          child: Text(
                            "Compressing... ${(controller.compressionProgress.value).toStringAsFixed(2)}%",
                            style: textTheme.bodySmall,
                          ),
                        )
                      : const SizedBox(),
                  //UPLOAD PROGRESS
                  controller.uploadProgress.value != 0
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.heightMultiplier * 1,
                          ),
                          child: Text(
                            "Uploading to server... ${controller.uploadProgress.value.toStringAsFixed(2)}%",
                            style: textTheme.bodySmall,
                          ),
                        )
                      : const SizedBox(),

                  CustomButton(
                    onPressed: () async {
                      if (!kDebugMode &&
                          adsController.isInterstitialAdLoaded.value) {
                        await adsController.interstitialAd.show();
                      }
                      if (widget.post != null) {
                        controller.onUpdatePost(context, widget.post!);
                      } else {
                        controller.onAddPost(context);
                      }
                    },
                    text: widget.post != null ? "Update" : "Post",
                    isLoading: controller.isLoading.value,
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.y(2),
                Row(
                  children: [
                    CircleAvatar(
                      radius: SizeConfig.widthMultiplier * 6,
                      backgroundImage: AssetImage(
                        Assets.images.onboarding.path,
                      ),
                    ),
                    Spacing.x(3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Abu Bakar Mosque",
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.3,
                          ),
                        ),

                        Spacing.y(.5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 2,
                          ),
                          child: Text(
                            "Online",
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.green,
                              fontSize: SizeConfig.textMultiplier * 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacing.y(3),

                Stack(
                  children: [
                    //TEXTFIELD
                    Padding(
                      padding: EdgeInsets.only(
                        bottom:
                            controller.postMedia.value.isNotEmpty ||
                                controller.postMediaUrl.value.isNotEmpty
                            ? 0
                            : SizeConfig.heightMultiplier * 2,
                      ),
                      child: AddPostField(),
                    ),
                    //MEDIA OPTIONS
                    Positioned(
                      bottom: 0,
                      child:
                          controller.postMedia.value.isNotEmpty ||
                              controller.postMediaUrl.value.isNotEmpty
                          ? const SizedBox()
                          : IconButton(
                              onPressed: () => Get.bottomSheet(
                                ChooseMediaType(
                                  onPhoto: () => controller.onCameraPhoto(),
                                  onVideo: () => controller.onCameraVideo(),
                                ),
                              ),
                              icon: Icon(
                                HugeIcons.strokeRoundedCamera02,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: SizeConfig.widthMultiplier * 8,
                      child:
                          controller.postMedia.value.isNotEmpty ||
                              controller.postMediaUrl.value.isNotEmpty
                          ? const SizedBox()
                          : IconButton(
                              onPressed: () => Get.bottomSheet(
                                ChooseMediaType(
                                  onPhoto: () => controller.onGalleryPhoto(),
                                  onVideo: () => controller.onGalleryVideo(),
                                ),
                              ),
                              icon: Icon(
                                HugeIcons.strokeRoundedImage01,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ],
                ),
                //FOR UPDATE POST SHOW ALREADY UPLOADED MEDIA
                if (widget.post != null &&
                    controller.postMediaUrl.value.isNotEmpty) ...[
                  !widget.post!.isVideo
                      ? FadeInWidget(
                          delay: 100,
                          child: GestureDetector(
                            onTap: () => controller.removeMedia(),
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5, top: 5),
                                  height: SizeConfig.heightMultiplier * 7,
                                  width: SizeConfig.widthMultiplier * 17,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        controller.postMediaUrl.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: _closeBtn(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : FutureBuilder(
                          future: ThumbnailService.getThumbnailFromNetwork(
                            controller.postMediaUrl.value,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                margin: EdgeInsets.only(right: 5, top: 5),
                                height: SizeConfig.heightMultiplier * 7,
                                width: SizeConfig.widthMultiplier * 17,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeCap: StrokeCap.round,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return FadeInWidget(
                              delay: 100,
                              child: GestureDetector(
                                onTap: () => controller.removeMedia(),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5, top: 5),
                                      height: SizeConfig.heightMultiplier * 7,
                                      width: SizeConfig.widthMultiplier * 17,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: MemoryImage(snapshot.data!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 5, top: 5),
                                      height: SizeConfig.heightMultiplier * 7,
                                      width: SizeConfig.widthMultiplier * 17,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: CircleAvatar(
                                          radius:
                                              SizeConfig.widthMultiplier * 3,
                                          backgroundColor: Colors.white,

                                          child: Icon(
                                            FluentIcons.play_12_filled,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: _closeBtn(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],

                if (controller.postMedia.value.isNotEmpty)
                  FileTypeUtils.isImage(controller.postMedia.value)
                      ? FadeInWidget(
                          delay: 100,
                          child: GestureDetector(
                            onTap: () => controller.removeMedia(),
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5, top: 5),
                                  height: SizeConfig.heightMultiplier * 7,
                                  width: SizeConfig.widthMultiplier * 17,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(controller.postMedia.value),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: _closeBtn(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : FutureBuilder(
                          future: ThumbnailService.getThumbnailFromFile(
                            controller.postMedia.value,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                margin: EdgeInsets.only(right: 5, top: 5),
                                height: SizeConfig.heightMultiplier * 7,
                                width: SizeConfig.widthMultiplier * 17,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeCap: StrokeCap.round,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return FadeInWidget(
                              delay: 100,
                              child: GestureDetector(
                                onTap: () => controller.removeMedia(),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5, top: 5),
                                      height: SizeConfig.heightMultiplier * 7,
                                      width: SizeConfig.widthMultiplier * 17,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: MemoryImage(snapshot.data!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 5, top: 5),
                                      height: SizeConfig.heightMultiplier * 7,
                                      width: SizeConfig.widthMultiplier * 17,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: CircleAvatar(
                                          radius:
                                              SizeConfig.widthMultiplier * 3,
                                          backgroundColor: Colors.white,

                                          child: Icon(
                                            FluentIcons.play_12_filled,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: _closeBtn(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar _closeBtn() {
    return CircleAvatar(
      radius: SizeConfig.widthMultiplier * 2,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          radius: SizeConfig.widthMultiplier * 2,
          backgroundColor: Colors.red,
          child: Icon(Icons.close, size: 12, color: Colors.white),
        ),
      ),
    );
  }
}
