import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/custom_avatar.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_event.dart';

class SendItemWidget extends StatefulWidget {
  SendItemWidget({required this.itemId, super.key});

  final String itemId;
  int page = 1;

  @override
  State<SendItemWidget> createState() => _SendItemWidgetState();
}

class _SendItemWidgetState extends State<SendItemWidget> {
  final ScrollController scrollController = ScrollController();
  TextEditingController? idController;



  @override
  void initState() {
    idController = TextEditingController();
    scrollController.addListener(scrollListener);
    BlocProvider.of<SearchBloc>(context).add(SearchInitEvent());
    BlocProvider.of<GetFollowerOrFollowingBloc>(context)
        .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '3'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.whiteColor,
      body: Column(
        children: [
          Text(
            StringManager.enterUserID.tr(),
            style: const TextStyle(color: ColorManager.gray),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 5.0,
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorManager.gray,
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(
                vertical: ConfigSize.defaultSize! * 0.8,
                horizontal: ConfigSize.defaultSize! * 3.1),
            child: TextField(
              onChanged: ((value) {
                setState(() {});
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchEvent(keyWord: value.toString()));
              }),
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: ConfigSize.defaultSize! * 1.9),
              cursorColor: ColorManager.mainColor,
            ),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.1,
          ),
          if (idController!.text.isEmpty)
            SizedBox(
              height: ConfigSize.defaultSize! * 39,
              child: BlocBuilder<GetFollowerOrFollowingBloc,
                  GetFollowerOrFollowingState>(
                builder: (context, state) {
                  if (state is GetFollowerOrFollowingSucssesState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 50,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: context
                                .read<GetFollowerOrFollowingBloc>()
                                .isLoadingMore
                            ? state.data!.length + 1
                            : state.data!.length,
                        // shrinkWrap: true,
                        padding: const EdgeInsets.all(5),
                        itemBuilder: (context, index) {
                          if (index < state.data!.length) {
                            return UserInfoRow(
                              userData: UserDataModel(
                                id: state.data![index].id,
                                isGold: state.data![index].isGold,
                                vip1: state.data![index].vip1,
                                profile: state.data![index].profile,
                                frame: state.data![index].frame,
                                frameId: state.data![index].frameId,
                                hasColorName: state.data![index].hasColorName,
                                name: state.data![index].name,
                                level: state.data![index].level,
                                isCountryHiden: state.data![index].isCountryHiden,
                                uuid: state.data![index].uuid,
                              ),
                              flag: 'myLook',
                              itemId: widget.itemId,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                        // separatorBuilder: (BuildContext context, int index) {
                        //   return const Divider();
                        // },
                      ),
                    );
                  } else if (state is GetFollowerOrFollowingLoadingState) {
                       return const Scaffold(
                        body: Center(
                          child: LoadingWidget(),
                        ),
                      );
                    // if (widget.page == 1) {
                   
                    // } else {
                    //   return SizedBox(
                    //     height: MediaQuery.of(context).size.height - 50,
                    //     child: ListView.builder(
                    //       controller: scrollController,
                    //       itemCount: context
                    //               .read<GetFollowerOrFollowingBloc>()
                    //               .isLoadingMore
                    //           ? state.oldData!.length + 1
                    //           : state.oldData!.length,
                    //       // shrinkWrap: true,
                    //       padding: const EdgeInsets.all(5),
                    //       itemBuilder: (context, index) {
                    //         if (index < state.oldData!.length) {
                    //           return ListTile(
                    //             onTap: () {
                    //               Navigator.pushNamed(
                    //                   context, Routes.userProfile,
                    //                   arguments: UserProfilePramiter(
                    //                       userId: state.oldData![index].id!,
                    //                       myName: ""));
                    //             },
                    //             leading: SizedBox(
                    //               width: ConfigSize.defaultSize! * 8.9,
                    //               child: Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: ConfigSize.defaultSize! * 0.6,
                    //                   ),
                    //                   CustomAvtare(
                    //                     image: ConstentApi().getImage(state
                    //                         .oldData![index].profile?.image),
                    //                     size: ConfigSize.defaultSize! * 5.3,
                    //                     border: 2,
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             title: Text(
                    //               state.oldData![index].name!,
                    //               style: TextStyle(
                    //                   fontSize: ConfigSize.defaultSize! * 1.5,
                    //                   color: const Color(0xff262628)),
                    //             ),
                    //             subtitle: Padding(
                    //                 padding: EdgeInsets.only(
                    //                     top: ConfigSize.defaultSize! * 0.7),
                    //                 child: Row(
                    //                   children: [
                    //                     SizedBox(
                    //                       width: ConfigSize.defaultSize! * 0.5,
                    //                     ),
                    //                     SizedBox(
                    //                       width: ConfigSize.defaultSize! * 0.3,
                    //                     ),
                    //                     UserLevelContainer(
                    //                       height: ConfigSize.defaultSize! * 2.1,
                    //                       width: ConfigSize.defaultSize! * 4.2,
                    //                       image: ConstentApi().getImage(state
                    //                           .oldData![index]
                    //                           .level!
                    //                           .senderImage),
                    //                     ),
                    //                     SizedBox(
                    //                       width: ConfigSize.defaultSize! * 0.3,
                    //                     ),
                    //                     HostLevelContainer(
                    //                       height: ConfigSize.defaultSize! * 2.1,
                    //                       width: ConfigSize.defaultSize! * 4.2,
                    //                       image: ConstentApi().getImage(state
                    //                           .oldData![index]
                    //                           .level!
                    //                           .receiverImage),
                    //                     ),
                    //                     const Spacer(),
                    //                     InkWell(
                    //                       onTap: () {
                    //                         // widget._key.currentState!.setstate();
                    //                         BlocProvider.of<SendBloc>(context)
                    //                             .add(sendItemEvent(
                    //                                 packId: widget.itemId,
                    //                                 touId: state.oldData![index]
                    //                                     .uuid!));

                    //                         Navigator.pop(context);
                    //                       },
                    //                       child: Container(
                    //                         width:
                    //                             ConfigSize.defaultSize! * 8.1,
                    //                         height:
                    //                             ConfigSize.defaultSize! * 3.1,
                    //                         decoration: BoxDecoration(
                    //                             gradient: const LinearGradient(
                    //                                 colors:
                    //                                     ColorManager.mainColor),
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20)),
                    //                         child: Center(
                    //                           child: Text(
                    //                             StringManager.send.tr(),
                    //                             style: const TextStyle(
                    //                                 color: ColorManager
                    //                                     .whiteColor),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 )),
                    //             selected: false,
                    //           );
                    //         } else {
                    //           return const Center(
                    //             child: CircularProgressIndicator(),
                    //           );
                    //         }
                    //       },
                    //       // separatorBuilder: (BuildContext context, int index) {
                    //       //   return const Divider();
                    //       // },
                    //     ),
                    //   );
                    // }
                  } else if (state is GetFollowerOrFollowingErrorState) {
                    return Scaffold(
                      body: Center(
                        child: Text(state.errorMassage),
                      ),
                    );
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: Text("UnExcpected Error"),
                      ),
                    );
                  }
                },
              ),
            ),
          BlocBuilder<SearchBloc, SearchStates>(
            builder: (context, state) {
              if (state is SuccessSearchStates) {
                return SizedBox(
                  height: ConfigSize.defaultSize! * 19.1,
                  child: ListView.builder(
                      itemCount: state.data.userModel.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            CustomAvtare(
                              image: state.data.userModel[index].profile!.image!,
                              size: ConfigSize.defaultSize! * 6.1,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              state.data.userModel[index].name!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ConfigSize.defaultSize! * 1.7),
                            ),
                            const Spacer(
                              flex: 10,
                            ),
                          ],
                        );
                      }),
                );
              } else {
                return Container();
              }
            },
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 1.9,
          ),
          Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () {
                  // widget._key.currentState!.setstate();
                  BlocProvider.of<SendBloc>(context).add(sendItemEvent(
                      packId: widget.itemId, touId: idController!.text));

                  Navigator.pop(context);
                },
                child: Container(
                  width: ConfigSize.defaultSize! * 14.1,
                  height: ConfigSize.defaultSize! * 4.1,
                  decoration: BoxDecoration(
                      gradient:
                          const LinearGradient(colors: ColorManager.mainColorList),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      StringManager.confirm.tr(),
                      style: const TextStyle(color: ColorManager.whiteColor),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: ConfigSize.defaultSize! * 14.8,
                  height: ConfigSize.defaultSize! * 4.1,
                  decoration: BoxDecoration(
                      color: ColorManager.gray,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      StringManager.cancle.tr(),
                      style: const TextStyle(color:Colors.black),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void scrollListener() {
    log("papapapapap");
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      log("papapapapap22222222");

      widget.page++;
      BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
          GetMoreFriendsOrFollowersOrFollwothemEvent(
              type: '3', page: widget.page.toString()));
    } else {}
  }
}
