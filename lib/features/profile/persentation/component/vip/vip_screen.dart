import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_states.dart';

import 'widgets/vip_tab_view.dart';
import 'widgets/vip_tabs.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> with TickerProviderStateMixin {
  late TabController vipContriller;
  @override
  void initState() {
    vipContriller = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    vipContriller.dispose();
    super.dispose();
  }

  List<String> vipBage = [
    AssetsPath.kinghtIcon,
    AssetsPath.baronIcon,
    AssetsPath.viscount,
    AssetsPath.count,
    AssetsPath.marquis,
    AssetsPath.duke,
    AssetsPath.king,
    AssetsPath.superKing,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuyOrSendVipBloc, BuyOrSendVipState>(
      listener: (context, state) {
        if(state is BuyOrSendVipSucssesState){
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          sucssesToast(context: context, title: state.massage);
        }else if (state is BuyOrSendVipLoadingState){
        //  loadingToast(context: context, title: StringManager.loading.tr());
        }else if (state is BuyOrSendVipErrorState){
          errorToast(context: context, title: state.error);
        }


      },
      child: Scaffold(
        body: ScreenBackGround(
            image: AssetsPath.vipBackGround,
            child: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize! * 3.5,
                ),
                 HeaderWithOnlyTitle(
                  title: StringManager.aristocracy.tr(),
                  titleColor: Colors.white,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                ),
                VipTabs(
                  vipContriller: vipContriller,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 5,
                ),
                Expanded(
                  child: BlocBuilder<VipCenterBloc, VipStates>(
                    builder: (context, state) {
                      if (state is VipStatesSuccessState) {
                        return TabBarView(controller: vipContriller, children: [
                          for (int i = 0; i < 8; i++)
                            VipTabView(
                              vipData: state.vipData[i],
                              vipIcon: vipBage[i],
                            ),
                        ]);
                      } else if (state is VipStatesLoadingState) {
                        return const LoadingWidget();
                      } else if (state is VipStatesErrorState) {
                        return CustomErrorWidget(message: state.message);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
