import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/splash.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatefulWidget {
  final bool isForceUpdate;

  const UpdateScreen({Key? key, required this.isForceUpdate}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1),
      ),
      child: SizedBox(
        height: ConfigSize.screenHeight! / 2.6,
        child: Padding(
          padding: EdgeInsets.only(
              top: ConfigSize.defaultSize! * 1.5,
              left: ConfigSize.defaultSize! * 4.0,
              right: ConfigSize.defaultSize! * 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.updatTikChatApp.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ConfigSize.defaultSize! * 2.0),
              ),
              SizedBox(height: ConfigSize.defaultSize! * 1.1),
              Text(
                StringManager.updateText.tr(),
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: ConfigSize.defaultSize! * 1.5),
              ),
              SizedBox(height: ConfigSize.defaultSize! * 2.1),
              Row(
                mainAxisAlignment: widget.isForceUpdate
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    color: SplashScreen.devicePlatform ==
                            StringManager.androidPlatform
                        ? const Color(0xff00845F)
                        : ColorManager.gray,
                    height: ConfigSize.defaultSize! * 4,
                    onPressed: () async {
                      String? appUrl = 'https://google.com';
                      if (Platform.isAndroid) {
                        // AndroidIntent intent = const AndroidIntent(
                        //   action: 'action_view',
                        //   data: 'https://play.google.com/store/apps/details?id=com.tikkchat.app',
                        // );
                        // await intent.launch();
                        if(await canLaunchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.tikkchat.app'))){
                           launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.tikkchat.app'));
                        }
                      } else if (Platform.isIOS) {
                        const appId = 'YOUR_IOS_APP_ID';
                        final url = Uri.parse(
                          "https://apps.apple.com/app/id$appId",
                        );
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      StringManager.update.tr(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: ConfigSize.defaultSize! * 1.4),
                    ),
                  ),
                  SizedBox(width: ConfigSize.defaultSize! * 1.8),
                  widget.isForceUpdate
                      ? const SizedBox()
                      : TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: SplashScreen.devicePlatform ==
                                    StringManager.androidPlatform
                                ? const Color(0xff00845F)
                                : ColorManager.gray,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            StringManager.no.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: ColorManager.gray,
                                    fontSize: ConfigSize.defaultSize! * 1.7,
                                    fontWeight: FontWeight.w700),
                          ),
                        )
                ],
              ),
              SizedBox(height: ConfigSize.defaultSize! * 1.1),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: ConfigSize.defaultSize! * 0.7),
              Row(
                children: [
                  SplashScreen.devicePlatform == StringManager.androidPlatform
                      ? Image.asset(
                          AssetsPath.googlePlay,
                          scale: 17,
                        )
                      : Icon(
                          Icons.apple_outlined,
                          size: ConfigSize.defaultSize! * 5,
                          color: ColorManager.gray,
                        ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: EdgeInsets.only(top: ConfigSize.defaultSize! * .5),
                    child: Text(
                      SplashScreen.devicePlatform ==
                              StringManager.androidPlatform
                          ? "Google Play"
                          : "App Store",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: ConfigSize.defaultSize! * 1.8),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
