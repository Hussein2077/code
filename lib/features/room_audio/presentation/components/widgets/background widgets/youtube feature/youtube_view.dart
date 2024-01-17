import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/pod_player.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/youtube%20feature/youtube_search_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeView extends StatefulWidget {
  const YoutubeView({super.key});

  @override
  State<YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: ConfigSize.screenHeight! * .3,
        child: BlocBuilder<YoutubeBloc, YoutubeState>(
          builder: (context, state) {
            if (state is GetViewYoutubeSuccessState) {
              return PodVideoPlayer(
                  controller: state.controller,
                  );
            } else {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.arrow_upward_sharp,
                        color: ColorManager.mainColor,
                      ),
                      Text(
                        StringManager.tabToAddVideo.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize! * 5,
                      ),
                      SizedBox(
                          height: ConfigSize.defaultSize! * 10,
                          child: Image.asset(
                            AssetsPath.youtube,
                          ))
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
