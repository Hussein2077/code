import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/pod_player.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  late PodPlayerController controller;

  YoutubeBloc() : super(YoutubeStateInitial()) {
    on<ViewYoutubeVideoEvent>((event, emit) {
      emit(YoutubeStateLoading());
      controller = PodPlayerController(
          playVideoFrom: PlayVideoFrom.youtube(
              'https://www.youtube.com/watch?v=kWd2bAif3YY',
              live: true),
          podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [720, 360],
          ))
        ..initialise();

      emit(GetViewYoutubeSuccessState(controller));
    });
    on<DisposeViewYoutubeVideoEvent>((event, emit) {
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('', live: true),
      );

      controller.dispose();

      emit(const DisposeYoutubeSuccessState());
    });
    on<InitialViewYoutubeVideoEvent>((event, emit) {
      emit(YoutubeStateInitial());
    });
  }
}
