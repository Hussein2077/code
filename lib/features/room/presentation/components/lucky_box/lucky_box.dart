import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'dart:ui' as ui ;
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/components/lucky_box/widgets/coins_lucky_box.dart';
import 'package:tik_chat_v2/features/room/presentation/components/lucky_box/widgets/quaintity_users_box.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_states.dart';


class LuckyBox extends StatefulWidget {
 final EnterRoomModel roomData ;
  const LuckyBox({required this.roomData, Key? key}) : super(key: key);
  static String typeBox = "luckyBox" ;
  static String coins = "0";
  static String quantity = '25' ;
  static int  currentBox = 1 ;


  @override
  LuckyBoxState createState() => LuckyBoxState();
}

class LuckyBoxState extends State<LuckyBox> {

  void refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return    BlocConsumer<LuckyBoxesBloc,LuckyBoxesStates>(
        builder: (context,state){
          if(state is LoadingLuckyBoxesState){
             return const TransparentLoadingWidget();
          }else if (state is SuccessLuckyBoxesState){
             return  Directionality(
                 textDirection: ui.TextDirection.ltr,
                 child: Container(
                   height: ConfigSize.screenHeight! / 2,
                   width: double.maxFinite,
                   decoration:  BoxDecoration(
                       gradient: const  LinearGradient(
                           begin: Alignment.topCenter,
                           end: Alignment.bottomCenter,
                           colors: ColorManager.mainColorList),
                       borderRadius: BorderRadius.only(
                           topRight: Radius.circular(AppPadding.p16),
                           topLeft: Radius.circular(AppPadding.p16))),
                   child: Column(
                     children: [
                       const Spacer(
                         flex: 1,
                       ),
                       Image.asset(
                         AssetsPath.luckyBox,
                         width: ConfigSize.defaultSize! * 6.9,
                         height: ConfigSize.defaultSize! * 6.9,
                       ),
                       Text(
                         StringManager.sendToLuckyBox.tr(),
                         style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.w700,
                             fontSize: AppPadding.p16),
                       ),
                       const Spacer(
                         flex: 1,
                       ),
                       // detect box
                       Container(
                         width: ConfigSize.defaultSize! * 33,
                         height: AppPadding.p45,
                         decoration: BoxDecoration(
                             color: Colors.transparent,
                             borderRadius: BorderRadius.circular(AppPadding.p20),
                             border: Border.all(color: Colors.white)),
                         child:  Row(
                           children: [
                             Expanded(
                                 flex: 1,
                                 child: InkWell(
                                     onTap: (){
                                       setState(() {
                                         LuckyBox.typeBox ="luckyBox" ;
                                       });
                                     },child:Container(
                                   decoration: BoxDecoration(
                                     color:LuckyBox.typeBox == "luckyBox" ?  Colors.white:Colors.transparent  ,
                                     borderRadius: BorderRadius.only(
                                         topLeft: Radius.circular(AppPadding.p17),
                                         bottomLeft: Radius.circular(AppPadding.p17)),
                                   ),
                                   child: Center(
                                     child: Text(
                                       StringManager.luckyBox.tr(),
                                       style: TextStyle(
                                           color:LuckyBox. typeBox == "luckyBox" ? ColorManager.mainColor :
                                           Colors.white,
                                           fontWeight: FontWeight.w700,
                                           fontSize: AppPadding.p16),
                                     ),
                                   ),
                                 )

                                 ) ),
                             Expanded(
                                 flex: 1,
                                 child: InkWell(
                                     onTap: (){
                                       setState(() {
                                         LuckyBox.typeBox = "superBox" ;
                                       });
                                     },child: Container(
                                     decoration: BoxDecoration(
                                       color:LuckyBox.typeBox == "superBox" ?  Colors.white:Colors.transparent,
                                       borderRadius: BorderRadius.only(
                                           topRight: Radius.circular(AppPadding.p17),
                                           bottomRight: Radius.circular(AppPadding.p17)),
                                     ),
                                     child: Center(
                                       child: Text(
                                         StringManager.superBox.tr(),
                                         style: TextStyle(
                                             color:LuckyBox.typeBox == "superBox" ? ColorManager.mainColor
                                                 :Colors.white,
                                             fontWeight: FontWeight.w700,
                                             fontSize: AppPadding.p16),
                                       ),
                                     ))))
                           ],
                         ),
                       ),
                       const Spacer(
                         flex: 1,
                       ),
                       Padding(
                           padding: const EdgeInsets.only(right: 200, bottom: 6),
                           child: Text(
                             StringManager.coins.tr(),
                             style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.w700,
                                 fontSize: AppPadding.p16),
                           )),
                       // detect coin

                       CoinsLuckyBox(boxes:LuckyBox.typeBox == 'superBox'?state.boxLuckyModel.superBox:state.boxLuckyModel.normalBox, refresh: refresh,)
                       ,
                       const Spacer(
                         flex: 1,
                       ),
                       if(LuckyBox.typeBox != 'superBox')
                         Padding(
                           padding: const EdgeInsets.only(right: 180, bottom: 6),
                           child: Text(
                             StringManager.quantity.tr(),
                             style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.w700,
                                 fontSize: AppPadding.p16),
                           ),
                         ),
                       // detect quantity
                       if(LuckyBox.typeBox != 'superBox')
                         QuaintityUsersBox(boxes: LuckyBox.typeBox == 'superBox'?state.boxLuckyModel.superBox:state.boxLuckyModel.normalBox ,),
                       const Spacer(
                         flex: 1,
                       ),
                       //send button
                       InkWell(
                         onTap: (){
                           if(LuckyBox.typeBox == 'superBox'){
                             log( state.boxLuckyModel.superBox.length.toString());
                             BlocProvider.of<LuckyBoxesBloc>(context)
                                 .add(SendBoxesEvent(boxId: state.boxLuckyModel.superBox[LuckyBox.currentBox-1].id.toString(),
                                 ownerId:widget.roomData.ownerId.toString(), quintity:LuckyBox.quantity )) ;
                           }else{

                             BlocProvider.of<LuckyBoxesBloc>(context)
                                 .add(SendBoxesEvent(boxId: state.boxLuckyModel.normalBox[LuckyBox.currentBox-1].id.toString(),
                                 ownerId:widget.roomData.ownerId.toString(),quintity:LuckyBox.quantity )) ;
                           }

                         },
                         child:Container(
                           width: ConfigSize.defaultSize! * 24,
                           height: AppPadding.p40,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(AppPadding.p18)),
                           child: Center(
                               child: Text(
                                 StringManager.send.tr(),
                                 style: TextStyle(
                                     color: ColorManager.mainColor,
                                     fontWeight: FontWeight.w700,
                                     fontSize: AppPadding.p16),
                               )),
                         ) ,
                       ) ,
                       const Spacer(
                         flex: 1,
                       ),
                     ],
                   ),
                 ));
          }else if (state is ErrorLuckyBoxesState){

             return CustomErrorWidget(message: state.errorMessage);
          }
          else {
            return  const SizedBox();
          }
        },
      listener: (context,state){
        if(state is ErrorSendBoxesState){
          errorToast(context: context, title: state.errorMessage);
        }
      },

    ) ;



  }
}
