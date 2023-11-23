import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/Dailog_Method.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/mian_button_for_mybag.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/my_bag_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/widgets/my_bag_tab_view.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/widgets/send_item_widget.dart';
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
  final int isFirst;
  final int index;
  bool? isTrue;

  MyBagCard(
      {required this.viewIndex,
      required this.id,
      this.isTrue,
      required this.image,
      required this.index,
      required this.name,
      required this.time,
      required this.isFirst,
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
        if (state is UseItemLoadingState) {
          widget.isTrue = false;
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is UseItemSuccseesState) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          MyBagScreen.isUsed.add(state.data.targetId.toString());

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
        } else if (state is UnusedloadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          left: ConfigSize.defaultSize!,
          right: ConfigSize.defaultSize!,
        ),
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
              widget.time == '0'
                  ? ''
                  : Methods.instance.formatDateTime(
                      dateTime: widget.time,
                      locale: context.locale.languageCode),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  (MyBagCard.frameUsed.toString() != widget.targetId &&
                          MyBagCard.entriesUsed.toString() != widget.targetId &&
                          MyBagCard.bublesUsed.toString() != widget.targetId)
                      ? Expanded(
                          child: MainButtonForMyBag(
                            title: StringManager.use.tr(),
                            onTap: () {
                              BlocProvider.of<UseItemBloc>(context)
                                  .add(UserItemsEvent(id: widget.id));
                            },
                            titleSize: ConfigSize.defaultSize! * 1.4,
                          ),
                        )
                      : Expanded(
                          child: MainButtonForMyBag(
                            buttonColor: ColorManager.bageGriedinet,
                            title: StringManager.takeOff.tr(),
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
                            titleSize: ConfigSize.defaultSize! * 1.4,
                          ),
                        ),
                  SizedBox(width: ConfigSize.defaultSize!),
                  (widget.isFirst == 1 ||
                          MyBagScreen.isUsed.contains(widget.targetId))
                      ? const SizedBox()
                      : Expanded(
                          child: MainButtonForMyBag(
                            buttonColor: ColorManager.bageGriedinet,
                            title: StringManager.send.tr(),
                            onTap: () {
                              dailogRoom(
                                  context: context,
                                color: Theme.of(context).colorScheme.onBackground,

                                widget: SizedBox(
                                      height: ConfigSize.defaultSize! * 63.5,
                                      child: SendItemWidget(itemId: widget.id)),
                                  );
                              MyBagTabView.itemIndex = widget.index;
                            },
                            // width: ConfigSize.defaultSize! * 18,

                            titleSize: ConfigSize.defaultSize! * 1.4,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
