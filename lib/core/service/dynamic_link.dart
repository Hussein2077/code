



import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';

class DynamicLinkProvider {


  Future <String> creatLink({
    required int refCod,
    required bool password,
    required String ownerImage

  }) async{
    int isPass =0 ;
    if(password){
      isPass = 1 ;
    }
    final String url = "https://com.dragonchat.app?owner_id=$refCod&&password=$isPass";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        socialMetaTagParameters: SocialMetaTagParameters(
          description: 'I\'am playing Dragon,come and let\'s have some fun',
          title: 'Dragon Chat',
            imageUrl: Uri.parse(ConstentApi().getImage(ownerImage))
        ),
        androidParameters: const AndroidParameters(
            packageName: 'com.dragonchat.app',
            minimumVersion: 0,
        ),
        iosParameters: const IOSParameters(
          bundleId: 'com.dragonchat.app'
        ),
        uriPrefix: "https://dragonchatlive.page.link",
    );

    final FirebaseDynamicLinks links =  FirebaseDynamicLinks.instance;

    final refLink = await links.buildShortLink(parameters);



    return refLink.shortUrl.toString();

  }
}