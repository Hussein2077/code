import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'widgets/coin_tabs.dart';
import 'widgets/coins_tab_view.dart';

class CoinsScreen extends StatefulWidget {
  final String type ; 
  const CoinsScreen({required this.type ,  super.key});

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}

class _CoinsScreenState extends State<CoinsScreen>with TickerProviderStateMixin {
  late TabController coinsController;
  @override
  void initState() {
    coinsController = TabController(length: 2, vsync: this);
    if(widget.type=="silver"){
      coinsController.index =1;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        SizedBox(height: ConfigSize.defaultSize!*3.5,),
        CoinTabs(coinsController:coinsController ,),
        Expanded(
          child: TabBarView(
            controller: coinsController,
            children:const [
       CoinsTabView(type: "gold"),
       CoinsTabView(type: "silver"),
        
            ]),
        ),
      ],),
    );
  }
}