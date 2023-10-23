import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/header/live_tab_bar.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';


class HomeHeader extends StatefulWidget {
  final TabController liveController;
  const HomeHeader({required this.liveController, super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LiveTabBAR(liveController: widget.liveController,),
        InkWell(
            onTap: () async{
              String token = await Methods().returnUserToken();
            await  getIt<DefaultCacheManager>().downloadFile('https://www.youtube.com/watch?v=ERA9s5J4BcY');
              File? path =await  getIt<DefaultCacheManager>().getSingleFile('https://www.youtube.com/watch?v=ERA9s5J4BcY');
              if(path.path ==null){
                log("file does not exist ");
              }else{
                log("file path ${path.path}");
                getIt<DefaultCacheManager>().downloadFile('https://www.youtube.com/watch?v=ERA9s5J4BcY')
                    .then((value){
                      log("rrrrrrrr");
                  Navigator.pushNamed(context, Routes.webView,
                      arguments: WebViewPramiter(url:path!.path,title:  '',titleColor: ColorManager.roomComment )  );

                });

              }
              Navigator.pushNamed(context, Routes.searchScreen);
            },
            child: Image.asset(AssetsPath.searchIcon, scale: 2.5,)),
                 BlocBuilder<GetMyDataBloc, GetMyDataState>(
            builder: (context, state) {
              return InkWell(
                  onTap: () {
                    if (MyDataModel
                        .getInstance()
                        .hasRoom ?? false) {
                      Navigator.pushNamed(
                          context, Routes.roomHandler, arguments:
                      RoomHandlerPramiter(ownerRoomId: MyDataModel
                          .getInstance()
                          .id
                          .toString(),
                          myDataModel: MyDataModel.getInstance()));



                    } else {
                     Navigator.pushNamed(context, Routes.createLive);


                    }
                  },
                  child: Image.asset(AssetsPath.createLiveIcon, scale: 2.5,));
            })


      ],);
  }
}