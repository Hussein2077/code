import 'dart:async';
import 'dart:developer';
import 'package:animated_icon/animated_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/header/live_tab_bar.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/item_widget_for_cache.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

final GlobalKey homeCacheKey = GlobalKey();

class HomeHeader extends StatefulWidget {
  final TabController liveController;
  static StreamController<Map< String,ItemWidget>> streamControllerCacheData   =
  StreamController<Map< String,ItemWidget>>.broadcast();
  static Map< String,ItemWidget>  cacheData = {} ;

  const HomeHeader({
    required this.liveController,
    super.key,
  });


  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {


  @override
  void dispose() {
    HomeHeader.streamControllerCacheData.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LiveTabBAR(
          liveController: widget.liveController,
        ),
       StreamBuilder<Map< String,ItemWidget>>(
    initialData:HomeHeader.cacheData,
    stream: HomeHeader.streamControllerCacheData.stream,
    builder: (context, snapshot) {
      log("HomeHeader") ;
      if(snapshot.hasData && (snapshot.data?.isNotEmpty??false))
      {
        log("snapshot.data?.values.toList()${snapshot.data?.values.toList()}");
         List<ItemWidget> ne = snapshot.data!.values.toList();
         return  DropdownButtonHideUnderline(
               child: DropdownButton2<ItemWidget>(
                 items: ne
                     .map((item) =>
                     DropdownMenuItem(
                       value: item,
                       child:
                       item,

                     ))
                     .toList(),
                 onChanged: (value) {
                   onChangedCacheInDropDownHome(value);
                 },

                 isExpanded: true,
                 hint: Text(
                   StringManager.cache.tr(),
                   style: TextStyle(
                     fontSize: ConfigSize.defaultSize!*1.2,
                     fontWeight: FontWeight.w500,
                     color: ColorManager.whiteColor,
                   ),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ),
                 dropdownDecoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(
                       ConfigSize.defaultSize!),
                 ),
                 buttonWidth: ConfigSize.defaultSize! * 12,
                 dropdownWidth: ConfigSize.defaultSize! * 15,
                 icon: AnimateIcon(
                   key: UniqueKey(),
                   onTap: () {},
                   iconType: IconType.continueAnimation,
                   height: ConfigSize.defaultSize! * 4,
                   width: ConfigSize.defaultSize! * 4,
                   color: ColorManager.whiteColor,
                   animateIcon: AnimateIcons.cloud,
                 ),
                 offset: const Offset(25, 5),
               ),
             );
      }else{
        log("HomeHeader22") ;
        return const SizedBox() ;
      }
    }
    ),
        InkWell(
            onTap: () async {
              Navigator.pushNamed(context, Routes.searchScreen);
              // Navigator.pushNamed(context, Routes.searchScreen);
            },
            child: Image.asset(
              AssetsPath.searchIcon,
              scale: 2.5,
            )),
        BlocBuilder<GetMyDataBloc, GetMyDataState>(builder: (context, state) {
          return InkWell(
              onTap: () {
                if (MyDataModel.getInstance().hasRoom ?? false) {
                  Navigator.pushNamed(context, Routes.roomHandler,
                      arguments: RoomHandlerPramiter(
                          ownerRoomId: MyDataModel.getInstance().id.toString(),
                          myDataModel: MyDataModel.getInstance()));
                } else {
                  Navigator.pushNamed(context, Routes.createLive);
                }
              },
              child: Image.asset(
                AssetsPath.createLiveIcon,
                scale: 2.5,
              ));
        })
      ],
    );
  }

  void onChangedCacheInDropDownHome(ItemWidget? value) {

    if (value?.text == StringManager.cacheGift.tr()) {
      Methods.instance.chachGiftInRoom();
    }
    else if (value?.text ==  StringManager.cacheExtra.tr()) {
      Methods.instance.getAndLoadExtraData();
    }
    else if (value?.text == StringManager.cacheFrame.tr()) {
      Methods.instance.getAndLoadFrames();
    }
    else if (value?.text == StringManager.cacheIntro.tr()) {
      Methods.instance.getAndLoadEntro();
    }
    else if (value?.text == StringManager.cacheEmoji.tr()) {
      Methods.instance.getAndLoadEmojie();
    }
   // sucssesToast(context: context, title: StringManager.dataLoaded.tr());
  }
}
