import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';

class DynamicLinkProvider {
  Future<String> createInvetionRoomLink(
      {required int refCod,
      required bool password,
      required String ownerImage

  }) async{
    int isPass =0 ;
    if(password){
      isPass = 1 ;
    }
    final String url = "https://com.tikkchat.app?action=enter_room&&owner_id=$refCod&&password=$isPass";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        socialMetaTagParameters: SocialMetaTagParameters(
          description: 'I\'am playing Tik,come and let\'s have some fun',
          title: 'Tik Chat',
            imageUrl: Uri.parse(ConstentApi().getImage(ownerImage))
        ),
        androidParameters: const AndroidParameters(
            packageName: 'com.tikkchat.app',
            minimumVersion: 0,
        ),
        iosParameters: const IOSParameters(
          bundleId: 'com.tikkchat.app'
        ),
        uriPrefix: "https://tikchatlive.page.link",
    );

    final FirebaseDynamicLinks links =  FirebaseDynamicLinks.instance;

    final refLink = await links.buildShortLink(parameters);



    return refLink.shortUrl.toString();

  }


  Future <String> creatInvetaionUserLink({
    required String  userImage,
    required int userId

  }) async{

    final String url = "https://com.tikkchat.app?action=visit_user&&user_id=$userId";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(url),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: 'I\'am playing Tik,come and let\'s have some fun',
          title: 'Tik Chat',
          imageUrl: Uri.parse(ConstentApi().getImage(userImage))
      ),
      androidParameters: const AndroidParameters(
        packageName: 'com.tikkchat.app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
          bundleId: 'com.tikkchat.app'
      ),
      uriPrefix: "https://tikchatlive.page.link",
    );

    final FirebaseDynamicLinks links =  FirebaseDynamicLinks.instance;

    final refLink = await links.buildShortLink(parameters);



    return refLink.shortUrl.toString();

  }


  Future <String> showReelLink({
    required int reelId,
    required String reelImage

  }) async{

    final String url = "https://com.tikkchat.app?action=show_reel&&reel_id=$reelId&&reel_image=$reelImage";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(url),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: 'I\'am playing Tik,come and let\'s have some fun',
          title: 'Tik Chat',
          imageUrl: Uri.parse(ConstentApi().getImage(reelImage))
      ),
      androidParameters: const AndroidParameters(
        packageName: 'com.tikkchat.app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
          bundleId: 'com.tikkchat.app'
      ),
      uriPrefix: "https://tikchatlive.page.link",
    );

    final FirebaseDynamicLinks links =  FirebaseDynamicLinks.instance;

    final refLink = await links.buildShortLink(parameters);



    return refLink.shortUrl.toString();

  }


  Future <String> showMomentLink({
    required String momentId,
    required String momentImage

  }) async{
    log('kkkkkkkkkkkk${Uri.parse(ConstentApi().getImage(momentImage))}');
    final String url =
        "https://com.tikkchat.app?action=show_moment&&moment_Id=$momentId&&moment_Image=$momentImage";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(url),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: 'I\'am playing Tik,come and let\'s have some fun',
          title: 'Tik Chat',
          imageUrl: Uri.parse(ConstentApi().getImage(momentImage))),
      androidParameters: const AndroidParameters(
        packageName: 'com.tikkchat.app',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
          bundleId: 'com.tikkchat.app'
      ),
      uriPrefix: "https://tikchatlive.page.link",
    );

    final FirebaseDynamicLinks links =  FirebaseDynamicLinks.instance;

    final refLink = await links.buildShortLink(parameters);



    return refLink.shortUrl.toString();

  }
}

