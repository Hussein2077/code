import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';

import 'widget/add_screen_shot.dart';
import 'widget/problem_type.dart';

class CustoumServiceScreen extends StatefulWidget {
  const CustoumServiceScreen({super.key});

  @override
  State<CustoumServiceScreen> createState() => _CustoumServiceScreenState();
}

class _CustoumServiceScreenState extends State<CustoumServiceScreen> {
  late TextEditingController detailsController;
  late TextEditingController timeController;
  @override
  void initState() {
    detailsController = TextEditingController();
    timeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! ,
          ),
          const HeaderWithOnlyTitle(title: StringManager.custoumService),
          Text(
            StringManager.typeOfProblem,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const ProblemType(),
          Text(
            StringManager.details,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
            decoration: BoxDecoration(
                color: ColorManager.lightGray,
                borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 2)),
            child: TextFieldWidget(
                maxLines: 4,
                hintText: StringManager.explainProblem,
                controller: detailsController),
          ),
          Text(
            StringManager.problemTime,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
            decoration: BoxDecoration(
                color: ColorManager.lightGray,
                borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 2)),
            child: TextFieldWidget(hintText: "", controller: timeController),
          ),
          Text(
            StringManager.screenshot,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const AddScreenShot(),

          MainButton(onTap: (){}, title: StringManager.submit)
        ],
      ),
    );
  }
}
