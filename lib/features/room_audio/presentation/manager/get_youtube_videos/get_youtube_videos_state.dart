import 'package:youtube_api/youtube_api.dart';

abstract class GetYoutubeState  {
  const GetYoutubeState();

}

class GetYoutubeStateInitial extends GetYoutubeState {}
class GetYoutubeStateLoading extends GetYoutubeState {}

class GetVideosYoutubeSuccessState extends GetYoutubeState {
  final   List<YouTubeVideo> results;

  const GetVideosYoutubeSuccessState(this.results);
}