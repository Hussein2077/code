import 'dart:developer';

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
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';

class ReelsBox extends StatelessWidget {
    final ScrollController scrollController ; 
  final UserDataModel userDataModel;
  const ReelsBox({super.key, required this.userDataModel, required this.scrollController});
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetUserReelsBloc, GetUserReelsState>(
      builder: (context, state) {
        if (state is GetUserReelsSucssesState) {
          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller:scrollController ,
              itemCount: state.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.7,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.userReelView,
                        arguments: ReelsUserPramiter(startIndex: index,
                            userDataModel: userDataModel));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                                            color: Colors.grey,

                      image:state.data![index].subVideo==""?null: DecorationImage(
                fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(

                    ConstentApi().getImage(state.data![index].subVideo)) )
                  ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize! - 5
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite, color: Colors.red,
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
                                  bottom: ConfigSize.defaultSize! - 8
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: ConfigSize.defaultSize!
                              ),
                              child: Text(state.data![index].likeNum.toString(),
                                  style: const TextStyle(fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else if (state is GetUserReelsLoadingState) {
          return const LoadingWidget();
        } else if (state is GetReelUsersErrorState) {
          return CustomErrorWidget(message: state.errorMassage,);
        } else {
          return
            CustomErrorWidget(
            message: StringManager.unexcepectedError.tr(),);
        }
      },
    );
  }


}