import 'package:pod_player/pod_player.dart';

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
