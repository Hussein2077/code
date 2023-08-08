import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';


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
              top: ConfigSize.defaultSize! * 4.0,
              left: ConfigSize.defaultSize! * 4.0,
              right: ConfigSize.defaultSize! * 4.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( StringManager.updateApp.tr() ,style: Theme.of(context).textTheme.bodyLarge,),
              SizedBox(height: ConfigSize.defaultSize! * 2.1),
              Text( StringManager.updateText.tr() ,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.grey.shade600,fontSize: ConfigSize.defaultSize! * 1.6 ),),

              SizedBox(height: ConfigSize.defaultSize! * 2.1),
              Row(
                mainAxisAlignment: widget.isForceUpdate?MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    color: const Color(0xff00845F),
                    height: ConfigSize.defaultSize! * 4,
                    onPressed: () async {
                      String? appUrl = 'https://google.com';
                      if (Platform.isAndroid) {
                        //todo change this url
                        appUrl =
                            'https://play.google.com/store/apps/details?id=com.tikkchat.app';
                      } else if (Platform.isIOS) {
                        appUrl = '';
                      }
                      if (await canLaunchUrlString(appUrl)) {
                        launchUrlString(appUrl);
                      } else {
                        // ignore: use_build_context_synchronously
                        errorToast(context: context, title: StringManager.unexcepectedError.tr());
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Text( StringManager.updateText.tr() ,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.white,fontSize: ConfigSize.defaultSize! * 1.4 ),),
                  ),
                  SizedBox(width: ConfigSize.defaultSize! * 1.8),
            widget.isForceUpdate ?  const SizedBox():
            TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: const Color(0xff00845F)),
                    onPressed: () {
                        Navigator.pop(context);
                    },
                    child:Text( StringManager.updateText.tr() ,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:const Color(0xff00845F),
                          fontSize: ConfigSize.defaultSize! * 1.7 ),),


                  )
                ],
              ),
              SizedBox(height: ConfigSize.defaultSize! * 1.1),
              const Divider(
                thickness: 1,
              ),
              SizedBox(height: ConfigSize.defaultSize! * 1.3),
              Row(
                children: [
                  Image.asset(
                    AssetsPath.googlePlay,
                    scale: 18,
                  ),
                  const SizedBox(width: 8),
                  Text("Google Play",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.grey.shade600,fontSize: ConfigSize.defaultSize! * 1.8 ),)

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
