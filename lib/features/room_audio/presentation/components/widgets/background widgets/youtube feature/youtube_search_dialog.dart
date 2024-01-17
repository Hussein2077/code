import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/youtube%20feature/youtube_video_item.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/get_youtube_videos/get_youtube_videos_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/get_youtube_videos/get_youtube_videos_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/get_youtube_videos/get_youtube_videos_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_event.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeAPISearchDialog extends StatefulWidget {
  const YoutubeAPISearchDialog({
    super.key,
  });


  @override
  State<YoutubeAPISearchDialog> createState() => _YoutubeAPISearchDialogState();
}

class _YoutubeAPISearchDialogState extends State<YoutubeAPISearchDialog> {
  late TextEditingController youtubeSearchController;

  @override
  void initState() {
    youtubeSearchController = TextEditingController();
    BlocProvider.of<GetYoutubeVideosBloc>(context)
        .add(GetYoutubeVideoEvent(regionCode: "EG"));
    super.initState();
  }

  @override
  void dispose() {
    youtubeSearchController.dispose();
    super.dispose();
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ConfigSize.defaultSize! * 2),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize!)),
                  child: searchYoutubeVideoTextField(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ConfigSize.defaultSize! * 2,
                    right: ConfigSize.defaultSize! * 2,
                    top: ConfigSize.defaultSize!),
                child: info(),
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
                  child: BlocBuilder<GetYoutubeVideosBloc, GetYoutubeState>(
                builder: (context, state) {
                  if (state is GetVideosYoutubeSuccessState) {
                    return ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              String url = state.results[index].url;
                              log('${url}url');
                                BlocProvider.of<YoutubeBloc>(context)
                                    .add(const InitialViewYoutubeVideoEvent());
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                BlocProvider.of<YoutubeBloc>(context).add(
                                    ViewYoutubeVideoEvent(
                                        url ?? ""));
                                if(mounted){
                                  Navigator.pop(context);
                                }
                              });

                              Map<String,dynamic> mapZego = {
                                "messageContent" : {
                                  "message" : "cinema mode",
                                  "url": url,
                                }
                              };
                              String map = jsonEncode(mapZego);
                              ZegoUIKit.instance.sendInRoomCommand(map,[]);

                            },
                            child: Column(
                              children: [
                                VideoItem(
                                  youTubeVideo: state.results[index],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (state is GetYoutubeStateLoading) {
                    return const LoadingWidget();
                  } else {
                    return const SizedBox();
                  }
                },
              )),
            ])));
  }

  Widget info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget searchYoutubeVideoTextField() {
    return TextFieldWidget(
      hintText: StringManager.search.tr(),
      hintColor: ColorManager.gray,
      prefixIcon: Icon(
        Icons.search,
        color: ColorManager.gray,
        size: ConfigSize.defaultSize! * 2,
      ),
      controller: youtubeSearchController,
      onSubmitted: (_) async {
        BlocProvider.of<GetYoutubeVideosBloc>(context)
            .add(GetYoutubeVideoEvent(search: youtubeSearchController.text));
      },
      onChanged: (_) async {
        Future.delayed(const Duration(milliseconds: 800), () async {
          BlocProvider.of<GetYoutubeVideosBloc>(context)
              .add(GetYoutubeVideoEvent(search: youtubeSearchController.text));
        });
      },
    );
  }
}
