import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment/get_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/add_moment_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_appbar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_view.dart';
import '../../../core/utils/config_size.dart';

class MomentScreen extends StatefulWidget {
  const MomentScreen({super.key});

  @override
  State<MomentScreen> createState() => _MomentScreenState();
}

class _MomentScreenState extends State<MomentScreen>with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this, // Provide a TickerProvider
    );
    BlocProvider.of<GetMomentBloc>(context).add(GetMomentEvent(
      userId: MyDataModel.getInstance().id.toString(),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Theme.of(context).colorScheme.background,
  appBar: AppBar(
    bottom:  TabBar(
        controller:_tabController ,
        tabs: [
      Text(
        StringManager.likedTab.tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      Text(
        StringManager.followingtab.tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
          Text(
        StringManager.followingtab.tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    ]),
  ),
  body: Column(
        children: [


          TabBarView(
              controller:_tabController ,

              children: [
            BlocBuilder<GetMomentBloc, GetMomentState>(
  builder: (context, state) {
    if(state is GetMomentSucssesState) {

      return Container(
              width: ConfigSize.screenWidth,
              height: ConfigSize.screenHeight,

              padding: EdgeInsets.symmetric(
                  horizontal: ConfigSize.defaultSize! * 0.2),
              child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize! * 1,
                            vertical: ConfigSize.defaultSize! * 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ConfigSize.defaultSize! * 2),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Column(
                          children: [
                            MomentAppBar(
                              momentModel: state.data[i],
                            ),
                            MomentView(
                              momentModel:state.data[i],
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 1.5,
                            ),
                            MomentBottomBar(
                              momentModel:state.data[i],
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 1.5,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: ConfigSize.defaultSize! * 2,
                        color: Theme.of(context).colorScheme.secondary,
                        indent: ConfigSize.defaultSize! * 2,
                      ),
                    ],
                  );
                },
              ),
            );
    }else if(state is GetMomentErrorState){
      errorToast(context: context, title: state.error);
    }else if(state is GetMomentLoadingState){
      loadingToast(context: context);
    }
    return const SizedBox();
  },
),
            BlocBuilder<GetMomentBloc, GetMomentState>(
  builder: (context, state) {
    if(state is GetMomentSucssesState) {

      return Container(
              width: ConfigSize.screenWidth,
              height: ConfigSize.screenHeight,

              padding: EdgeInsets.symmetric(
                  horizontal: ConfigSize.defaultSize! * 0.2),
              child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize! * 1,
                            vertical: ConfigSize.defaultSize! * 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ConfigSize.defaultSize! * 2),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Column(
                          children: [
                            MomentAppBar(
                              momentModel: state.data[i],
                            ),
                            MomentView(
                              momentModel:state.data[i],
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 1.5,
                            ),
                            MomentBottomBar(
                              momentModel:state.data[i],
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 1.5,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: ConfigSize.defaultSize! * 2,
                        color: Theme.of(context).colorScheme.secondary,
                        indent: ConfigSize.defaultSize! * 2,
                      ),
                    ],
                  );
                },
              ),
            );
    }else if(state is GetMomentErrorState){
      errorToast(context: context, title: state.error);
    }else if(state is GetMomentLoadingState){
      loadingToast(context: context);
    }
    return const SizedBox();
  },
),
          ]),
        ],
      ),

      floatingActionButton: Container(
        width: ConfigSize.defaultSize! * 8,
        height: ConfigSize.defaultSize! * 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            border: Border.all(color: Theme.of(context).colorScheme.secondary)),
        child: IconButton(
          icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            bottomDailog(context: context,

          widget:
          AddMomentScreen(


          ) ,
          color: Theme.of(context).colorScheme.background);
    },
    ),
),

);
  }
}