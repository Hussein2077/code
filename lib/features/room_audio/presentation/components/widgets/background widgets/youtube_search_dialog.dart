import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/youtube_video_item.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeAPISearchDialog extends StatefulWidget {
  const YoutubeAPISearchDialog({super.key, required this.controller});

  static String videoId = '';
  final YoutubePlayerController controller;

  @override
  State<YoutubeAPISearchDialog> createState() => _YoutubeAPISearchDialogState();
}

class _YoutubeAPISearchDialogState extends State<YoutubeAPISearchDialog> {
  late TextEditingController youtubeSearchController;
  static String api_key = "AIzaSyAXWdc9rrPT02_tnQrp-BN7reFAbMFTAps";
  List<YouTubeVideo> results = [];
  YoutubeAPI yt = YoutubeAPI(api_key, maxResults: 15, type: "video");
  bool isLoaded = false;

  @override
  void initState() {
    youtubeSearchController = TextEditingController();
    callApi();
    super.initState();

  }

  @override
  void dispose() {
    youtubeSearchController.dispose();
    super.dispose();
  }

  callApi() async {
    try {
      results = await yt.search("trending");
      results = await yt.getTrends( regionCode: "EG",);

      print(results[1].url.toString() + 'hhhhhhhhhhhhhhhhh');
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ConfigSize.screenHeight! * .7,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ConfigSize.defaultSize!),
                topRight: Radius.circular(ConfigSize.defaultSize!))),
        child: Padding(
            padding: EdgeInsets.all(ConfigSize.defaultSize! * 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorManager.gray,
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize!)),
                child: TextFieldWidget(
                  hintText: StringManager.search.tr(),
                  hintColor: ColorManager.lightGray,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorManager.lightGray,
                  ),
                  controller: youtubeSearchController,
                ),
              ),
              Text(
                StringManager.searchOnYouTube.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                StringManager.pressOnVideo.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                StringManager.everyOneWatchWithYou.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                StringManager.ownerOrAdminCanSwitchVideo.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: ConfigSize.defaultSize!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringManager.trendingTab.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(Icons.video_camera_back),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            VideoItem(
                              youTubeVideo: results[index],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        );
                      })),
            ])));
  }
}
