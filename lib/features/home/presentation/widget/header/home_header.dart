import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/header/live_tab_bar.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/home_show_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

final GlobalKey homeCacheKey = GlobalKey();

class HomeHeader extends StatefulWidget {
  final TabController liveController;

  const HomeHeader({
    required this.liveController,
    super.key,
    required this.cacheButton,
  });

  final Widget cacheButton;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LiveTabBAR(
          liveController: widget.liveController,
        ),
        widget.cacheButton,
        InkWell(
            onTap: () async {
              Navigator.pushNamed(context, Routes.searchScreen);
              // Navigator.pushNamed(context, Routes.searchScreen);
            },
            child: Image.asset(
              AssetsPath.searchIcon,
              scale: 2.5,
            )),
        BlocBuilder<GetMyDataBloc, GetMyDataState>(builder: (context, state) {
          return InkWell(
              onTap: () {
                if (MyDataModel.getInstance().hasRoom ?? false) {
                  Navigator.pushNamed(context, Routes.roomHandler,
                      arguments: RoomHandlerPramiter(
                          ownerRoomId: MyDataModel.getInstance().id.toString(),
                          myDataModel: MyDataModel.getInstance()));
                } else {
                  Navigator.pushNamed(context, Routes.createLive);
                }
              },
              child: Image.asset(
                AssetsPath.createLiveIcon,
                scale: 2.5,
              ));
        })
      ],
    );
  }
}
