import 'package:flutter/material.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/views/widgets/network_image.dart';

class UserPhotoPlaceHolder extends StatelessWidget {
  const UserPhotoPlaceHolder({
    super.key,
    required this.url,
    this.radius,
    this.iconSize,
  });
  final String? url;
  final double? radius;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return url == null || url == ''
        ? CircleAvatar(
            radius: radius ?? SizeConfig.imageSizeMultiplier * 6,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              Icons.person,
              size: iconSize ?? 30,
              color: Colors.grey.shade600,
            ),
          )
        : CircleAvatar(
            radius: radius ?? SizeConfig.imageSizeMultiplier * 6,
            backgroundColor: Colors.grey.shade300,
            child: NetworkImageWidget(
              url: url!,
              isCircle: true,
              radius: radius ?? SizeConfig.imageSizeMultiplier * 6,
            ),
          );
  }
}
