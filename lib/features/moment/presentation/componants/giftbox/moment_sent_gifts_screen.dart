
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_gift_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/sent_gift_screen_body.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_state.dart';

class MommentSentGiftScreen extends StatefulWidget {
  final String momentId;


  MommentSentGiftScreen({Key? key,required this.momentId}) : super(key: key);

  @override
  State<MommentSentGiftScreen> createState() => _MommentSentGiftScreenState();
}

class _MommentSentGiftScreenState extends State<MommentSentGiftScreen> {
  List<MomentGiftsModel> tempData = [];
  final ScrollController scrollController =ScrollController();


  @override
  void initState() {
    BlocProvider.of<GetMomentGiftsBloc>(context).add(
        GetMomentGiftsEvent(
            momentId: widget.momentId.toString()));
    super.initState();
    scrollController.addListener(scrollListener);
  }


  @override
  void dispose() {
    super.dispose();
    tempData.clear();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(
        height: ConfigSize.screenHeight!,


        child: BlocBuilder<GetMomentGiftsBloc, BaseGetMomentsGiftsStates>(
          builder: (context, state) {
            if (state is GetMomentsGiftsSuccessState) {
              tempData = state.data!;
              return SentGiftScreenBody(
                momentGiftsModelList: state.data!, momentId: widget.momentId,scrollController: scrollController,
              );
            } else if (state is GetMomentsGiftsloadingState) {
              if (tempData.isNotEmpty) {
                return SentGiftScreenBody(
                  momentGiftsModelList: tempData,momentId: widget.momentId,scrollController: scrollController,
                );
              } else {
                return SizedBox(
                    height: ConfigSize.screenHeight! * 0.78,
                    child: const LoadingWidget());
              }
            } else if (state is GetMomentsGiftsErrorState) {
              return CustomErrorWidget(
                message: state.errorMessage,
              );
            } else {
              return const CustomErrorWidget(message: StringManager.noDataFoundHere);
            }
          },
        ),
      ),
    );
  }
  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetMomentGiftsBloc>(context).add(
          LoadMoreMomentGiftsEvent(momentId: widget.momentId.toString()));
    } else {}
  }

}
