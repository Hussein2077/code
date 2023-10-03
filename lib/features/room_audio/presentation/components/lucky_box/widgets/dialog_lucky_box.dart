import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_states.dart';
import '../../../room_screen_controler.dart';


class DialogLuckyBox extends StatefulWidget {

  final String  ownerBoxId ;
  final String ownerBoxName ;
  final String coins ;
  final String luckyBoxId ;
  final StreamController<List<LuckyBoxData>> removeController ;
  final TypeLuckyBox typeLuckyBox ;
  final int remTime ;
  final String ownerImage;
  final String uid ;
  static bool startTime = false ;

  const DialogLuckyBox({required this.coins,required this.luckyBoxId,required this.ownerBoxId
    ,required this.ownerBoxName ,required this.removeController,
    required  this.typeLuckyBox ,
    required this.ownerImage,
    required this.uid,
    required this.remTime,
    Key? key}) : super(key: key);

  @override
  DialogLuckyBoxState createState() => DialogLuckyBoxState();
}

class DialogLuckyBoxState extends State<DialogLuckyBox> {

   Timer? timer;


  @override
  void initState() {
      SetTimerLuckyBox.remTimeSuperBox =widget.remTime ;

    if(widget.typeLuckyBox== TypeLuckyBox.superBox ){

        if(SetTimerLuckyBox.remTimeSuperBox == 30 ){
          getIt<SetTimerLuckyBox>().start(widget.remTime) ;
        }

    }else{
      DialogLuckyBox.startTime=false;
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LuckyBoxesBloc,LuckyBoxesStates>(
        builder: (context,state){
          return   StreamBuilder<int>(
            stream:  getIt<SetTimerLuckyBox>().stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.active
                  || snapshot.connectionState == ConnectionState.done) {
               if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      height: ConfigSize.defaultSize!*46.2,
                      decoration:  BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF4EF54E),
                                Color(0xFF00FFB9),
                              ]),
                          borderRadius: BorderRadius.circular(AppPadding.p20)

                      ),
                      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child:const  Align(
                                  alignment: Alignment.topRight,
                                  child:Icon(CupertinoIcons.clear,color: Colors.white,)  ,
                                ) ,
                              )   ,

