import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/upload_reels_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_event.dart';

class ChooseTopicDailog extends StatefulWidget {
  const ChooseTopicDailog({super.key});

  @override
  State<ChooseTopicDailog> createState() => _ChooseTopicDailogState();
}

class _ChooseTopicDailogState extends State<ChooseTopicDailog> {
  @override
  void initState() {
    BlocProvider.of<GetUserInterstedBloc>(context).add(GetUserInterstedEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          Text(
            StringManager.chooseTheTopic,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          CustomHorizntalDvider(
            width: ConfigSize.defaultSize! * 4,
            color: ColorManager.orang,
          ),
          Expanded(
            child: BlocBuilder<GetAllInterstedBloc, GetAllInterstedState>(
              builder: (context, state) {
                  if (state is GetAllInterstedSucssesState){
   return ListView.builder(
                    itemExtent: 50,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                              if (UploadReelsScreenState.selectedIntrest.contains( state.data[index].id)){
                            UploadReelsScreenState.selectedIntrest.removeWhere((element) => element== state.data[index].id);
                          }else {
                            UploadReelsScreenState.selectedIntrest.add(state.data[index].id!);
                          }
                          });
                        
                        },
                        child: topicRow(context: context, title: state.data[index].name! , selected:UploadReelsScreenState.selectedIntrest.contains( state.data[index].id) ));
                    });
                  }else if (state is GetAllInterstedLoadingState) {
                    return const LoadingWidget();
                  }else if (state is GetAllInterstedErrorState) {
                    return CustomErrorWidget(message: state.error);
                  } else {
                    return  CustomErrorWidget(
                        message: StringManager.unexcepectedError.tr());
                  }
             
              },
            ),
          ),
        ],
      )),
    );
  }
}

Widget topicRow({required BuildContext context, required String title , required bool selected}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*2),
    decoration: BoxDecoration(
      gradient:selected? const LinearGradient(colors: ColorManager.mainColorList):null,
      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
      border: Border.all(color: Theme.of(context).colorScheme.primary)
    ),
    child: Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(
          flex: 15,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
          size: ConfigSize.defaultSize! * 1.6,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    ),
  );
}
