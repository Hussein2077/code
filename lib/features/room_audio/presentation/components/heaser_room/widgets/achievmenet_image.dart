import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class AchievementCachImageWidget extends StatelessWidget {
  final String url;

  final double? width;
  final double? height;
  final Widget? errorWidget;

  final double? radius;
  final double? scale;
  final BoxFit? boxFit;

  const AchievementCachImageWidget(
      {required this.url,
          this.height,
          this.width,
        this.errorWidget,
        this.radius,
        this.boxFit,
        this.scale});

  @override
  Widget build(BuildContext context) {
     // log("url"+url);
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.cover,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          image: DecorationImage(

              image: imageProvider,
              fit: boxFit ?? BoxFit.fill),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          height: height??ConfigSize.defaultSize!*10,
          width: width??ConfigSize.defaultSize!*10,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
      errorWidget ?? const Icon(Icons.error),
    );
  }
}