                              Align(
                                alignment: Alignment.topCenter,
                                child:    CachedNetworkImage(
                                  imageUrl: ConstentApi().getImage(widget.ownerImage),
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: ConfigSize.defaultSize!*10,
                                    height: ConfigSize.defaultSize!*10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider, fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => const CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                  errorWidget: (context, url, error){
                                    return const  Icon(Icons.error);
                                  } ,
                                ),
                              )

                            ],),
                          const  Spacer(flex: 1,) ,
                          Text(widget.ownerBoxName,style: TextStyle(color: Colors.white, fontSize: AppPadding.p18,fontWeight: FontWeight.w500  ),),
                          Text('ID:${widget.uid}',
                            style:TextStyle(color: Colors.white, fontSize: AppPadding.p12,fontWeight: FontWeight.w300  ),),
                          const  Spacer(flex: 2,) ,
                          Text(StringManager.bestWishes.tr(),
                    style: TextStyle(color: Colors.white, fontSize: AppPadding.p16,fontWeight: FontWeight.w700  )),
                          const  Spacer(flex: 1,) ,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AssetsPath.iconApp,width: AppPadding.p16,height: AppPadding.p16,),
                              Text(widget.coins,
    style: TextStyle(color: ColorManager.goldLuck, fontSize: AppPadding.p16,fontWeight: FontWeight.w700 ),)
                            ],
                          ),
                          const  Spacer(flex: 1,) ,
                          InkWell(
                            onTap: (){
                              if( !DialogLuckyBox.startTime ){
                                Navigator.pop(context);
                                BlocProvider.of<LuckyBoxesBloc>(context)
                                    .add(PickupBoxesEvent(boxId: widget.luckyBoxId)) ;
                              }

                            },
                            child:Container(
                                width: ConfigSize.defaultSize!*13.8,
                                height: ConfigSize.defaultSize!*13.8,
                                decoration: const  BoxDecoration(
                                  color: ColorManager.goldLuck,
                                  shape: BoxShape.circle,
                                ),
                                child:Center(
                                  child: (DialogLuckyBox.startTime && snapshot.data !=0) ? Text(
                                      '00:${snapshot.data}',style: TextStyle(color: Colors.white,fontSize:  AppPadding.p18,fontWeight: FontWeight.w700)
                                  ):Text(
                                      StringManager.open.tr(),
                                      style: TextStyle(color: Colors.white,fontSize: AppPadding.p18,fontWeight: FontWeight.w700)
                                  ),
                                )
                            ),
                          ),
                          const  Spacer(flex: 6,) ,


                        ],
                      ),
                    ),
                  );
                }
                else {
                  return Container(
                    height: ConfigSize.defaultSize!*46.2,
                    decoration:  BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF4EF54E),
                              Color(0xFF00FFB9),
                            ]),
                        borderRadius: BorderRadius.circular(AppPadding.p20)

                    ),
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:const  Align(
                                alignment: Alignment.topRight,
                                child:Icon(CupertinoIcons.clear,color: Colors.white,)  ,
                              ) ,
                            )   ,


                            Align(
                              alignment: Alignment.topCenter,
                              child:    CachedNetworkImage(
                                imageUrl: ConstentApi().getImage(widget.ownerImage),
                                imageBuilder: (context, imageProvider) => Container(
                                  width: ConfigSize.defaultSize!*10,
                                  height: ConfigSize.defaultSize!*10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            )

                          ],),
                        const  Spacer(flex: 1,) ,
                        Text(widget.ownerBoxName,style: TextStyle(color: Colors.white, fontSize: AppPadding.p18,fontWeight: FontWeight.w500  ),),
                        Text('ID:${widget.uid}',
                          style:TextStyle(color: Colors.white, fontSize: AppPadding.p12,fontWeight: FontWeight.w300  ),),
                        const  Spacer(flex: 2,) ,
                        Text(StringManager.bestWishes.tr(),style: TextStyle(color: Colors.white, fontSize: AppPadding.p16,fontWeight: FontWeight.w700  )),
                        const  Spacer(flex: 1,) ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AssetsPath.iconApp,width: AppPadding.p16,height: AppPadding.p16,),
                            Text(widget.coins,style: TextStyle(color: ColorManager.goldLuck, fontSize: AppPadding.p16,fontWeight: FontWeight.w700 ),)
                          ],
                        ),
                        const  Spacer(flex: 1,) ,
                        InkWell(
                          onTap: (){
                            if( !DialogLuckyBox.startTime ){
                              Navigator.pop(context);
                              BlocProvider.of<LuckyBoxesBloc>(context)
                                  .add(PickupBoxesEvent(boxId: widget.luckyBoxId)) ;
                            }

                          },
                          child:Container(
                              width: ConfigSize.defaultSize!*13.8,
                              height: ConfigSize.defaultSize!*13.8,
                              decoration: const  BoxDecoration(
                                color: ColorManager.goldLuck,
                                shape: BoxShape.circle,
                              ),
                              child:Center(
                                child: Text(
                                    StringManager.open.tr(),style: TextStyle(color: Colors.white,fontSize:  AppPadding.p18,fontWeight: FontWeight.w700)
                                ),
                              )
                          ),
                        ),
                        const  Spacer(flex: 6,) ,


                      ],
                    ),
                  ) ;
                }
              } else {
                return  Container(
                  height: ConfigSize.defaultSize!*46.2,
                  decoration:  BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF4EF54E),
                            Color(0xFF00FFB9),
                          ]),
                      borderRadius: BorderRadius.circular(AppPadding.p20)

                  ),
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:const  Align(
                              alignment: Alignment.topRight,
                              child:Icon(CupertinoIcons.clear,color: Colors.white,)  ,
                            ) ,
                          )   ,


                          Align(
                            alignment: Alignment.topCenter,
                            child:    CachedNetworkImage(
                              imageUrl: ConstentApi().getImage(widget.ownerImage),
                              imageBuilder: (context, imageProvider) => Container(
                                width: ConfigSize.defaultSize!*10,
                                height: ConfigSize.defaultSize!*10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )

                        ],),
                      const  Spacer(flex: 1,) ,
                      Text(widget.ownerBoxName,style: TextStyle(color: Colors.white, fontSize: AppPadding.p18,fontWeight: FontWeight.w500  ),),
                      Text('ID:${widget.uid}',
                        style:TextStyle(color: Colors.white, fontSize: AppPadding.p12,fontWeight: FontWeight.w300  ),),
                      const  Spacer(flex: 2,) ,
                      Text(StringManager.bestWishes.tr(),style: TextStyle(color: Colors.white, fontSize: AppPadding.p16,fontWeight: FontWeight.w700  )),
                      const  Spacer(flex: 1,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsPath.iconApp,width: AppPadding.p16,height: AppPadding.p16,),
                          Text(widget.coins,style: TextStyle(color: ColorManager.goldLuck, fontSize: AppPadding.p16,fontWeight: FontWeight.w700 ),)
                        ],
                      ),
                      const  Spacer(flex: 1,) ,
                      InkWell(
                        onTap: (){
                          if( !DialogLuckyBox.startTime ){
                            Navigator.pop(context);
                            BlocProvider.of<LuckyBoxesBloc>(context)
                                .add(PickupBoxesEvent(boxId: widget.luckyBoxId)) ;
                          }

                        },
                        child:Container(
                            width: ConfigSize.defaultSize!*13.8,
                            height: ConfigSize.defaultSize!*13.8,
                            decoration: const  BoxDecoration(
                              color: ColorManager.goldLuck,
                              shape: BoxShape.circle,
                            ),
                            child:Center(
                              child: Text(
                                  StringManager.open.tr(),style: TextStyle(color: Colors.white,fontSize:  AppPadding.p18,fontWeight: FontWeight.w700)
                              ),
                            )
                        ),
                      ),
                      const  Spacer(flex: 6,) ,


                    ],
                  ),
                ) ;
              }
            },
          );
        },
    );

  }
}



class SetTimerLuckyBox {

    final StreamController<int> streamController = StreamController<int>.broadcast();
  Timer? _timer;
  static int  remTimeSuperBox = -1 ;
  // Getters
  Stream<int> get stream => streamController.stream;
  Timer get timer => _timer! ;


  // Setters
  void start( int currentTime) {
    DialogLuckyBox.startTime = true ;
    if(_timer == null){
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        SetTimerLuckyBox.remTimeSuperBox--;
        _updateSeconds();
      });
    }else{
      _timer!.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        SetTimerLuckyBox.remTimeSuperBox--;
        _updateSeconds();
      });
    }

  }

  void _updateSeconds() {
    if ( SetTimerLuckyBox.remTimeSuperBox <= 30 &&  SetTimerLuckyBox.remTimeSuperBox  >=0 ) {
      streamController.sink.add(SetTimerLuckyBox.remTimeSuperBox);
    }else{
      SetTimerLuckyBox.remTimeSuperBox =-1 ;
      _timer!.cancel();
      DialogLuckyBox.startTime = false ;
    }
  }
}
