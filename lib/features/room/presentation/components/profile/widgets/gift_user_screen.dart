

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/gifts/widgets/gift_view_biger.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/gift_user_only.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/Gift_manger/gift_states.dart';

class GiftUserScreen extends StatefulWidget {
  final MyDataModel myDataModel;
  final EnterRoomModel roomData;
  final String userId;
  const GiftUserScreen(
      {required this.myDataModel,
      required this.roomData,
      required this.userId,
      super.key});
  static int giftId = 0;
  static int giftPrice = 0;
  static int numOfGift = -1;

  @override
  State<GiftUserScreen> createState() => _GiftUserScreenState();
}

class _GiftUserScreenState extends State<GiftUserScreen>
    with TickerProviderStateMixin {
  TabController? giftControler;

  @override
  void initState() {
    super.initState();
    giftControler = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftBloc, GiftsStates>(builder: (context, state) {
      return Container(
          height: ConfigSize.screenHeight! / 2,
          color: ColorManager.giftback,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GiftUserOnly(
                userId: widget.userId,
                ownerId: widget.roomData.ownerId.toString(),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        indicatorColor: Colors.transparent,
                        controller: giftControler,
                        automaticIndicatorColorAdjustment: false,
                        tabs: [
                          Text(
                            StringManager.appGift.tr(),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(StringManager.spicalGift.tr(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          Text(StringManager.country.tr(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600))
                        ]),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(controller: giftControler, children: [
                  PageViewGeftWidget(
                      data: state.dataNormal,
                      state: state.normalState,
                      message: state.normalMessage,
                      userCoins:
                          widget.myDataModel.myStore!.coins.toString(),
                      myData: widget.myDataModel),
                  PageViewGeftWidget(
                      data: state.dataHot,
                      state: state.hotState,
                      message: state.hotMessage,
                      userCoins:
                          widget.myDataModel.myStore!.coins.toString(),
                      myData: widget.myDataModel),
                  PageViewGeftWidget(
                      data: state.dataCountry,
                      state: state.hotState,
                      message: state.hotMessage,
                      userCoins:
                          widget.myDataModel.myStore!.coins.toString(),
                      myData: widget.myDataModel)
                ]),
              ),
              GiftBottomBar(
                myDataModel: widget.myDataModel,
                roomData: widget.roomData,
              ),
            ],
          ));
    });
  }
}
