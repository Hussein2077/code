abstract class YoutubeEvent  {
  const YoutubeEvent();

}

class ViewYoutubeVideo extends YoutubeEvent {
  final String videoId;

  const ViewYoutubeVideo(this.videoId);
}
class DisposeViewYoutubeVideo extends YoutubeEvent {


  const DisposeViewYoutubeVideo();
}