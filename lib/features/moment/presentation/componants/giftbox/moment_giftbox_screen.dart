

// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';
import 'widgets/moment_gift_view.dart';
import 'widgets/moment_giftbox_bottom_bar.dart';

class MomentGiftboxScreen extends StatelessWidget {
  final String momentId;
  final MyDataModel myDataModel;
  MomentGiftboxScreen({
    super.key,
    required this.myDataModel,
    required this.momentId,
  });

  static int momentGiftId = 0;
  static int momentGiftPrice = 0;
  static int indexGift = -1;

  List<GiftsModel> data = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<GiftBloc>()..add(GiftesMomentEvent(type: 4)),
      child: BlocConsumer<GiftBloc, GiftsState>(
        listener: (BuildContext context, GiftsState state) {
          if(state is GetMomentGifSucsses){
            data = state.data;
          }
        },
        builder: (BuildContext context, GiftsState state) {
          return Container(
            color: Colors.black87,
            height: ConfigSize.defaultSize! * 41,
            child: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ConfigSize.defaultSize!*1,
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.xmark,
                        color:  Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    Text(
                      StringManager.giftBox.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:ConfigSize.defaultSize!*1.8
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),

                    SizedBox(
                      width: ConfigSize.defaultSize!*7,
                    )
                  ],
                ),

                MomentGiftView(
                  data: data,
                ),
                MomentGiftboxBottomBar(
                  momentId: momentId,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
