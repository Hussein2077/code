import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:youtube_api/youtube_api.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({super.key, required this.youTubeVideo});
final YouTubeVideo youTubeVideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      child: Row(
        children: [
          Image.network( youTubeVideo.thumbnail.medium.url.toString()),
          // CustoumCachedImage(
          //   url: youTubeVideo.thumbnail.medium.url.toString(),
          //   height: ConfigSize.defaultSize!,
          //   width: ConfigSize.defaultSize!,
          // ),
          SizedBox(width:ConfigSize.defaultSize!*3 ,),
          Column(
            children: [
              SizedBox(
                width: ConfigSize.screenWidth!*.7,
                child: Text(
                  youTubeVideo.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(
                width: ConfigSize.screenWidth!*.7,
                child: Text(
                  youTubeVideo.description.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
