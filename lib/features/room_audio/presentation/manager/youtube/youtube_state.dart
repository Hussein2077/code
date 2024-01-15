import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class YoutubeState  {
  const YoutubeState();

}

class YoutubeStateInitial extends YoutubeState {}

class GetViewYoutubeSuccessState extends YoutubeState {
  final YoutubePlayerController controller;

  const GetViewYoutubeSuccessState(this.controller);
}
class DisposeYoutubeSuccessState extends YoutubeState {

  const DisposeYoutubeSuccessState();
}

class YoutubeStateLoading extends YoutubeState {}
