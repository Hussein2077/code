// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_states.dart';
import '../utils/config_size.dart';

class SearchContainerVisibility extends StatefulWidget {
  SearchContainerVisibility({super.key, required this.searchContainerVisible, required this.userID});
  bool searchContainerVisible;
  final TextEditingController userID;
  @override
  State<SearchContainerVisibility> createState() => _SearchContainerVisibilityState();
}

class _SearchContainerVisibilityState extends State<SearchContainerVisibility> {
  @override
  Widget build(BuildContext context) {
    return   Visibility(
      visible:widget.searchContainerVisible,
      child: Container(
        height:ConfigSize.screenHeight! * .3,
        width: ConfigSize.screenWidth!,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BlocBuilder<SearchBloc, SearchStates>(
          builder: (context, state) {
            if (state is SuccessSearchStates) {
              return ListView.builder(
                  itemCount: state.data.userModel.length,
                  itemExtent: 70,
                  itemBuilder: (context, index) {
                    return UserInfoRow(
                        onTap: () {
                          setState(() {
                            widget.userID.text = state
                                .data.userModel[index].uuid
                                .toString();

                          });
                          widget.searchContainerVisible = false;
                        },
                        userData: state.data.userModel[index],
                        endIcon: const Icon(
                          Icons.arrow_forward_ios,
                        ));
                  });
            } else if (state is LoadingSearchStates) {
              return const LoadingWidget();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
