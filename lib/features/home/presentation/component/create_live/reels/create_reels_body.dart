

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/video/create_video_live_body.dart';

class CreateReelsBody extends StatefulWidget {
  const CreateReelsBody({super.key});

  @override
  State<CreateReelsBody> createState() => _CreateReelsBodyState();
}

class _CreateReelsBodyState extends State<CreateReelsBody> {
    late CameraController reelsController;
      int direction = 1;
  @override
  void initState() {
    reelsController = CameraController(
      CreateLiveVideoBody.cameras[direction],
      ResolutionPreset.max,
    );
    reelsController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
              CameraPreview(reelsController),
              Column(children: [
                SizedBox(height: ConfigSize.defaultSize!*3.5,),

                reelsHeader(context: context),
                   Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: ConfigSize.defaultSize! * 2 , top: ConfigSize.defaultSize!*40),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            direction = direction == 0 ? 1 : 0;
                            reelsController.setDescription(
                                CreateLiveVideoBody.cameras[direction]);
                          });
                        },
                        child: livesButtons(
                            icon: AssetsPath.flipIcon,
                            title: StringManager.flip),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize! * 2,
                      ),
                      livesButtons(
                          icon: AssetsPath.filtterIcon,
                          title: StringManager.fillter),
                           SizedBox(
                        height: ConfigSize.defaultSize! * 2,
                      ),
                      livesButtons(
                          icon: AssetsPath.uploadIcon,
                          title: StringManager.upload),
                          

                    ],
                  )),
            ),
            const Spacer(),
                                      MainButton(onTap: (){
                                        Navigator.pushNamed(context, Routes.uploadReels);
                                      } ,title: StringManager.record , buttonColornotList: ColorManager.darkPink, ),
                                      SizedBox(height: ConfigSize.defaultSize!*3,)

              ],),





    ],);
  }
}


Widget reelsHeader ({required BuildContext context}){
  return Row(children: [
    SizedBox(width: ConfigSize.defaultSize!,),
    IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.close , color: Colors.white , size: ConfigSize.defaultSize!*4,)),

  ],);
}