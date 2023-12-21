import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/medles%20screen/widgets/medles_tab_bar.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/medles%20screen/widgets/tab_bar_view.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/badges%20manager/badges_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/badges%20manager/badges_state.dart';

class MedlesScreen extends StatefulWidget {
  const MedlesScreen({Key? key}) : super(key: key);

  @override
  State<MedlesScreen> createState() => _MedlesScreenState();
}

class _MedlesScreenState extends State<MedlesScreen>
    with TickerProviderStateMixin {
  int tabIndex = 0;

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.addListener(() {
      setState(() {
        tabIndex = controller.index;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<GetBadgesBloc, GetBadgesStates>(
            builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 3.5,
              ),
              HeaderWithOnlyTitle(title: StringManager.meddles.tr()),
              Center(
                child: Container(
                  height: ConfigSize.screenHeight! * .65,
                  width: ConfigSize.screenWidth! * .9,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.whiteColor.withOpacity(.8)),
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
                  ),
                  child: BlurryContainer(
                    blur: 5,
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
                    child: Column(
                      children: [
                        SizedBox(
                            height: ConfigSize.defaultSize! * 5,
                            child: MedlesTabBar(
                              tabIndex: tabIndex,
                              titels: [
                                StringManager.room.tr(),
                                StringManager.payment.tr(),
                                StringManager.gift.tr()
                              ],
                              controller: controller,
                            )),
                        SizedBox(
                          height: ConfigSize.defaultSize! * 2,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller,
                            children: [
                              MedlesTabBarView(
                                type: '1',
                                getBadges: state.achievementBadge,
                                stateRequest: state.achievementBadgeRequest,
                                getBadgesMassage: state.achievementBadgeMessage,
                                index: 0,
                              ),
                              MedlesTabBarView(
                                type: '2',
                                getBadges: state.honorBadge,
                                stateRequest: state.honorBadgeRequest,
                                getBadgesMassage: state.honorBadgeMessage,
                                index: 1,
                              ),
                              MedlesTabBarView(
                                type: '3',
                                getBadges: state.activityBadge,
                                stateRequest: state.activityBadgeRequest,
                                getBadgesMassage: state.activityBadgeMessage,
                                index: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
