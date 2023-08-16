import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'voice/create_voic_live_body.dart';


class CreateLiveScreen extends StatefulWidget {

   const CreateLiveScreen({super.key});

  @override
  State<CreateLiveScreen> createState() => _CreateLiveScreenState();
}

class _CreateLiveScreenState extends State<CreateLiveScreen>
    with TickerProviderStateMixin {
  late TabController createLiveController;

  @override
  void initState() {

    createLiveController = TabController(length:1 , vsync: this);
    
    
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black ,
      body: Column(
        children: [
          Expanded(
              child: TabBarView(
            controller: createLiveController,
            children:const  [
              // CreateLiveVideoBody(),
              CreateVoiceLiveBody(),
            //  CreateReelsBody(),
            ],
          )),
          Container(
            margin: EdgeInsets.only(bottom: ConfigSize.defaultSize!*4 , left: ConfigSize.defaultSize!*15),
            width: MediaQuery.of(context).size.width/1.6,
            child: TabBar(
                indicatorColor: ColorManager.whiteColor,
                labelColor: ColorManager.whiteColor,
                unselectedLabelColor: ColorManager.whiteColor.withOpacity(0.5),
                
          
          
                indicatorPadding:
                    EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 3.5),
                controller: createLiveController,
                tabs: [
                  // Text(
                  //   "${StringManager.live}  ",
                  //   style: TextStyle(
                  //
                  //       fontSize: ConfigSize.defaultSize! * 1.7),
                  // ),
                  Text("${StringManager.voice} ",
                      style: TextStyle(
                          
                          fontSize: ConfigSize.defaultSize! * 1.7)),
                  Text("${StringManager.reels} ",
                      style: TextStyle(
                         
                          fontSize: ConfigSize.defaultSize! * 1.7)),
                ]),
          ),
        ],
      ),
    );
  }
}
