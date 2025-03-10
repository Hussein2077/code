// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/enter_password_dialog_room.dart';
import 'package:url_launcher/url_launcher.dart';


class PageViewWidget extends StatefulWidget {
  final List<CarouselsModel> carouselsList;

  const PageViewWidget({required this.carouselsList, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
 late  List<Widget> pages ; 
  @override
  void initState() {


    pages = [
    for(int i = 0 ; i < widget.carouselsList.length ;i++ )

    InkWell(
      onTap: () async {
        if( widget.carouselsList[i].url!="") {
          try {
           await launchUrl(Uri.parse(widget.carouselsList[i].url)) ;

          } catch (e) {
            errorToast(context: context, title: StringManager.errorInUrl.tr()) ;
            if(kDebugMode){
              log(e.toString());
            }
          }

        }
        else if(widget.carouselsList[i].ownerId!=0){

          if (widget.carouselsList[i].hasPassword) {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.symmetric(
                        horizontal: ConfigSize.defaultSize! * 5),
                    backgroundColor: Colors.transparent,
                    child: EnterPasswordRoomDialog(
                      myData: MyDataModel.getInstance(),
                      ownerId: widget.carouselsList[i].ownerId.toString(),
                    ),
                  );
                });
          } else {
            Navigator.pushNamed(context, Routes.roomHandler,
                arguments: RoomHandlerPramiter(
                    ownerRoomId: widget.carouselsList[i].ownerId.toString(),
                    myDataModel: MyDataModel.getInstance()));
          }

        }
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        ConstentApi().getImage(widget.carouselsList[i].img)),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
          ),
        ),


  ];    super.initState();
  }

  int current = 0;
 

   
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Stack(

        alignment: Alignment.topCenter,
        children: [
          SizedBox( height:ConfigSize.defaultSize! * 18 ,),
          SizedBox(
            height: ConfigSize.defaultSize! * 15,
            width: MediaQuery.of(context).size.width - 50,
            child: CarouselSlider(
              carouselController: controller,
              items: pages,
              options: CarouselOptions(
                height: ConfigSize.defaultSize! * 12,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 400),
                autoPlayCurve: Curves.linear,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(

                top: ConfigSize.defaultSize! * 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pages.map((page) {
                int index = pages.indexOf(page);
                return Container(
                  width: ConfigSize.defaultSize,
                  height: ConfigSize.defaultSize,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: current == index ? Colors.orange : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
