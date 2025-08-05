import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosqueconnect/utils/size_config.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    this.borderRadius,
    required this.url,
    this.isCircle = false,
    this.radius,
  });

  final BorderRadiusGeometry? borderRadius;
  final bool isCircle;
  final String url;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        imageBuilder: isCircle
            ? (context, imageProvider) => CircleAvatar(
                radius: radius ?? SizeConfig.imageSizeMultiplier * 6,
                backgroundImage: imageProvider,
              )
            : null,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
