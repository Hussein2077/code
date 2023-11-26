// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';

class PageViewGeftWidget extends StatefulWidget {
  final String userCoins;
  final MyDataModel myData;
  final int type;
  List<GiftsModel> data;
  final Color color = ColorManager.whiteColor;

  PageViewGeftWidget(
      {Key? key,
      required this.myData,
      required this.userCoins,
      required this.type,
      required this.data})
      : super(key: key);

  @override
  PageViewGeftWidgetState createState() => PageViewGeftWidgetState();
}

class PageViewGeftWidgetState extends State<PageViewGeftWidget> {
  @override
  void initState() {
    GiftScreen.numOfGift = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        if(widget.type == 1){
          return getIt<GiftBloc>()..add(GiftesNormalEvent(type: widget.type));
        }else if(widget.type == 2){
          return getIt<GiftBloc>()..add(GiftesHotEvent(type: widget.type));
        }else if(widget.type == 3){
          return getIt<GiftBloc>()..add(GiftesCountryEvent(type: widget.type));
        }else if(widget.type == 5){
          return getIt<GiftBloc>()..add(GiftesFamousEvent(type: widget.type));
        }else{
          return getIt<GiftBloc>()..add(GiftesLuckyEvent(type: widget.type));
        }
      },
      child: BlocConsumer<GiftBloc, GiftsState>(
        listener: (BuildContext context, state) {
          if(state is GetHotGifSucsses){
            widget.data = state.data;
          }
          if(state is GetNormalGifSucsses){
            widget.data = state.data;
          }
          if(state is GetCountryGifSucsses){
            widget.data = state.data;
          }
          if(state is GetFamousGifSucsses){
            widget.data = state.data;
          }
          if(state is GetLuckyGifSucsses){
            widget.data = state.data;
          }
        },
        builder: (BuildContext context, state) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: widget.data.length,
              shrinkWrap: true,
              // itemExtent: 3,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (checkPermissionGift(
                        myLevel: widget.myData.vip1?.level == null
                            ? 0
                            : widget.myData.vip1!.level!,
                        giftLevel: widget.data[index].vipLevel)) {
                      if (GiftScreen.numOfGift == index) {
                        setState(() {
                          GiftScreen.numOfGift = -1;
                          GiftScreen.giftId = -1;
                          GiftScreen.giftPrice = -1;
                          // currentPageView = -1 ;
                        });
                      } else {
                        setState(() {
                          GiftScreen.numOfGift = index;
                          GiftScreen.giftId = widget.data[index].id;
                          GiftScreen.giftPrice = widget.data[index].price;
                          // currentPageView = i ;
                        });
                      }
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize!,
                          vertical: ConfigSize.defaultSize! - 4),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize!),
                        border: Border.all(
                          color: (GiftScreen.numOfGift == index)
                              ? ColorManager.orangeRed
                              : Colors.transparent,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              (GiftScreen.numOfGift == index
                                  //  && currentPageView == i
                              )
                                  ? Container(
                                color: Colors.black87,
                                padding: EdgeInsets.only(
                                    top: ConfigSize.defaultSize! * 2),
                                height: ConfigSize.defaultSize! * 9,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppPadding.p6),
                                    child: CachedNetworkImage(
                                      width: ConfigSize.defaultSize! * 6,
                                      height: ConfigSize.defaultSize! * 6,
                                      fit: BoxFit.contain,
                                      imageUrl: ConstentApi()
                                          .getImage(widget.data[index].img),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[850]!,
                                            highlightColor: Colors.grey[800]!,
                                            child: Container(
                                              height: 170.0,
                                              width: 120.0,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    )),
                              )
                                  : Container(
                                color: Colors.black87,
                                padding: EdgeInsets.only(
                                    top: ConfigSize.defaultSize! * 2),
                                height: ConfigSize.defaultSize! * 9,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppPadding.p6),
                                    child: CachedNetworkImage(
                                      width: ConfigSize.defaultSize! * 6,
                                      height: ConfigSize.defaultSize! * 6,
                                      fit: BoxFit.contain,
                                      imageUrl: ConstentApi()
                                          .getImage(widget.data[index].img),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[850]!,
                                            highlightColor: Colors.grey[800]!,
                                            child: Container(
                                              height:
                                              ConfigSize.defaultSize! * 17,
                                              width:
                                              ConfigSize.defaultSize! * 12,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    )),
                              ),
                              SizedBox(
                                height: ConfigSize.defaultSize! * 0.55,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(AppPadding.p12),
                                    child: Image.asset(
                                      AssetsPath.goldCoinIcon,
                                      width: AppPadding.p12,
                                      height: AppPadding.p12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppPadding.p4,
                                  ),
                                  Text(
                                    widget.data[index].price.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppPadding.p12,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                          if (!checkPermissionGift(
                              myLevel: widget.myData.vip1?.level == null
                                  ? 0
                                  : widget.myData.vip1!.level!,
                              giftLevel: widget.data[index].vipLevel))
                            Container(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                    ColorManager.lightGray.withOpacity(0.3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      StringManager().vipLevelGift(
                                          level: widget.data[index].vipLevel),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w900,
                                          fontSize: AppPadding.p14),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: AppPadding.p10,
                                    ),
                                    Icon(
                                      Icons.error,
                                      color: ColorManager.mainColor,
                                      size: AppPadding.p20,
                                    ),
                                  ],
                                )),
                          if (widget.data[index].price >= 2000)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                AssetsPath.globalIcon,
                                scale: 2,
                              ),
                            ),
                          if (widget.data[index].musicGift == 1)
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                AssetsPath.music2,
                                scale: 1.5,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      )),
                );
              });
        },
      ),
    );
  }
  bool checkPermissionGift({required int myLevel, required int giftLevel}) {
    if (giftLevel > myLevel) {
      return false;
    } else {
      return true;
    }
  }
}
