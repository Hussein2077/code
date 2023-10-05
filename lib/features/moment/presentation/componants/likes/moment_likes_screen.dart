import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_state.dart';

import 'widgets/moment_like_row.dart';

class MomentsLikesScreen extends StatefulWidget {
  final String momentId;

  const MomentsLikesScreen({
    required this.momentId,
    super.key,
  });
  @override
  State<MomentsLikesScreen> createState() => MomentsLikesScreenState();
}

class MomentsLikesScreenState extends State<MomentsLikesScreen> {
  List<MomentLikeModel>? likesListTemp = [];
  TextEditingController likesController = TextEditingController(text: '');
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<GetMomentLikesBloc>(context)
        .add(GetMomentLikesEvent(momentId: widget.momentId.toString()));
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    likesListTemp!.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: ConfigSize.screenHeight!,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize! * 3,
                ),
                Row(
                  children: [
                    const Spacer(flex: 1,),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
                    const Spacer(flex: 4,),
                    Text(StringManager.comments,style: Theme.of(context).textTheme.titleLarge,),
                    const Spacer(flex: 5,),
                  ],
                ),
                BlocBuilder<GetMomentLikesBloc, GetMomentLikesState>(
                  builder: (context, state) {
                    if (state is GetMomentLikeSucssesState) {
                      likesListTemp = state.data;
                      return SizedBox(
                        width: ConfigSize.screenWidth!,
                        height: ConfigSize.screenHeight! * 0.88,
                        child: Column(
                          children: [
                            Container(
                              height: ConfigSize.screenHeight! * 0.82,
                              padding: EdgeInsets.only(
                                left: ConfigSize.defaultSize!,
                                right: ConfigSize.defaultSize!,
                              ),
                              child: state.data!.isNotEmpty
                                  ? MomentLikes(
                                      scrollController: scrollController,
                                      momentLikeModelList:
                                           state.data!,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Text(
                                            StringManager.thisMoment.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ]),
                            ),
                          ],
                        ),
                      );
                    }
                    else if (state is GetMomentLikeErrorState) {
                      return CustomErrorWidget(
                        message: state.errorMassage,
                      );
                    } else if (state is GetMomentLikeLoadingState) {
                      if (likesListTemp!.isEmpty) {
                        return SizedBox(
                            height: ConfigSize.screenHeight! * 0.88,
                            child: const LoadingWidget());
                      } else {
                        return SizedBox(
                          width: ConfigSize.screenWidth!,
                          height: ConfigSize.screenHeight! * 0.88,
                          child: Column(
                            children: [
                              Container(
                                  height: ConfigSize.screenHeight! * 0.82,
                                  padding: EdgeInsets.only(
                                    left: ConfigSize.defaultSize!,
                                    right: ConfigSize.defaultSize!,
                                  ),
                                  child:  MomentLikes(
                                    scrollController: scrollController,
                                    momentLikeModelList:
                                    likesListTemp ?? state.data!,
                                  )
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return const CustomErrorWidget(
                          message: StringManager.noDataFoundHere);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetMomentLikesBloc>(context).add(
          GetMoreMomentLikesEvent(momentId: widget.momentId.toString()));
    } else {}
  }
}
