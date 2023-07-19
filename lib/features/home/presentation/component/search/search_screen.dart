import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController ; 
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [       ContinerWithIcons(
            color: Colors.white,
              icon1: Icons.lock,
              widget: SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: TextFieldWidget(
                    hintColor: Colors.black.withOpacity(0.6),
                      hintText: StringManager.password,
                      controller: searchController))),],);
  }
}