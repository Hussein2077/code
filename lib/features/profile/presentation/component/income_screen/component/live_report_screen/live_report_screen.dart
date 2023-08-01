import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/income_screen/component/live_report_screen/widget/info_with_container_blue.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/income_screen/component/live_report_screen/widget/live_month_card.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/income_screen/component/live_report_screen/widget/live_today_card.dart';

class LiveReportScreen extends StatefulWidget {
  const LiveReportScreen({super.key});

  @override
  State<LiveReportScreen> createState() => _LiveReportScreenState();
}

class _LiveReportScreenState extends State<LiveReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff8f8f8),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustoumCachedImage(
                height: ConfigSize.defaultSize!*30,
                url:'https://wallpaperaccess.com/full/294788.jpg',
                width:MediaQuery.of(context).size.width,
                boxFit: BoxFit.cover,
                widget: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: ConfigSize.defaultSize !*1,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              ))),

                      Column(
                        children: [
                          UserImage(
                            boxFit: BoxFit.cover,
                            image: AssetsPath.testImage,
                            imageSize: ConfigSize.defaultSize! * 10,
                          ),

                          const SizedBox(
                            height: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),

                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                Text('Ga3fr al 3omda',style:
                                TextStyle(color: Colors.white, fontSize: ConfigSize.defaultSize! *2.2,fontWeight: FontWeight.bold),),

                                /* Text(widget.ownerDataModel.name!,
                                      style:
                                      TextStyle(color: Colors.white, fontSize: ConfigSize.defaultSize! *2.2,fontWeight: FontWeight.bold)),*/
                                SizedBox(
                                  height: ConfigSize.defaultSize! *0.5,),
                                const Text('ID :183845',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration:  const BoxDecoration(

                  ///0xfff8f8f8
                    color: Color(0xfff8f8f8),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(

                    children: [
                      const InfoWithWidget(title: StringManager.today,),

                      SizedBox(height: ConfigSize.defaultSize !*3,),

                      Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: const [
                      LiveTodayCard(
                        widget: Text(
                          '5',
                          style: TextStyle(
                              color: Colors.black),
                        ),
                        title: StringManager.hours,
                      ),
                      LiveTodayCard(
                        widget:Icon(Icons.check),
                        title: StringManager.today,
                      ),
                      LiveTodayCard(
                        widget: Text(
                          '7',
                          style: TextStyle(
                              color: Colors.black),
                        ),
                        title: StringManager.diamond,
                      ),
                    ],
                  ),
                      SizedBox(height: ConfigSize.defaultSize!*2,),

                      const InfoWithWidget(title:StringManager.dataInMounth),

                      const SizedBox(height: 20,),

                      const CardInfoMonthOrAllInfo(
                        infoDay: '54',
                        infoDiamond: '44',
                        infoHours: '48',
                      ),

                      SizedBox(height: ConfigSize.defaultSize!*2,),

                      const InfoWithWidget(title: StringManager.allInformation,),

                      SizedBox(height: ConfigSize.defaultSize!*2,),
                      const CardInfoMonthOrAllInfo(
                        infoDay: '100',
                        infoDiamond: '88',
                        infoHours: '44',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
/*: Stack(
alignment: Alignment.center,
children: [
Positioned(

child: CustomAvtare(
image: widget.ownerDataModel.profile
    ?.image,
size: ConfigSize.defaultSize! *
7,
border:2,
),
),
widget.ownerDataModel.frame == ""
? SizedBox(
width: ConfigSize
    .defaultSize! *
12,
height: ConfigSize
    .defaultSize! *
12,
)
    : Positioned(
child: SizedBox(
width: ConfigSize
    .defaultSize! *
12,
height: ConfigSize
    .defaultSize! *
12,
child: ShowSVGA(
url: widget.ownerDataModel.frame!,
imageId: '${ widget.ownerDataModel.frameId}${cacheFrameKey}'),
),
),
],
),*/