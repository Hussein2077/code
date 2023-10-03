
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_view_biger.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';
import 'package:blurrycontainer/blurrycontainer.dart';


class GiftScreen extends StatefulWidget {
  final MyDataModel  myDataModel;
  final EnterRoomModel roomData;
  final List<ZegoUIKitUser> listUsers;
  final List<ZegoUIKitUser> listAllUsers;
  const GiftScreen(
      {required this.myDataModel,
      required this.listAllUsers,
      required this.roomData,
      required this.listUsers,
      super.key});
  static int giftId = 0;
  static int giftPrice = 0;
  static int numOfGift = -1;

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> with TickerProviderStateMixin {
  TabController? giftControler;

  @override
  void initState() {
    super.initState();
    giftControler = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftBloc, GiftsStates>(builder: (context, state) {
      return BlurryContainer(
        blur: 8,
        elevation: 0,
        height: ConfigSize.screenHeight! / 2.1,
        width: double.infinity,
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.all(0),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14), topRight: Radius.circular(14)),
        child: Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                ValueListenableBuilder<Map<int, ZegoUIKitUser>>(
                    valueListenable: RoomScreen.userOnMics,
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      List<ZegoUIKitUser> usersInMic =
                          RoomScreen.userOnMics.value.values.toList();
                      return GiftUser(
                        listUsers: usersInMic,
                        listAllUsers: widget.listAllUsers,
                        ownerId: widget.roomData.ownerId.toString(),
                      );
                    }),
                TabBar(
                  isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    controller: giftControler,
                    padding: EdgeInsets.zero,
                    automaticIndicatorColorAdjustment: false,
                    tabs: [
                        Text(
                        StringManager.appGift.tr(),
                        style:
                            const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(StringManager.spicalGift.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600)),
                      Text(StringManager.country.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600)),
                      Text(StringManager.famousGifts.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600)
                      ),
                      Text(StringManager.luckyGifts.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600)

                      )

                    ]),
                Expanded(
                  child: TabBarView(
                    
                    controller: giftControler, children: [
                    PageViewGeftWidget(
                      data: state.dataNormal,
                      state: state.normalState,
                      message: state.normalMessage,
                      userCoins:
                          widget.myDataModel.myStore?.coins.toString()??'',
                         myData:widget.myDataModel
                    ),
                    PageViewGeftWidget(
                      data: state.dataHot,
                      state: state.hotState,
                      message: state.hotMessage,
                      userCoins:
                          widget.myDataModel.myStore?.coins.toString()??'', myData:widget.myDataModel,
                    ),
                    PageViewGeftWidget(
                      data: state.dataCountry,
                      state: state.countryState,
                      message: state.countryMessage,
                      userCoins:
                          widget.myDataModel.myStore?.coins.toString()??'',
                         myData:widget.myDataModel
                    ),
                    PageViewGeftWidget(
                        data: state.dataFamous,
                        state: state.famousState,
                        message: state.famousMessage,
                        userCoins:
                        widget.myDataModel.myStore?.coins.toString()??'',
                        myData:widget.myDataModel
                    ),
                    PageViewGeftWidget(
                        data: state.dataLucky,
                        state: state.luckyState,
                        message: state.luckyMessage,
                        userCoins:
                        widget.myDataModel.myStore?.coins.toString()??'',
                        myData:widget.myDataModel
                    )
                  ]),
                ),
                GiftBottomBar(
                  myDataModel: widget.myDataModel,
                  roomData: widget.roomData,
                ),
              ],
            )),
      );
    });
  }
}
