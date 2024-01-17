import 'package:pod_player/pod_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class YoutubeState  {
  const YoutubeState();

}

class YoutubeStateInitial extends YoutubeState {}

class GetViewYoutubeSuccessState extends YoutubeState {
  final PodPlayerController controller;

  const GetViewYoutubeSuccessState(this.controller);
}
class DisposeYoutubeSuccessState extends YoutubeState {

  const DisposeYoutubeSuccessState();
}

class YoutubeStateLoading extends YoutubeState {}
