import 'dart:ui';

import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/controllers/home.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/models/post.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/services/thumbnail.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/animations/fade_in.dart';
import 'package:mosqueconnect/views/pages/add%20post/add_post.dart';
import 'package:mosqueconnect/views/pages/photo%20viewer/photo_viewer.dart';
import 'package:mosqueconnect/views/pages/video%20player/video_player.dart';
import 'package:mosqueconnect/views/widgets/confirmation_dialog.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostTile extends StatefulWidget {
  const PostTile({super.key, required this.post});
  final PostModel post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final controller = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => controller.addViewer(widget.post));
  }

  @override
  Widget build(BuildContext context) {
    bool isMember = authController.currentUser?.role == UserRole.member;
    final textTheme = Theme.of(context).textTheme;
    return Container(
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
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
            child: Row(
              children: [
                CircleAvatar(
                  radius: SizeConfig.widthMultiplier * 5,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(
                    authController.userMosque!.mosqueImage ?? "",
                  ),
                ),
                Spacing.x(2),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authController.userMosque?.name ?? "Unknown User",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.3,
                        ),
                      ),
                      Text(
                        timeago.format(widget.post.createdAt),
                        style: textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                          fontSize: SizeConfig.textMultiplier * 1.1,
                        ),
                      ),
                      isMember ? const SizedBox() : Spacing.y(.5),
                      isMember
                          ? const SizedBox()
                          : Row(
                              children: [
                                //STATUS
                                Container(
                                  decoration: BoxDecoration(
                                    color: widget.post.isActive
                                        ? Colors.green.withValues(alpha: .15)
                                        : Colors.red.withValues(alpha: .15),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 2,
                                  ),
                                  child: Text(
                                    widget.post.isActive
                                        ? "Active"
                                        : "Inactive",
                                    style: textTheme.bodySmall!.copyWith(
                                      color: widget.post.isActive
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: SizeConfig.textMultiplier * 1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacing.x(1),
                                //VIEWS
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary.withValues(
                                      alpha: .15,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 2,
                                  ),
                                  child: Text(
                                    widget.post.viewers.length < 2
                                        ? "${widget.post.viewers.length} viewer"
                                        : "${widget.post.viewers.length} viewers",
                                    style: textTheme.bodySmall!.copyWith(
                                      color: AppColors.secondary,
                                      fontSize: SizeConfig.textMultiplier * 1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                const Spacer(),
                isMember
                    ? const SizedBox()
                    : Transform.scale(
                        scale: .6,
                        child: CupertinoSwitch(
                          value: widget.post.isActive,
                          onChanged: (value) {
                            controller.changeStatusPost(
                              context,
                              widget.post.id,
                              widget.post.isActive,
                            );
                          },
                        ),
                      ),
                isMember
                    ? const SizedBox()
                    : PopupMenuButton(
                        elevation: 1,
                        icon: Icon(
                          Icons.more_horiz_rounded,
                          color: Colors.grey.shade700,
                        ),
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
                                    style: textTheme.bodySmall!.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                        onSelected: (val) {
                          if (val == 0) {
                            Get.to(() => AddPostScreen(post: widget.post));
                          } else if (val == 1) {
                            Get.dialog(
                              ConfirmationDialog(
                                title: "Delete Post!",
                                subtitle:
                                    "Are you sure you want to delete this post? This action cannot be undone.",
                                onConfirm: () {
                                  controller.deletePost(
                                    context,
                                    widget.post.id,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
              ],
            ),
          ),
          Spacing.y(1),
          widget.post.description.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier * 4,
                    right: SizeConfig.widthMultiplier * 4,
                    bottom: SizeConfig.heightMultiplier * 1,
                  ),
                  child: AnimatedReadMoreText(
                    widget.post.description,
                    maxLines: 2,
                    readMoreText: 'Read More',
                    readLessText: 'Read Less',

                    textStyle: textTheme.bodySmall!.copyWith(
                      fontSize: SizeConfig.textMultiplier * 1.4,
                    ),
                    buttonTextStyle: textTheme.bodySmall!.copyWith(
                      fontSize: SizeConfig.textMultiplier * 1.4,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          widget.post.mediaUrl != null && widget.post.mediaUrl!.isNotEmpty
              ? Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: widget.post.isVideo
                        ? FutureBuilder(
                            future: ThumbnailService.getThumbnailFromNetwork(
                              widget.post.mediaUrl!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  height: SizeConfig.heightMultiplier * 20,
                                  width: SizeConfig.widthMultiplier * 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
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
                                  onTap: () => Get.to(
                                    () => VideoPlayerScreen(
                                      videoUrl: widget.post.mediaUrl!,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.memory(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                        height:
                                            SizeConfig.heightMultiplier * 20,
                                        width: SizeConfig.widthMultiplier * 80,
                                      ),
                                      Positioned(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            FluentIcons.play_12_filled,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : GestureDetector(
                            onTap: () => Get.to(
                              () => PhotoViewerScreen(
                                photoUrl: widget.post.mediaUrl!,
                              ),
                            ),
                            child: Image.network(
                              widget.post.mediaUrl!,
                              fit: BoxFit.cover,
                              height: SizeConfig.heightMultiplier * 20,
                              width: SizeConfig.widthMultiplier * 80,
                            ),
                          ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
