import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/details_tab_bar.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/tab_bar_view.dart';


class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin  {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,

        title:Text(
          StringManager.details,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Column(
        children: [

          SizedBox(
            height: ConfigSize.defaultSize!*0.3,
          ),
          SizedBox(
            height: ConfigSize.defaultSize!*5.0 ,
              width: MediaQuery.of(context).size.width,
              child: DetailsScreenTabBar(
                tabController: tabController,
              )),

           Expanded(
             child: TabBarView(
                controller: tabController,
                children: const [
                  TabBarViewDetailsScreen(
                    flag:'send',
                  ),

                  TabBarViewDetailsScreen(
                    flag:'received',
                  )
          ]),
           )
        ],
      ),
    );
  }
}
