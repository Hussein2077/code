import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 4,
          ),
          Padding(
            padding: EdgeInsets.only(left: ConfigSize.defaultSize!),
            child: ContinerWithIcons(
                boreder: true,
                color: Colors.white,
                icon1: Icons.search,
                widget: SizedBox(
                    width: MediaQuery.of(context).size.width - 140,
                    child: TextFieldWidget(
                      onChanged: (p0) {
                        BlocProvider.of<SearchBloc>(context).add(SearchEvent(keyWord: searchController.text));
                      },
                        hintColor: Colors.black.withOpacity(0.6),
                        hintText: StringManager.search.tr(),
                        controller: searchController))),
          ),
          BlocBuilder<SearchBloc, SearchStates>(
            builder: (context, state) {
              if(state is SuccessSearchStates){
             return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 12),
                  child: ListView.builder(
                    itemCount: state.data.userModel.length,
                    itemExtent: 70,
                    itemBuilder: (context, index) {


                    return UserInfoRow(userData:state.data.userModel[index] ,
                        endIcon: const Icon( Icons.arrow_forward_ios,));
                  }),
                ),
              );
              }else {
                return const SizedBox();
              }
            
            },
          )
        ],
      ),
    );
  }
}
