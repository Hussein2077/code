import 'dart:developer';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/arrow_back.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/get_group_massage/get_group_massage_bloc.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/get_group_massage/get_group_massage_event.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/get_group_massage/get_group_massage_state.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/manager_post_group_Chat/post_group_chat_bloc.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/manager_post_group_Chat/post_group_chat_event.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/manager_post_group_Chat/post_group_chat_state.dart';
import 'package:tik_chat_v2/features/chat/data/data_source/remoted_dataSource_chat.dart';
import 'package:tik_chat_v2/features/chat/data/models/group_chat_model.dart';

import '../../../../../../core/utils/config_size.dart';
import 'widget/group_chat_row.dart';

class GroupChatScreen extends StatefulWidget {
  GroupChatScreen({super.key});

  int page = 1;
  int isFirst = 0;
  List<GroupChatModel>? tempData;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController massageCotroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    BlocProvider.of<GetGroupMassageBloc>(context).add(GetGroupMassageEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(StringManager.toSendMassage.tr());
    return BlocConsumer<PostGroupChatBloc, GroupChatState>(
      listener: (context, state) {
        if (state is PostGroupChatSucsses) {
          widget.page = 1;
          BlocProvider.of<GetGroupMassageBloc>(context)
              .add(GetGroupMassageEvent());
        } else if (state is PostGroupChatError) {
          errorToast(context: context, title: state.error);

        }
      },
      builder: (context, state) {
        return BlocBuilder<GetGroupMassageBloc, GetGroupMassageState>(
          builder: (context, state) {
            if (state is GetGroupMassageSucsses) {
              widget.isFirst++;
              widget.tempData = state.data;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor:ColorManager.whiteColor ,
                  leading: const ArrowBack(),
elevation: 0,
                  title: Text(
                    StringManager.groupChat.tr(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: ConfigSize.defaultSize! * 2,
                    ),
                  ),
                  centerTitle: true,
                ),
                backgroundColor: ColorManager.whiteColor,
                body: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: state.data!.isEmpty ? 0 : 20.0,
                            vertical: 10),
                        child: Column(
                          children: [
                            state.data!.isEmpty
                                ? Container(
                                    color: ColorManager.orang,
                                    width: MediaQuery.of(context).size.width,
                                    height: ConfigSize.defaultSize! * 78,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height:
                                                ConfigSize.defaultSize! * 20,
                                            child: Image.asset(
                                                AssetsPath.emptyScreen)),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        controller: scrollController,

                                        // primary: true,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: false,
                                        itemCount: context
                                                .read<GetGroupMassageBloc>()
                                                .isLoadingMore
                                            ? state.data!.length + 1
                                            : state.data!.length,
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                          if (index < state.data!.length) {
                                            return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: ConfigSize
                                                        .defaultSize!),
                                                child: GroupChatRow(
                                                  userData: state.data![index],
                                                ));
                                          } else {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  top: ConfigSize.defaultSize! *
                                                      5),
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      ConfigSize.defaultSize! *
                                                          5),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                            const SizedBox(
                              height: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: massageCotroller,
                              decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  fillColor: const Color(0xfff1f2f6),
                                  hintText:
                                      " ${StringManager.youWillSpend.tr()} ${RemotedDataSourceChat.massagePrice}  ${StringManager.toSendMassage.tr()}",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xfff1f2f6)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color(0xfff1f2f6)),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: ColorManager.orang,
                            radius: 23,
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<PostGroupChatBloc>(context)
                                      .add(PostGroupChatEvent(
                                          massage: massageCotroller.text));
                                  massageCotroller.clear();
                                },
                                icon: const Icon(
                                  Icons.send,
                                  size: 26,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is GetGroupMassageLoading) {
              if (widget.isFirst == 0) {
                return const Scaffold(body: Center(child: LoadingWidget()));
              } else {
                return Scaffold(
                    backgroundColor: ColorManager.whiteColor,
                    body: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      controller: scrollController,

                                      // primary: true,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: false,
                                      itemCount: context
                                              .read<GetGroupMassageBloc>()
                                              .isLoadingMore
                                          ? widget.tempData!.length + 1
                                          : widget.tempData!.length,
                                      reverse: true,
                                      itemBuilder: (context, index) {
                                        if (index < widget.tempData!.length) {
                                          return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      ConfigSize.defaultSize!),
                                              child: GroupChatRow(
                                                userData:
                                                    widget.tempData![index],
                                              ));
                                        } else {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: ConfigSize.defaultSize! *
                                                    5),
                                            margin: EdgeInsets.symmetric(
                                                vertical:
                                                    ConfigSize.defaultSize! *
                                                        5),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: massageCotroller,
                                  decoration: InputDecoration(
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 10.0),
                                      fillColor: const Color(0xfff1f2f6),
                                      hintText:
                                          " ${StringManager.youWillSpend.tr()} ${RemotedDataSourceChat.massagePrice} ${StringManager.toSendMassage.tr()}",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xfff1f2f6)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color(0xfff1f2f6)),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: ColorManager.orang,
                                radius: 23,
                                child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<PostGroupChatBloc>(
                                              context)
                                          .add(PostGroupChatEvent(
                                              massage: massageCotroller.text));
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      size: 26,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              }
            } else if (state is GetGroupMassageError) {
              return Scaffold(
                  body: Center(
                      child: CustomErrorWidget(message: state.errorMassage)));
            } else {
              return Scaffold(
                  body: Center(
                      child: CustomErrorWidget(
                          message: StringManager.unexcepectedError.tr())));
            }
          },
        );
      },
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
  loadingToast(context: context) ;
      widget.page++;
      BlocProvider.of<GetGroupMassageBloc>(context)
          .add(GetMoreGroupMassageEvent(page: widget.page.toString()));
    }
  }
}
