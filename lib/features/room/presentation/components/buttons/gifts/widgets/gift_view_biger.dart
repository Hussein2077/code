
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
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/room/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';



class PageViewGeftWidget extends StatefulWidget {
  final List<GiftsModel> data;
  final RequestState state;
  final String message;
  final String userCoins ;
  final MyDataModel myData ;
  final  Color color = ColorManager.whiteColor;
  static Map<String,dynamic> chachedGiftMp4 = {} ;



 const PageViewGeftWidget(
      {
      Key? key,
        required this.myData,
      required this.data,
        required this.userCoins,
      required this.state,
      required this.message})
      : super(key: key);

  @override
  PageViewGeftWidgetState createState() => PageViewGeftWidgetState();
}

class PageViewGeftWidgetState extends State<PageViewGeftWidget>  with TickerProviderStateMixin{
  bool isDownload =false ;
  late List<String> downloadPathList ;


  @override
   void initState() {
    GiftScreen.numOfGift =-1 ;
    super.initState();
  }





  @override
  Widget build(BuildContext context) {


    switch (widget.state) {
      case RequestState.loaded:

        return GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: widget.data.length,
          
          
          shrinkWrap: true,
          // itemExtent: 3,
          itemBuilder: (context , index) {
          
          return InkWell(
                          onTap: () {
                            if( checkPermissionGift(myLevel:  widget.myData.vip1?.level==null?0 : widget.myData.vip1!.level! ,
                                giftLevel: widget.data[index].vipLevel
                            )    ){
                            if( widget.data[index].showImg.contains("mp4"))
                            {
                             if(PageViewGeftWidget.chachedGiftMp4.containsKey( widget.data[index].id.toString())){
                               if(GiftScreen.numOfGift==index){
                                 setState(() {
                                   GiftScreen.numOfGift =-1 ;
                                 });
                               }
                               else{
                                 setState(() {
                                   GiftScreen.numOfGift = index;
                                   GiftScreen.giftId =  widget.data[index].id;
                                   GiftScreen.giftPrice= widget.data[index].price;
                                  //  currentPageView = i ;
                                 });
                               }
                             }
                            }
                            else{
                              if(GiftScreen.numOfGift==index){
                                setState(() {
                                  GiftScreen.numOfGift =-1 ;
                                  // currentPageView = -1 ;
                                });
                              }
                              else{
                                setState(() {
                                  GiftScreen.numOfGift = index;
                                  GiftScreen.giftId =  widget.data[index].id;
                                  GiftScreen.giftPrice= widget.data[index].price;
                                  // currentPageView = i ;
                                });
                              }
                            }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ConfigSize.defaultSize! ,
                                vertical: ConfigSize.defaultSize!),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:(GiftScreen.numOfGift == index
                                  )?
                                  Colors.transparent : Colors.black87),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      (GiftScreen.numOfGift == index
                                     //  && currentPageView == i
                                       ) ?
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: ConfigSize.defaultSize! *
                                                2),
                                        height:
                                        ConfigSize.defaultSize! * 6,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                AppPadding.p6),
                                            child: CachedNetworkImage(
                                              width: ConfigSize.defaultSize!*6,
                                              height: ConfigSize.defaultSize!*6,
                                              fit: BoxFit.contain,
                                              imageUrl: ConstentApi()
                                                  .getImage( widget.data[index].img),
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
                                          :Container(
                                        padding: EdgeInsets.only(
                                            top: ConfigSize.defaultSize! *
                                                2),
                                        height:
                                        ConfigSize.defaultSize! * 6,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                AppPadding.p6),
                                            child: CachedNetworkImage(
                                              width: ConfigSize.defaultSize!*6,
                                              height: ConfigSize.defaultSize!*6,
                                              fit: BoxFit.contain,
                                              imageUrl: ConstentApi()
                                                  .getImage( widget.data[index].img),
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
                                      ) ,
                                      SizedBox(
                                        height: ConfigSize.defaultSize! * 0.4,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              AppPadding.p12),
        
                                          child:
                                          Image.asset(AssetsPath.goldCoinIcon,
                                            width: AppPadding.p12,height: AppPadding.p12,),
                                        )  ,
                                          SizedBox(
                                            width: AppPadding.p4,
                                          ),
                                          Text(
                                             widget.data[index].price.toString(),
                                            style:  TextStyle(
                                                color: Colors.white,fontSize: AppPadding.p12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                if( widget.data[index].showImg.contains('mp4')
                                    &&!PageViewGeftWidget.chachedGiftMp4.containsKey( widget.data[index].id.toString()))
                                Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.lightGray.withOpacity(0.3)
                                  ),
                                  child: const  Icon(Icons.download_outlined,
                                    color: ColorManager.mainColor,size: 20,) ,
                                ),
        
                                  if( !checkPermissionGift(myLevel:  widget.myData.vip1?.level==null?0 : widget.myData.vip1!.level! ,
                                      giftLevel: widget.data[index].vipLevel
                                  ))
                                    Container(
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: ColorManager.lightGray.withOpacity(0.3)
                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(StringManager().vipLevelGift(level: widget.data[index].vipLevel),style:
                                            TextStyle(color: Colors.black,fontStyle: FontStyle.italic, fontWeight: FontWeight.w900,fontSize: AppPadding.p14),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: AppPadding.p10,
                                            ),
                                            Icon(Icons.error,color: ColorManager.mainColor,size: AppPadding.p20,) ,
                                          ],
                                        )
                                    )
                                ],
                              )
        
        
                            ),
                        );
        });
      case RequestState.loading:
        return const TransparentLoadingWidget();
      case RequestState.error:
        return CustomErrorWidget(message: widget.message);
    }
  }

//   List<List<GiftsModel>>  splitToChunks({required int sizeOfChunk, required List<GiftsModel> orginalList}){
//     double lenghtIndcator = widget.data.length / 8 ;
//     numberPageView = lenghtIndcator.ceil();
//     List<List<GiftsModel>> chunks = [];
//    for (var i = 0; i < orginalList.length; i += sizeOfChunk) {
//      chunks.add(orginalList.sublist(i, i+sizeOfChunk > orginalList.length ?
//      orginalList.length : i + sizeOfChunk));
//    }
//    return chunks;
//  }
  bool checkPermissionGift({required int myLevel,required int giftLevel }){
    if(giftLevel >myLevel){
      return false ;
    }else{
      return true ;
    }
  }
}
