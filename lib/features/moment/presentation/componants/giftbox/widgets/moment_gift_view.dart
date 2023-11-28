import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/moment_giftbox_screen.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';


class MomentGiftView extends StatefulWidget {

  final List<GiftsModel> data;
  final RequestState state;
  final String message;
  static Map<String, dynamic> chachedGiftMp4 = {};

  const MomentGiftView({
    super.key,
    required this.data,
    required this.state,
    required this.message,
  });

  @override
  State<MomentGiftView> createState() => _MomentGiftViewState();
}

class _MomentGiftViewState extends State<MomentGiftView> {

  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case RequestState.loaded:
        return SizedBox(
          width: ConfigSize.screenWidth!,
          height: ConfigSize.screenHeight! * .32,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: ConfigSize.defaultSize!,
                        mainAxisSpacing: ConfigSize.defaultSize!,
                        crossAxisCount: 4),
                    itemCount: widget.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {

                      return InkWell(
                        onTap: () {
                          if (MomentGiftboxScreen.indexGift == index) {
                            setState(() {
                              MomentGiftboxScreen.indexGift = -1;

                            });
                          } else {
                            setState(() {
                              MomentGiftboxScreen.indexGift = index;
                              MomentGiftboxScreen.momentGiftId =
                                  widget.data[index].id;

                              MomentGiftboxScreen.momentGiftPrice =
                                  widget.data[index].price;
                              //  currentPageView = i ;
                            });
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ConfigSize.defaultSize!),
                                color:Colors.black87,
                                border: Border.all(
                                    color: MomentGiftboxScreen.indexGift == index
                                        ? ColorManager.orang
                                        : Colors.transparent)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        top: ConfigSize.defaultSize! * 2),
                                    height: ConfigSize.defaultSize! * 6,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          ConfigSize.defaultSize!),
                                      child: SizedBox(
                                          width:
                                          ConfigSize.defaultSize! * 6,
                                          height:
                                          ConfigSize.defaultSize! * 6,
                                          child: CachedNetworkImage(
                                            width:
                                            ConfigSize.defaultSize! * 6,
                                            height:
                                            ConfigSize.defaultSize! * 6,
                                            fit: BoxFit.contain,
                                            imageUrl: ConstentApi()
                                                .getImage(
                                                widget.data[index].img),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey[850]!,
                                                  highlightColor:
                                                  Colors.grey[800]!,
                                                  child: Container(
                                                    height: 170.0,
                                                    width: 120.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                    ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                            const Icon(Icons.error),
                                          )),
                                    )),

                                SizedBox(
                                  height: ConfigSize.defaultSize! * 0.4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          ConfigSize.defaultSize! * 1.4),
                                      child: Image.asset(
                                        AssetsPath.goldCoinIcon,
                                        width: ConfigSize.defaultSize! * 1.4,
                                        height: ConfigSize.defaultSize! * 1.4,
                                      ),
                                    ),
                                    SizedBox(
                                        width: ConfigSize.defaultSize! * 0.8),
                                    Text(
                                      widget.data[index].price.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          ConfigSize.defaultSize! * 1.4,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      );
                    }),
              )
            ],
          ),
        );
      case RequestState.loading:
        return const TransparentLoadingWidget();
      case RequestState.error:
        return CustomErrorWidget(message: widget.message);
    }
  }


}