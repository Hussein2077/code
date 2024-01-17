abstract class YoutubeEvent  {
  const YoutubeEvent();

}

class ViewYoutubeVideoEvent extends YoutubeEvent {
  final String videoId;

  const ViewYoutubeVideoEvent(this.videoId);
}
class DisposeViewYoutubeVideoEvent extends YoutubeEvent {


  const DisposeViewYoutubeVideoEvent();
}
class InitialViewYoutubeVideoEvent extends YoutubeEvent {


  const InitialViewYoutubeVideoEvent();
}