import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/Conter_Time_pk_Widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/time_pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_states.dart';


class PKWidget extends StatefulWidget {
  final double scoreRedTem;
  final double scoreBlueTeam;
  final bool isHost ;
  final String ownerId ;
  static ValueNotifier<bool>isStartPK =ValueNotifier<bool>(false);
  final Function() notifyRoom;
 static String  pkId = '';
  const PKWidget(
      {required this.scoreBlueTeam,required this.isHost
        ,required this.ownerId,required this.notifyRoom,  required this.scoreRedTem, Key? key})
      : super(key: key);

  @override
  _PKWidgetState createState() => _PKWidgetState();
}

class _PKWidgetState extends State<PKWidget> {



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.only(top:AppPadding.p30,left: AppPadding.p8),
      child: BlocBuilder<PKBloc, PKStates>(
      builder: (context, state) {
        if(state is HidePKStateLoading){
          return const Center(child: CircularProgressIndicator(
            color: ColorManager.mainColor,
          ));
        }else{
          return ValueListenableBuilder<int>(
            valueListenable: PkController.updatePKNotifier,
            builder: (context,scoreTime1,_){
              return Stack(
                children: [
                 ValueListenableBuilder(
                     valueListenable: PKWidget.isStartPK,
                     builder: (context,isStartPK,_){
                   if(isStartPK){
                     return Padding(
                         padding:  EdgeInsets.only(left: ConfigSize.defaultSize!*16.5,bottom: 0),
                         child: Container(
                           width: ConfigSize.defaultSize!*7.5,
                           height:AppPadding.p45,
                           decoration:BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               gradient: const   LinearGradient(
                                 begin: Alignment.centerLeft,
                                 end: Alignment.centerRight,
                                 colors: [
                                   Colors.red,
                                   ColorManager.blue,
                                 ], // red to yellow
                               )
                           ) ,
                           padding: EdgeInsets.only(top: AppPadding.p26,left: AppPadding.p14),
                           child:   StreamBuilder<TimeData>(
                             stream:  getIt<SetTimerPK>().stream,
                             builder: (BuildContext context, AsyncSnapshot<TimeData> snapshot) {
                               if ((snapshot.connectionState == ConnectionState.active
                                   || snapshot.connectionState == ConnectionState.done)&&snapshot.hasData) {
                                 return CounterPkTimeWidget(ownerId: widget.ownerId);
                               }else{
                                 return CounterPkTimeWidget(ownerId: widget.ownerId,initMunite: '0',initSecond:'0') ;
                               }
                             },
                           ),
                         )) ;
                   }else{
                     return const SizedBox();
                   }

                     }),
                  Animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                    effects:const [ ShimmerEffect(duration: Duration(seconds: 4,)
                        ,size: 0.2,angle: 10)],
                    child: LinearPercentIndicator(
                      animateFromLastPercent: true,
                      curve: Curves.linearToEaseOut,
                      width: ConfigSize.defaultSize! * 40,
                      animation: true,
                      lineHeight: AppPadding.p20,
                      animationDuration: 2500,
                      percent: PkController.precantgeTeam1==0.0?0.1: PkController.precantgeTeam1==1.0?0.9:PkController.precantgeTeam1,
                      backgroundColor: Colors.transparent,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: ColorManager.blue,
                    ),
                  ),
                  Animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                      effects:const [ ShimmerEffect(duration: Duration(seconds: 4),size: 0.2)],
                      child: LinearPercentIndicator(
                        animateFromLastPercent: true,
                        curve: Curves.linearToEaseOut,
                        width: ConfigSize.defaultSize! * 40,
                        animation: true,
                        lineHeight: AppPadding.p20,
                        isRTL: true,
                        animationDuration: 2500,
                        percent: PkController.precantgeTeam2==0.0?0.1:
                        PkController.precantgeTeam2==1.0?0.9:PkController.precantgeTeam2,
                        backgroundColor: Colors.transparent,

                        progressColor: Colors.red,
                      )),
                  Positioned(
                      left: AppPadding.p14,
                      child: Text(PkController.scoreTeam1.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700))),
                  Positioned(
                      right: AppPadding.p20,
                      child:  Text(
                        PkController.scoreTeam2.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                  Positioned(
                    right: ConfigSize.defaultSize!* 19.4,
                    bottom: AppPadding.p8,
                    child: Container(
                        width: AppPadding.p26,
                        height: AppPadding.p26,
                        padding:const EdgeInsets.only(bottom: 10),
                        child: Image.asset(AssetsPath.pkGif ,fit: BoxFit.contain, width: 30,height: 30,)),
                  ),
                  ValueListenableBuilder(valueListenable: PKWidget.isStartPK,
                      builder: (context,isStartPK,_){
                        if(isStartPK){
                          return const SizedBox();
                        }else{
                         return InkWell(
                           onTap: (){
                             if(widget.isHost){
                               showTimeDialog(context);
                             }

                           },
                           child: Padding(
                             padding:  EdgeInsets.only(left: ConfigSize.defaultSize!*15,bottom: 0),
                             child: Container(
                               width: ConfigSize.defaultSize!*11.5,
                               height: AppPadding.p40,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(AppPadding.p20),
                                   gradient:  const LinearGradient(
                                     begin: Alignment.centerLeft,
                                     end: Alignment.centerRight,
                                     colors: [
                                       ColorManager.blue,
                                       Colors.red,
                                     ], // red to yellow
                                   )

                               ),
                               child:  Center(
                                 child: Text(StringManager.start.tr(),style:const TextStyle(color: Colors.white,
                                     fontSize: 18, fontWeight: FontWeight.w700,fontStyle: FontStyle.italic ),
                                   textAlign: TextAlign.center, ),
                               ),
                             ),
                           ),
                         ) ;
                        }

                      }),
                  if (widget.isHost)
                    Positioned(
                        right: AppPadding.p20,
                        top: AppPadding.p20,
                        child: InkWell(
                          onTap: (){
                      //   restorePKData();
                            BlocProvider.of<PKBloc>(context)
                                .add(ClosePKEvent(ownerId: widget.ownerId,
                                pkId: PKWidget.pkId));
                            BlocProvider.of<PKBloc>(context).add(HidePKEvent(ownerId: widget.ownerId));
                          },
                          child: Icon(Icons.cancel , size: AppPadding.p20, color: Colors.red,),
                        )),



                ],
              );
            },
          );
        }

  },
),
    );
  }
  Future<void> showTimeDialog(BuildContext context ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              StringManager.chooseTimePK.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            content: const TimePKWidget(),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(onTap: () { Navigator.of(context).pop(); }, title:  StringManager.cancle.tr(),
                    width: ConfigSize.screenWidth!*0.2,
                    height: ConfigSize.screenHeight!*0.04,
                      buttonColornotList: ColorManager.mainColor
                  ),

                  MainButton(
                    onTap: () async {
                      widget.notifyRoom();
                      if(PkController.timeMinutePK !=0){
                        BlocProvider.of<PKBloc>(context).add(StartPKEvent(
                            time: PkController.timeMinutePK.toString(),
                            ownerId: widget.ownerId));
                        PkController.scoreTeam2 = 0;
                        PkController.precantgeTeam1 = 0.5;
                        PkController.precantgeTeam2 = 0.5;
                        PkController.scoreTeam1 = 0;
                        PKWidget.isStartPK.value = true;
                        PkController.updatePKNotifier.value =
                            PkController.updatePKNotifier.value + 1;

                        Navigator.of(context).pop();
                      }else{
                        errorToast(context: context, title: StringManager.selectTimeFirst.tr()) ;
                      }
                    },
                    title: StringManager.startBattle.tr(),
                    width: ConfigSize.screenWidth!*0.3,
                    height: ConfigSize.screenHeight!*0.04,
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }

}





