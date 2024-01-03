import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/add_theme_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';

class BackGround extends StatefulWidget {
  final String ownerId;

  const BackGround({required this.ownerId, super.key});

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  List<BackGroundModel> backGround = [];
  int count = 0;

  @override
  void initState() {
    BlocProvider.of<OnRoomBloc>(context).add(GetBackGroundEvent());
    BlocProvider.of<GetMyBackgroundBloc>(context).add(GetMyBackGroundEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomBackgroundBloc, AddRoomBackgroundState>(
      listener: (context, state) {
        if (state is AddRoomBackgroundSucsses) {
          sucssesToast(
              context: context, title: StringManager.yourThemeIsUpload.tr());


          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (state is AddRoomBackgroundLoading) {
          loadingToast(context: context, title: '');
        } else if (state is AddRoomBackgroundError) {
          errorToast(context: context, title: state.error);
        }
      },
      builder: (context, state) {
        return BlocBuilder<OnRoomBloc, OnRoomStates>(
          builder: (context, state) {
            if (state is GetBackGroundloadingState) {
              return TransparentLoadingWidget(
                height: ConfigSize.defaultSize! * 2,
                width: ConfigSize.defaultSize! * 7.2,
              );
            } else if (state is GetBackGroundSucsseState) {
              count = state.data.length;
              backGround = state.data;
              return BlocBuilder<GetMyBackgroundBloc, GetMyBackgroundState>(
                builder: (context, state) {
                  if (state is GetMyBackgroundSucssesState) {
                    backGround = backGround + state.data;
                    return Container(
                        height: ConfigSize.screenHeight! * .5,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppPadding.p18),
                                topLeft: Radius.circular(AppPadding.p18))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<AddRoomBackgroundBloc,
                                AddRoomBackgroundState>(
                              builder: (context, state) {
                                if (state is AddRoomBackgroundSucsses) {
                                  return SizedBox(
                                    height: ConfigSize.defaultSize! * 5,
                                    width: MediaQuery.of(context).size.width,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Theme.of(context).iconTheme.color,
                                          size: ConfigSize.defaultSize! * 3,
                                        ),
                                        onPressed: () async {
                                          // await getImage();

                                          bottomDailog(
                                              context: context,
                                              widget: const AddThemeImage());
                                        }),
                                  );
                                } else {
                                  return SizedBox(
                                    height: ConfigSize.defaultSize! * 5,
                                    width: MediaQuery.of(context).size.width,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Theme.of(context).iconTheme.color,
                                          size: ConfigSize.defaultSize! * 3,
                                        ),
                                        onPressed: () async {
                                          // await getImage();

                                          bottomDailog(
                                              context: context,
                                              widget: const AddThemeImage());
                                        }),
                                  );
                                }
                              },
                            ),
                            Expanded(
                              child: GridView.count(
                                // physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                crossAxisCount: 3,
                                children: List.generate(
                                    backGround.length,
                                    (index) => Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: InkWell(
                                            onTap: () {
                                              BlocProvider.of<OnRoomBloc>(
                                                      context)
                                                  .add(UpdateRoom(
                                                      change: index < count
                                                          ? "app"
                                                          : "me",
                                                      ownerId: widget.ownerId,
                                                      roomBackgroundId:
                                                          backGround[index]
                                                              .id
                                                              .toString()));
                                              Navigator.pop(context);
                                            },
                                            child: ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(ConfigSize
                                                            .defaultSize! *
                                                        2),
                                                child: CustoumCachedImage(
                                                    height:
                                                        ConfigSize
                                                                .defaultSize! *
                                                            28,
                                                    width: ConfigSize
                                                            .defaultSize! *
                                                        28,
                                                    url:
                                                        backGround[index].img)),
                                          ),
                                        )),
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return const SizedBox();
                  }
                },
              );
            } else if (state is GetBackGroundErrorState) {
              return CustomErrorWidget(message: state.errorMassage);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
// Widget BackGround(BuildContext context, int roomId) {

// }
