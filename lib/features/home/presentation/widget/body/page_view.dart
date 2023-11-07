

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';
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
          log("in url ");
          // Navigator.pushNamed(context, Routes.webView,
          //       arguments: WebViewPramiter(
          //           url:widget.carouselsList[i].url,
          //           title: '',
          //           titleColor: Colors.transparent));
          if(await canLaunchUrl(Uri.parse(widget.carouselsList[i].url))){
            launchUrl(Uri.parse(widget.carouselsList[i].url)) ;
          }
        }
        else if(widget.carouselsList[i].ownerId!=0){
          log("in room ");
          await Methods().checkIfRoomHasPassword(
            myData: MyDataModel.getInstance(),
            context: context,
            hasPassword: widget.carouselsList[i].hasPassword,
            ownerId:
            widget.carouselsList[i].ownerId.toString(),
          );
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
        alignment: Alignment.bottomCenter,
        children: [
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

                bottom: ConfigSize.defaultSize! * 2),
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
                    color: current == index ? Colors.white : Colors.grey,
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
