import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';

import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation'
    ''
    '/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_state.dart';

import 'widgets/family_profile_bottom_bar.dart';
import 'widgets/family_profile_info.dart';

class FamilyProfileScreen extends StatefulWidget {
  final String familyId;
  const FamilyProfileScreen({required this.familyId, super.key});

  @override
  State<FamilyProfileScreen> createState() => _FamilyProfileScreenState();
}

class _FamilyProfileScreenState extends State<FamilyProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ShowFamilyBloc>(context).add(ShowFamilyEvent(id: widget.familyId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<ShowFamilyBloc, ShowFamilyState>(
          builder: (context, state) {
            if(state is ShowFamilySucssesState){
  return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: isDarkTheme
                              ? null
                              : const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          AssetsPath.familyProfileCover),
                                      fit: BoxFit.fitHeight)),
                          child:  FamilyProfileInfo(familyData: state.data),
                        )
                      ],
                    ),
                  ),
                ),
                (state.data.amImember!||state.data.amIAdmin!||state.data.amIOwner!)?
                const SizedBox():
                 FamilyProfileBottomBar(familyId: state.data.id.toString(),)
              ],
            );
            }else if (state is ShowFamilyLoadingState){
              return const LoadingWidget();
            }else if (state is ShowFamilyErrorState){
              return CustoumErrorWidget(message: state.error,);
            }else {
              return    const CustoumErrorWidget(message: StringManager.unexcepectedError,);
            }
          
          },
        ));
  }
}
