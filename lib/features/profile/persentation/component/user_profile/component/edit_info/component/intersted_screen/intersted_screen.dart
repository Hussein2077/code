import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_state.dart';

class InterstedScreen extends StatefulWidget {
  static Map<int, int> intrestedIds = {};

  const InterstedScreen({super.key});

  @override
  State<InterstedScreen> createState() => _InterstedScreenState();
}

class _InterstedScreenState extends State<InterstedScreen> {
  List<int> userInterests = [];
  int isFirst = 0 ; 
  @override
  void initState() {
    InterstedScreen.intrestedIds={};
    BlocProvider.of<GetUserInterstedBloc>(context).add(GetUserInterstedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddInterstedBloc, AddInterstedState>(
      listener: (context, state) {
        if (state is AddInterstedLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is AddInterstedSucssesState) {
          sucssesToast(context: context, title: state.message);
        } else if (state is AddInterstedErrorState) {
          errorToast(context: context, title: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<GetUserInterstedBloc, GetUserInterstedState>(
          builder: (context, state) {
            if (state is GetUserInterstedSucssesState) {
              userInterests = [];
              if (isFirst==0){
   for (int i = 0; i < state.data.length; i++) {
                userInterests.add(state.data[i].id!);
              }
              }
           
              log(userInterests.toString());
              return BlocBuilder<GetAllInterstedBloc, GetAllInterstedState>(
                builder: (context, state) {
                  if (state is GetAllInterstedSucssesState) {
                    return Column(
                      children: [
                        SizedBox(
                          height: ConfigSize.defaultSize! * 3.5,
                        ),
                        HeaderWithOnlyTitle(
                            title: StringManager.interests.tr()),
                        SizedBox(
                          height: ConfigSize.defaultSize! * 3.5,
                        ),
                        Text(
                          StringManager.chooseTopic.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Expanded(
                          child: GridView.builder(
                              itemCount: state.data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.3, crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                if (userInterests
                                    .contains(state.data[index].id)) {
                                  InterstedScreen.intrestedIds.putIfAbsent(
                                      index, () => state.data[index].id!);
                                }
                                return intrestedBox(
                                    index: index,
                                    context: context,
                                    image: state.data[index].image!,
                                    title: state.data[index].name!,
                                    onTap: () {
                                      setState(() {
                                        if (InterstedScreen.intrestedIds
                                            .containsKey(index)) {
                                          InterstedScreen.intrestedIds
                                              .remove(index);
                                              userInterests.remove(state.data[index].id);
                                              isFirst++;
                                        } else {
                                          InterstedScreen.intrestedIds
                                              .putIfAbsent(index,
                                                  () => state.data[index].id!);
                                        }

                                        log(InterstedScreen.intrestedIds
                                            .toString());
                                      });
                                    });
                              }),
                        ),
                        MainButton(
                          title: StringManager.done.tr(),
                          onTap: () {
                            List<int> inrestedid = [];
                            InterstedScreen.intrestedIds.forEach((key, value) {
                              inrestedid.add(value);
                            });

                            BlocProvider.of<AddInterstedBloc>(context)
                                .add(AddInterstedEvent(ids: inrestedid));
                          },
                        ),
                        SizedBox(
                          height: ConfigSize.defaultSize! * 5,
                        )
                      ],
                    );
                  } else if (state is GetAllInterstedLoadingState) {
                    return const LoadingWidget();
                  } else if (state is GetAllInterstedErrorState) {
                    return CustomErrorWidget(message: state.error);
                  } else {
                    return  CustomErrorWidget(
                        message: StringManager.unexcepectedError.tr());
                  }
                },
              );
            } else if (state is GetUserInterstedLoadingState) {
              return const LoadingWidget();
            } else if (state is GetUserInterstedErrorState) {
              return CustomErrorWidget(message: state.error);
            } else {
              return const CustomErrorWidget(
                  message: StringManager.unexcepectedError);
            }
          },
        ),
      ),
    );
  }
}

Widget intrestedBox({
  required BuildContext context,
  required String image,
  required String title,
  void Function()? onTap,
  required int index,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(ConfigSize.defaultSize!),
      decoration: BoxDecoration(
          gradient: InterstedScreen.intrestedIds.containsKey(index)
              ? const LinearGradient(colors: ColorManager.mainColorList)
              : null,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
          color: InterstedScreen.intrestedIds.containsKey(index)
              ? null
              : Theme.of(context).colorScheme.secondary),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ),
  );
}
