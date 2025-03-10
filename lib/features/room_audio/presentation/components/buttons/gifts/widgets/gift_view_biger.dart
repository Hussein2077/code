import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';

class PageViewGeftWidget extends StatefulWidget {
  final List<GiftsModel> data;
  final RequestState state;
  final String message;
  final String userCoins;

  final MyDataModel myData;

  final Color color = ColorManager.whiteColor;

  const PageViewGeftWidget(
      {Key? key,
        required this.myData,
        required this.data,
        required this.userCoins,
        required this.state,
        required this.message})
      : super(key: key);

  @override
  PageViewGeftWidgetState createState() => PageViewGeftWidgetState();
}

class PageViewGeftWidgetState extends State<PageViewGeftWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    GiftScreen.numOfGift = -1;
    Methods().getCachingVideo(key: StringManager.cachGiftKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case RequestState.loaded:
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
                crossAxisCount: 5),
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

                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular( AppPadding.p6),
                      border: Border.all(
                        color: (GiftScreen.numOfGift == index)
                            ? ColorManager.orangeRed
                            : Colors.transparent,
                      ),
                    ),
                    child: Stack(
                      children: [
                        (GiftScreen.numOfGift == index
                            //  && currentPageView == i
                        )
                            ? Center(
                              child: Container(
                          color: Colors.black87,
                          padding: EdgeInsets.only(
                                top: ConfigSize.defaultSize! * 0),

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
                        ),
                            )
                            : Center(
                              child: Container(
                          color: Colors.black87,
                          padding: EdgeInsets.only(
                                top: ConfigSize.defaultSize! * 0),

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
                            ),

                        Padding(
                          padding:  EdgeInsets.only(bottom: ConfigSize.defaultSize!*0.2),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(AppPadding.p12),
                                  child: Image.asset(
                                    AssetsPath.goldCoinIcon,
                                    width: AppPadding.p12,

                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.data[index].price.toString(),
                                  style: TextStyle(
                                      height:0.3 ,

                                      color: Colors.white,
                                      fontSize: AppPadding.p12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
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
                              scale: 3,
                            ),
                          ),
                        if (widget.data[index].musicGift == 1)
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                AssetsPath.music2,
                                scale: 2,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    )),
              );
            });
      case RequestState.loading:
        return TransparentLoadingWidget(
          height: ConfigSize.defaultSize! * 2,
          width: ConfigSize.defaultSize! * 7.2,
        );
      case RequestState.error:
        return CustomErrorWidget(message: widget.message);
    }
  }
  bool checkPermissionGift({required int myLevel, required int giftLevel}) {
    if (giftLevel > myLevel) {
      return false;
    } else {
      return true;
    }
  }
}