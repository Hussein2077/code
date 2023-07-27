import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  int current = 0;
  List<Widget> pages = [
    Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                AssetsPath.splashBackGround,
              ),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
    ),
    Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                AssetsPath.loginBackGround,
              ),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
    ),
  ];
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              left: ConfigSize.defaultSize! * 6,
              bottom: ConfigSize.defaultSize! * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: pages.map((page) {
              int index = pages.indexOf(page);
              return Container(
                width: ConfigSize.defaultSize,
                height: ConfigSize.defaultSize,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: current == index ? Colors.white : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
