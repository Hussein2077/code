import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

import 'widgets/add_profile_pic.dart';
import 'widgets/continer_with_icons.dart';
import 'widgets/country_widget.dart';
import 'widgets/date/date_widget.dart';
import 'widgets/male_female_buttons.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({super.key});

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  late TextEditingController nameController;
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
       const   Spacer(flex:2,),
          const HeaderWithOnlyTitle(
            title: StringManager.completeYourAccount,
          ),
                 const   Spacer(flex:1,),

          const AddProFilePic(),
                 const   Spacer(flex: 1,),

          Text(
            StringManager.postYourBestPhoto,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
                 const   Spacer(flex: 2,),

          ContinerWithIcons(
              icon1: Icons.person,
              widget: SizedBox(
                width: ConfigSize.defaultSize! * 25,
                child: TextField(
                  style:  TextStyle(color: Colors.grey , fontSize: ConfigSize.defaultSize!*1.7),
                  autofocus: false,
                  controller: nameController,
                  decoration: const InputDecoration(
                
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: StringManager.userName,
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              )),
                     const   Spacer(flex: 1,),

          const ContinerWithIcons(
            icon1: Icons.date_range,
            widget: DateWidget(),
            icon2: Icons.keyboard_arrow_down,
          ),
                 const   Spacer(flex: 1,),

          const ContinerWithIcons(
            icon1: Icons.flag,
            widget: CountryWidget(),
            icon2: Icons.keyboard_arrow_down,
          ),
                 const   Spacer(flex: 1,),

          const MaleFemaleButtons(),
                 const   Spacer(flex: 4,),

          MainButton(onTap: () {
Navigator.pushNamed(context, Routes.mainScreen);

          }, title: StringManager.done),
                 const   Spacer(flex: 1,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsPath.warningIcon,
                scale: 1.4,
              ),
              SizedBox(
                width: ConfigSize.defaultSize,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  StringManager.youCanNotModify,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
                 const   Spacer(flex: 3,),

          
        ],
      ),
    );
  }
}
