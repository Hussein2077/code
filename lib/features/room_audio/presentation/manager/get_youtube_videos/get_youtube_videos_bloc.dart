import 'package:bloc/bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:youtube_api/youtube_api.dart';

import 'get_youtube_videos_event.dart';
import 'get_youtube_videos_state.dart';

class GetYoutubeVideosBloc extends Bloc<GetYoutubeEvent, GetYoutubeState> {
  GetYoutubeVideosBloc() : super(GetYoutubeStateInitial()) {
    on<GetYoutubeVideoEvent>((event, emit) async {
      emit(GetYoutubeStateLoading());
      YoutubeAPI yt =
          YoutubeAPI(ConstentApi.youtubeApiKey, maxResults: 37, type: "video");
      List<YouTubeVideo> results = [];
      emit(GetYoutubeStateLoading());
      if (event.search == '') {
        results = await yt.getTrends(
          regionCode: event.regionCode,
        );
      } else {
        results = await yt.search(event.search);
      }
      emit(GetVideosYoutubeSuccessState(results));
    });
  }
}
