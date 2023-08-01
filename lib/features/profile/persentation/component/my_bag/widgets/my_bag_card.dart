
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_state.dart';

class MyBagCard extends StatefulWidget {
  static int? frameUsed;
  static int? entriesUsed;
  static int? bublesUsed;

  final String name;
  final String time;
  final String id;
  final String image;
  final String targetId;
  final int viewIndex;

  const MyBagCard(
      {required this.viewIndex,
      required this.id,
      required this.image,
      required this.name,
      required this.time,
      required this.targetId,
      super.key});

  @override
  State<MyBagCard> createState() => _MyBagCardState();
}

class _MyBagCardState extends State<MyBagCard> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UseItemBloc, UseItemState>(
      listener: (context, state) {
        if(state is UseItemLoadingState){
          loadingToast(context: context, title: StringManager.loading.tr());
        }else if (state is UseItemSuccseesState) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          if (widget.viewIndex == 0) {
            MyBagCard.frameUsed = state.data.targetId;
          } else if (widget.viewIndex == 1) {
            MyBagCard.entriesUsed = state.data.targetId;
          } else if (widget.viewIndex == 2) {
            MyBagCard.bublesUsed = state.data.targetId;
          }
          setState(() {});

          sucssesToast(context: context, title: state.data.message);
          //loadingToast(context: context, title: 'Loading...');
        } else if (state is UseItemErrorState) {
          errorToast(context: context, title: state.error);
        } else if (state is UnusedSucssesState) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          if (widget.viewIndex == 0) {
            MyBagCard.frameUsed = null;
          } else if (widget.viewIndex == 1) {
            MyBagCard.entriesUsed = null;
          } else if (widget.viewIndex == 2) {
            MyBagCard.bublesUsed = null;
          }
          setState(() {});

          sucssesToast(context: context, title: state.massage);
        } else if (state is UnusedErrorState) {
          errorToast(context: context, title: state.massage);
        }else if(state is UnusedloadingState){
          loadingToast(context: context, title: StringManager.loading);
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            left: ConfigSize.defaultSize!,
            right: ConfigSize.defaultSize!,
            bottom: ConfigSize.defaultSize! * 1.2),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize!,
            ),
            CustoumCachedImage(
              height: ConfigSize.defaultSize! * 7,
              width: ConfigSize.defaultSize! * 7,
              url: widget.image,
              radius: ConfigSize.defaultSize!,
            ),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              widget.time.substring(0, 10),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            (MyBagCard.frameUsed.toString() != widget.targetId &&
                    MyBagCard.entriesUsed.toString() != widget.targetId &&
                    MyBagCard.bublesUsed.toString() != widget.targetId)
                ? MainButton(
                    title: StringManager.use,
                    onTap: () {
                      BlocProvider.of<UseItemBloc>(context)
                          .add(UserItemsEvent(id: widget.id));
                    },
                    width: ConfigSize.defaultSize! * 7,
                    height: ConfigSize.defaultSize! * 2,
                    titleSize: ConfigSize.defaultSize! * 1.4,
                  )
                : MainButton(
                  buttonColor: ColorManager.bageGriedinet,
                    title: StringManager.takeOff,
                    onTap: () {
                      if (widget.viewIndex == 0) {
                        BlocProvider.of<UseItemBloc>(context)
                            .add(const UnUsedItemEvent(id: "1"));
                      } else if (widget.viewIndex == 1) {

                          BlocProvider.of<UseItemBloc>(context)
                            .add(const UnUsedItemEvent(id: "3"));
                      } else if (widget.viewIndex == 2) {
                            BlocProvider.of<UseItemBloc>(context)
                            .add(const UnUsedItemEvent(id: "2"));
                      }
                    },
                    width: ConfigSize.defaultSize! * 7,
                    height: ConfigSize.defaultSize! * 2,
                    titleSize: ConfigSize.defaultSize! * 1.4,
                  )
          ],
        ),
      ),
    );
  }
}
