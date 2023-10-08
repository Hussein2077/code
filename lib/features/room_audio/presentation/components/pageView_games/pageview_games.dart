
// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/Dailog_Method.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pageView_games/dialog_games.dart';

class PageViewGames extends StatefulWidget {
  const PageViewGames({ Key? key  }) : super(key: key);

  @override
  _PageViewGamesState createState() => _PageViewGamesState();
}

class _PageViewGamesState extends State<PageViewGames>  with SingleTickerProviderStateMixin  {
  final CarouselController _controller = CarouselController();
  late AnimationController _controllerAnimation;
  late Animation<double> _scaleAnimation;
  int _current = 0 ;
  bool _scale = false;

  //TODO games images

  List<String> gamesImages=
  [
    AssetsPath.teenPatti,
    AssetsPath.roulette,
    AssetsPath.carRace,
    AssetsPath.updown,
    AssetsPath.ludo,
  ];

  @override
  void initState() {
    super.initState();
    _controllerAnimation =
        AnimationController(vsync: this, duration:const  Duration(milliseconds: 800));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(_controllerAnimation);
  }


  void _onTap() {
    setState(() {
      if (_scale) {
        _controllerAnimation.reverse();
        _scale = false ;
      } else {
        _controllerAnimation.forward();
        _scale = true ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {
          if(!_scale){
            setState(() {
              _scale = true ;
            });
          }else{
            joinToGames(_current);
          }

        },
        child:  Padding(
      padding: const EdgeInsets.only(bottom:25,left: 4),
      child:  AnimatedBuilder(
          animation: _controllerAnimation,
      builder: (context, child) {
         return Transform.scale(
        scale: _scaleAnimation.value,
        child:
             Padding(
          padding: EdgeInsets.only(left: _scale? AppPadding.p20:0,bottom:_scale? AppPadding.p20:0),
          child: SizedBox(
                  width:_scale  ? ConfigSize.defaultSize!*6 : ConfigSize.defaultSize!*3,
                  height: _scale ?ConfigSize.defaultSize!*9 : ConfigSize.defaultSize!*6,
                  child:Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical:  ConfigSize.defaultSize! ),
                          child:  CarouselSlider(
                            items: [
                              for (int index = 0; index < gamesImages.length; index++)
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(gamesImages[index]),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),

                            ],
                            carouselController: _controller,
                            options: CarouselOptions(
                                height: 200,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: true,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                // autoPlayAnimationDuration: const Duration(milliseconds: 100),
                                autoPlayCurve: Curves.linear,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ) ,


                        ),
                        Positioned(
                            bottom: AppPadding.p10,
                            left: 0,
                            child: InkWell(
                              onTap: _onTap,
                              child: Icon( _scale ?CupertinoIcons.fullscreen_exit:CupertinoIcons.fullscreen,color: ColorManager.whiteColor,size: AppPadding.p16,),

                            )), // pages
                        Padding(
                          padding: EdgeInsets.only(top: _scale ? ConfigSize.defaultSize!*10 :ConfigSize.defaultSize!*7,

                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: DotsIndicator(
                              dotsCount: gamesImages.length,
                              position: _current.toDouble(),
                              decorator: DotsDecorator(
                                spacing:EdgeInsets.zero ,
                                color: ColorManager.gray,
                                activeColor: ColorManager.mainColor,
                                activeSize: Size.square(_scale ?ConfigSize.defaultSize!*0.8 :ConfigSize.defaultSize!*0.6),
                                size:  Size.square( _scale ? ConfigSize.defaultSize! * 0.6:ConfigSize.defaultSize!*0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side:  BorderSide(color: Colors.black.withOpacity(0.8))),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
              ),
             ),
         );
         },
      ),
        ),
    );
  }

  // TODO change links

  void joinToGames(int index)async {
    String token = await Methods().returnUserToken() ;
    if(index==0){
      dailogRoom(context: context,
          widget: WebViewInRoom(url: '${StringManager.teenPatti}${token}',) );


    }else if(index ==1){
      dailogRoom(context: context,
          widget: WebViewInRoom(url: '${StringManager.roulette}${token}',) );

    }else if(index==2){
      dailogRoom(context: context,
          widget: WebViewInRoom(url: '${StringManager.carRace}${token}',) );

    }else if (index ==3){
      dailogRoom(
          context: context,
          widget: WebViewInRoom(url: '${StringManager.updown}${token}',)
      );

    }else if(index ==4){
      dailogRoom(
          context: context,
          widget: WebViewInRoom(url: '${StringManager.ludo}${token}',)
      );

    }
  }
}
