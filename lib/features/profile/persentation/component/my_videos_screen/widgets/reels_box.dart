import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/lower/lower_body.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';

class ReelsBox extends StatefulWidget {
  final ScrollController scrollController;
  final UserDataModel userDataModel;
  static Map<String, Uint8List> thumbnail = {};
  static Map<String, bool> likedVideos = {};
  static Map<String, int> likedVideoCount = {};

  const ReelsBox(
      {super.key, required this.userDataModel, required this.scrollController});

  @override
  State<ReelsBox> createState() => _ReelsBoxState();
}

class _ReelsBoxState extends State<ReelsBox> {

  @override
  void initState() {
    if(LowerProfileBody.getUserReels){
      log("heeeeeeeeeeeer");
 ReelsBox.likedVideos.clear();
    ReelsBox.likedVideoCount.clear();
    }
   

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserReelsBloc, GetUserReelsState>(
      listener: (context, state) async {
        if (state is GetUserReelsSucssesState) {
          log(ReelsBox.likedVideos.toString());
          ReelsController().followMap(state.data!);

          ReelsController().likesUserMap(state.data!);
          ReelsController().likesCountUserMap(state.data!);
          for (int i = 0; i < state.data!.length; i++) {
            if (!ReelsBox.thumbnail.containsKey(state.data![i].id.toString())) {
              Uint8List thumbnailPath = await ReelsController().getVideoThumbnail(state.data![i].url!);
              ReelsBox.thumbnail.putIfAbsent(state.data![i].id.toString(), () => thumbnailPath);
            }
          }

          log(ReelsBox.likedVideos.toString()+"zzzzzzzzz");
        } else {}
      },
      builder: (context, state) {
        if (state is GetUserReelsSucssesState) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: widget.scrollController,
                    itemCount: state.loadMore? state.data!.length + 1 : state.data!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.7,
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      if (index < state.data!.length) {
                        return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.userReelView,
                              arguments: ReelsUserPramiter(
                                  startIndex: index,
                                  userDataModel: widget.userDataModel));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: state.data![index].subVideo == ""
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.fill,
                                      image: CachedNetworkImageProvider(ConstentApi()
                                          .getImage(state.data![index].subVideo)))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! - 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.favorite,
                                    color: Colors.red,
                                    size: ConfigSize.defaultSize! * 2),
                                SizedBox(
                                  width: ConfigSize.defaultSize! / 10,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: ConfigSize.defaultSize! - 8),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1,
                                        horizontal: ConfigSize.defaultSize!),
                                    child: Text(state.data![index].likeNum.toString(),
                                        style: const TextStyle(fontSize: 10))),
                              ],
                            ),
                          ),
                        ),
                      );
                      }else{
                        if(state.data!.length % 3 != 0){
                          return const Center(child: Text("Loading More", style: TextStyle(color: Colors.black, fontSize: 16),));
                        }else if(state.loadMore){
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                    }),
              ),
              if(!state.loadMore) const Center(child: Text("No More Reels", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),)),
            ],
          );
        } else if (state is GetUserReelsLoadingState) {
          return const LoadingWidget();
        } else if (state is GetReelUsersErrorState) {
          return CustomErrorWidget(
            message: state.errorMassage,
          );
        } else {
          return CustomErrorWidget(
            message: StringManager.unexcepectedError.tr(),
          );
        }
      },
    );
  }
}
