
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_gift_model.dart';


class SentGiftScreenBody extends StatefulWidget {
  final List<MomentGiftsModel> momentGiftsModelList;
  final ScrollController scrollController ;

  String momentId;
   SentGiftScreenBody({required this.momentGiftsModelList,required this.momentId,required this.scrollController,Key? key}) : super(key: key);

  @override
  State<SentGiftScreenBody> createState() => _SentGiftScreenBodyState();
}

class _SentGiftScreenBodyState extends State<SentGiftScreenBody> {

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.builder(
        controller:widget.scrollController ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: ConfigSize.defaultSize!,
            mainAxisSpacing: ConfigSize.defaultSize!,
            crossAxisCount: 3),
        itemCount: widget.momentGiftsModelList.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return

            Column(
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
                        width: ConfigSize.defaultSize! * 6,
                        height: ConfigSize.defaultSize! * 6,
                        child: CachedNetworkImage(
                          width: ConfigSize.defaultSize! * 6,
                          height: ConfigSize.defaultSize! * 6,
                          fit: BoxFit.contain,
                          imageUrl: ConstentApi()
                              .getImage(
                              widget.momentGiftsModelList[i].giftImage),
                          placeholder: (context, url) =>
                              Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor:
                                Colors.grey[800]!,
                                child: Container(
                                  height: ConfigSize.defaultSize!*17,
                                  width: ConfigSize.defaultSize!*12,
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
              Text(
                  'x ${widget.momentGiftsModelList[i].giftNum}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize:
                    ConfigSize.defaultSize! * 1.4,
                    fontWeight: FontWeight.w600),
              ),
            ],
          );


        },
      ),
    );

  }




}
