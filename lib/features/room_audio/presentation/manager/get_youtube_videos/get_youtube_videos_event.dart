abstract class GetYoutubeEvent  {
  const GetYoutubeEvent();

}

class GetYoutubeVideoEvent extends GetYoutubeEvent {
final String search;
final String regionCode;
GetYoutubeVideoEvent({  this.search='',this.regionCode='EG'});

}
