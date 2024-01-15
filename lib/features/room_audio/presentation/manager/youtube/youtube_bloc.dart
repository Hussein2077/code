import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  late YoutubePlayerController controller;

  YoutubeBloc() : super(YoutubeStateInitial()) {
    on<ViewYoutubeVideo>((event, emit) {
      emit(YoutubeStateLoading());

      controller = YoutubePlayerController(
          initialVideoId: event.videoId,
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ));

      emit(GetViewYoutubeSuccessState(controller));
    });
    on<DisposeViewYoutubeVideo>((event, emit) {
      emit(YoutubeStateLoading());

      controller.dispose();

      emit(const DisposeYoutubeSuccessState());
    });
  }
}
