import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/block_list_bloc/block_list_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/block_list_bloc/block_list_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/block_list_bloc/block_list_state.dart';

class BlockListScreen extends StatefulWidget {
  const BlockListScreen({super.key});

  @override
  State<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
  @override
  void initState() {
    BlocProvider.of<GetBlockListBloc>(context).add(GetBlockListEvent());

    super.initState();
  }

  List<UserDataModel>? tempData;
  int isFirst = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddOrDeleteBLockListBloc, AddOrDeleteBlockListState>(
        listener: (context, state) {
          if (state is DeleteBlockListSuccessState) {
            BlocProvider.of<GetBlockListBloc>(context).add(GetBlockListEvent());
          } else if (state is DeleteBlockListErrorState) {
            errorToast(context: context, title: state.errorMassage);
          } else if (state is DeleteBlockListLoadingState) {
            loadingToast(context: context);
          }
        },
        child: Column(
          children: [
            HeaderWithOnlyTitle(title: StringManager.blockList.tr()),
            BlocBuilder<GetBlockListBloc, GetBlockListState>(
              builder: (context, state) {
                if (state is GetBlockListSuccessState) {
                  isFirst++;
                  tempData = state.blackListModel.data;
                  return SizedBox(
                    height: ConfigSize.screenHeight! * .8,
                    child: ListView.builder(
                        itemCount: state.blackListModel.data.length,
                        itemBuilder: (context, index) {
                          return UserInfoRow(
                              endIcon: MainButton(
                                width: ConfigSize.screenWidth! * .15,
                                height: ConfigSize.defaultSize! * 3,
                                onTap: () {
                                  BlocProvider.of<AddOrDeleteBLockListBloc>(
                                          context)
                                      .add(DeleteBlockListEvent(state
                                          .blackListModel.data[index].id
                                          .toString()));
                                },
                                title: StringManager.remove.tr(),
                                titleSize: ConfigSize.defaultSize! * 1.2,
                              ),
                              userData: state.blackListModel.data[index]);
                        }),
                  );
                }
                if (state is GetBlockListLoadingState) {
                  if (isFirst == 0) {
                    return const LoadingWidget();
                  } else {
                    return SizedBox(
                      height: ConfigSize.screenHeight! * .8,
                      child: ListView.builder(
                          itemCount: tempData!.length,
                          itemBuilder: (context, index) {
                            return UserInfoRow(
                                endIcon: MainButton(
                                  width: ConfigSize.screenWidth! * .15,
                                  height: ConfigSize.defaultSize! * 3,
                                  onTap: () {
                                    BlocProvider.of<AddOrDeleteBLockListBloc>(
                                            context)
                                        .add(DeleteBlockListEvent(
                                            tempData![index].id.toString()));
                                  },
                                  title: StringManager.remove.tr(),
                                  titleSize: ConfigSize.defaultSize! * 1.2,
                                ),
                                userData: tempData![index]);
                          }),
                    );
                  }
                }
                if (state is GetBlockListErrorState) {
                  return ErrorWidget(state.errorMassage);
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
