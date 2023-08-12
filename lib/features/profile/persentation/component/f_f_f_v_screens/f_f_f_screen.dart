
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_state.dart';

// ignore: must_be_immutable
class FFFScreen extends StatefulWidget {
  final String title;
  int page = 1;

  FFFScreen({required this.title, super.key});

  @override
  State<FFFScreen> createState() => _FFFScreenState();
}

class _FFFScreenState extends State<FFFScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(scrollListener);

    if (widget.title == StringManager.friends) {
      BlocProvider.of<GetFollowerOrFollowingBloc>(context)
          .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '3'));
    } else if (widget.title == StringManager.followers) {
      BlocProvider.of<GetFollowerOrFollowingBloc>(context)
          .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '1'));
    } else {
      BlocProvider.of<GetFollowerOrFollowingBloc>(context)
          .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '2'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.2,
          ),
          HeaderWithOnlyTitle(title: widget.title),
         BlocBuilder<GetFollowerOrFollowingBloc,
              GetFollowerOrFollowingState>(
            builder: (context, state) {
         if (state is GetFollowerOrFollowingSucssesState){
               return Expanded(
                child: ListView.builder(
                  controller: scrollController,
                    itemCount: state.data!.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () =>                 Navigator.pushNamed(context, Routes.userProfile ,arguments:state.data![index].id.toString())
,
                        child: UserInfoRow(
                          userData: state.data![index],
                          endIcon: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.primary,
                            size: ConfigSize.defaultSize! * 2,
                          ),
                        ),
                      );
                    }),
              );
         }else if (state is GetFollowerOrFollowingLoadingState){
          return const LoadingWidget();
         }else if (state is GetFollowerOrFollowingErrorState){
        return  CustomErrorWidget(message: state.errorMassage,);
         } else {
                  return  const CustomErrorWidget(message: StringManager.unexcepectedError,);

         }
            },
          )
        ],
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.page++;
      if (widget.title == StringManager.friends) {
        BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
            GetMoreFriendsOrFollowersOrFollwothemEvent(
                type: '3', page: widget.page.toString()));
      } else if (widget.title == StringManager.followers) {
        BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
            GetMoreFriendsOrFollowersOrFollwothemEvent(
                type: '1', page: widget.page.toString()));
      } else {
        BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
            GetMoreFriendsOrFollowersOrFollwothemEvent(
                type: '2', page: widget.page.toString()));
      }
    } else {}
  }
}
