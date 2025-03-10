import 'dart:developer';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/upload_video.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/user_reels_controller.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/lower/lower_body.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

class ReelsBox extends StatefulWidget {
  final ScrollController scrollController;
  final UserDataModel userDataModel;
  static Map<String, Uint8List> thumbnail = {};
  static Map<String, bool> likedVideos = {};
  static Map<String, int> likedVideoCount = {};
  static bool loading = false;
  final bool isMyVideos;

  const ReelsBox(
      {super.key,
      required this.userDataModel,
      required this.isMyVideos,
      required this.scrollController});

  @override
  State<ReelsBox> createState() => _ReelsBoxState();
}

class _ReelsBoxState extends State<ReelsBox> with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    if (LowerProfileBody.getUserReels) {
      ReelsBox.likedVideos.clear();
      ReelsBox.likedVideoCount.clear();
    }
    _controller = GifController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserReelsBloc, GetUserReelsState>(
      listener: (context, state) async {
        if (state is GetUserReelsSucssesState) {
          log(ReelsBox.likedVideos.toString());
          UserReelsController.getInstance.followMap(state.data!);
          UserReelsController.getInstance.likesUserMap(state.data!);
          UserReelsController.getInstance.likesCountUserMap(state.data!);
          for (int i = 0; i < state.data!.length; i++) {
            if (!ReelsBox.thumbnail.containsKey(state.data![i].id.toString())) {
              Uint8List thumbnailPath = await UserReelsController.getInstance
                  .getVideoThumbnail(state.data![i].url!);
              ReelsBox.thumbnail.putIfAbsent(
                  state.data![i].id.toString(), () => thumbnailPath);
            }
          }
        } else {}
      },
      builder: (context, state) {
        if (state is GetUserReelsSucssesState) {
          ReelsBox.loading = state.loadMore;
          return Column(
            children: [
              if (widget.isMyVideos)
                SizedBox(
                  width: ConfigSize.screenWidth,
                  height: ConfigSize.defaultSize! * 5,
                  child: Row(
                    children: [
                      SizedBox(
                          width: ConfigSize.screenWidth! -
                              ConfigSize.defaultSize! * 5,
                          height: ConfigSize.defaultSize! * 5,
                          child: HeaderWithOnlyTitle(
                            title: StringManager.myVideos.tr(),
                          )),
                      const UploadVideo(),
                    ],
                  ),
                ),
              Expanded(
                child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: widget.scrollController,
                    itemCount: ReelsBox.loading
                        ? state.data!.length + 1
                        : state.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.7,
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      if (index < state.data!.length) {
                        return InkWell(
                          onTap: () {
                            MainScreen.canNotPlayOutOfReelMainScreen = false;
                            ReelsPage.isFirst = true;
                            Navigator.pushNamed(context, Routes.userReelView,
                                arguments: ReelsUserPramiter(
                                    startIndex: index,
                                    userDataModel: widget.userDataModel));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(
                              children: [
                                CustoumCachedImage(
                                  url: state.data![index].img!,
                                  height: ConfigSize.screenHeight! * .2,
                                  width: ConfigSize.screenWidth! * .3,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ConfigSize.defaultSize! * 2),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.favorite,
                                            color: Colors.red,
                                            size: ConfigSize.defaultSize! * 2),
                                        SizedBox(
                                          width: ConfigSize.defaultSize! / 10,
                                        ),
                                        Material(
                                          elevation: 15,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black.withOpacity(0.3),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              ),
                                              margin: EdgeInsets.only(
                                                  bottom:
                                                      ConfigSize.defaultSize! -
                                                          8),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal:
                                                      ConfigSize.defaultSize!),
                                              child: Text(
                                                  state.data![index].likeNum
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: ConfigSize
                                                            .defaultSize!,
                                                      ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (state.data!.length % 3 != 0 &&
                            state.data!.length > 6 &&
                            ReelsBox.loading) {
                          return Center(
                              child: Text(
                            StringManager.loadingMore.tr(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ));
                        } else if (state.data!.isEmpty) {
                          return Center(
                            child: Text(
                              StringManager.noReels.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          );
                        } else if (ReelsBox.loading && state.data!.length > 6) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }
                    }),
              ),
              if (!ReelsBox.loading)
                Center(
                    child: Text(
                  StringManager.noMoreReels.tr(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            ],
          );
        } else if (state is GetUserReelsLoadingState) {
          return const LoadingWidget();
        } else if (state is GetReelUsersErrorState) {
          return CustomErrorWidget(
            message: state.errorMassage,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
