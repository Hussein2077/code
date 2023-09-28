import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/moment_giftbox_bottom_bar.dart';



class MomentGiftView extends StatefulWidget {
//final MomentModel momentModel;


  const MomentGiftView({
    //required this.momentModel,

    super.key,

  });

  @override
  State<MomentGiftView> createState() => _MomentGiftViewState();
}

class _MomentGiftViewState extends State<MomentGiftView> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ConfigSize.screenWidth!,
      height: ConfigSize.defaultSize! * 29.5,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(


                    crossAxisSpacing: ConfigSize.defaultSize!,
                    mainAxisSpacing: ConfigSize.defaultSize!,
                    crossAxisCount: 4),
                itemCount: 300,
                //widget.data.length,


                shrinkWrap: true,

                itemBuilder: (context , index) {

                  return InkWell(
                    onTap: () {
                      // if( checkPermissionGift(myLevel:  widget.myData.vip1?.level==null?0 : widget.myData.vip1!.level! ,
                      //     giftLevel: widget.data[index].vipLevel
                      // )    ){
                      //
                      //   // if(PageViewGeftWidget.chachedGiftMp4.containsKey( widget.data[index].id.toString())){
                      //   //   if(MomentGiftboxScreen.numOfGift==index){
                      //   //     setState(() {
                      //   //       MomentGiftboxScreen.numOfGift =-1 ;
                      //   //     });
                      //   //   }
                      //   //   else{
                      //   //     setState(() {
                      //   //       MomentGiftboxScreen.numOfGift = index;
                      //   //       MomentGiftboxScreen.giftId =  widget.data[index].id;
                      //   //       MomentGiftboxScreen.giftPrice= widget.data[index].price;
                      //   //       //  currentPageView = i ;
                      //   //     });
                      //   //   }
                      //   // }
                      //   // }
                      //   // else{
                      //   //   if(MomentGiftboxScreen.numOfGift==index){
                      //   //     setState(() {
                      //   //       MomentGiftboxScreen.numOfGift =-1 ;
                      //   //       // currentPageView = -1 ;
                      //   //     });
                      //   //   }
                      //   //   else{
                      //   //     setState(() {
                      //   //       MomentGiftboxScreen.numOfGift = index;
                      //   //       MomentGiftboxScreen.giftId =  widget.data[index].id;
                      //   //       MomentGiftboxScreen.giftPrice= widget.data[index].price;
                      //   //       // currentPageView = i ;
                      //   //     });
                      //   //   }
                      //   // }
                      // }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                            color:
                            // (MomentGiftboxScreen.numOfGift == index
                            //     //&&
                            //     // currentPageView == i
                            // )?
                            // Colors.transparent :
                            Theme.of(context).colorScheme.secondary.withOpacity(0.5),),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (MomentGiftboxBottomBar.numOfGift == index
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
                                      ConfigSize.defaultSize!),
                                  child: SizedBox(
                                      width: ConfigSize.defaultSize!*6,
                                      height: ConfigSize.defaultSize!*6,
                                      child: Image.asset(AssetsPath.goldCoinCard)),

                                  // CachedNetworkImage(
                                  //   width: ConfigSize.defaultSize!*6,
                                  //   height: ConfigSize.defaultSize!*6,
                                  //   fit: BoxFit.contain,
                                  //   imageUrl: ConstentApi()
                                  //       .getImage( widget.data[index].img),
                                  //   placeholder: (context, url) =>
                                  //       Shimmer.fromColors(
                                  //         baseColor: Colors.grey[850]!,
                                  //         highlightColor: Colors.grey[800]!,
                                  //         child: Container(
                                  //           height: 170.0,
                                  //           width: 120.0,
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.black,
                                  //             borderRadius:
                                  //             BorderRadius.circular(8.0),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //   errorWidget: (context, url, error) =>
                                  //   const Icon(Icons.error),
                                  // )

                              ),
                            )
                                :Container(
                              padding: EdgeInsets.only(
                                  top: ConfigSize.defaultSize! *
                                      2),
                              height:
                              ConfigSize.defaultSize! * 6,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      ConfigSize.defaultSize!),
                                  child: SizedBox(
                                    width: ConfigSize.defaultSize!*6,
                                    height: ConfigSize.defaultSize!*6,
                                    child: Image.asset(AssetsPath.goldCoinCard),
                                  ),

                                  // CachedNetworkImage(
                                  //   width: ConfigSize.defaultSize!*6,
                                  //   height: ConfigSize.defaultSize!*6,
                                  //   fit: BoxFit.contain,
                                  //   imageUrl: ConstentApi()
                                  //       .getImage( widget.data[index].img),
                                  //   placeholder: (context, url) =>
                                  //       Shimmer.fromColors(
                                  //         baseColor: Colors.grey[850]!,
                                  //         highlightColor: Colors.grey[800]!,
                                  //         child: Container(
                                  //           height: 170.0,
                                  //           width: 120.0,
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.black,
                                  //             borderRadius:
                                  //             BorderRadius.circular(8.0),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //   errorWidget: (context, url, error) =>
                                  //   const Icon(Icons.error),
                                  // )

                              ),
                            ) ,
                            SizedBox(
                              height: ConfigSize.defaultSize! * 0.4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      ConfigSize.defaultSize!*1.4),

                                  child:Image.asset(AssetsPath.goldCoinIcon,width:ConfigSize.defaultSize!*1.4,
                                    height: ConfigSize.defaultSize!*1.4,),
                                )  ,
                                SizedBox(
                                    width: ConfigSize.defaultSize!*0.8
                                ),
                                Text('200',
                                 // widget.data[index].price.toString(),
                                  style:  TextStyle(
                                      color: Colors.white,fontSize: ConfigSize.defaultSize!*1.4,fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        )


                    ),
                  );
                }),
          )

        ],
      ),
    );
  }
  bool checkPermissionGift({required int myLevel,required int giftLevel }){
    if(giftLevel >myLevel){
      return false ;
    }else{
      return true ;
    }
  }

}
