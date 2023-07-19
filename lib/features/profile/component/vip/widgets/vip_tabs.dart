

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class VipTabs extends StatefulWidget {
  final TabController vipContriller ; 
  const VipTabs({required this.vipContriller ,  super.key});

  @override
  State<VipTabs> createState() => _VipTabsState();
}

class _VipTabsState extends State<VipTabs> {
@override
  void initState() {
    widget.vipContriller.addListener(() { 
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize!*5,
      padding: EdgeInsets.symmetric( vertical: ConfigSize.defaultSize!-4 , horizontal: ConfigSize.defaultSize!),
      margin: EdgeInsets.symmetric(horizontal:  ConfigSize.defaultSize!+2),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2)),
      child: TabBar(
        
          controller: widget.vipContriller,
          isScrollable: true,
          labelColor: labelColor(vipContriller: widget.vipContriller),
          unselectedLabelColor: Theme.of(context).colorScheme.primary,
          labelStyle:
               TextStyle(fontWeight: FontWeight.normal, fontSize: ConfigSize.defaultSize!*1.7 ,  ),
          unselectedLabelStyle:
               TextStyle(fontWeight: FontWeight.normal, fontSize: ConfigSize.defaultSize!*1.5),
          labelPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! , vertical: ConfigSize.defaultSize!-3),
          indicator: BoxDecoration(
            
            borderRadius: BorderRadius.circular(
               ConfigSize.defaultSize!*2,
            ),
            color: ColorManager.whiteColor,
          ),
          tabs: const [
            Text(StringManager.knight),
            Text(StringManager.baron),
                        Text(StringManager.viscount),
                          Text(StringManager.count),
            Text(StringManager.marquis),
                        Text(StringManager.duke),
                          Text(StringManager.king),
            Text(StringManager.superKing),
                        
      
            
          ]),
    );
  }

  
}

Color labelColor ({required TabController vipContriller }){
  if (vipContriller.index==0){
return const Color.fromARGB(255, 11, 100, 173) ; 
  }else if (vipContriller.index ==1){
    return const Color.fromARGB(255, 115, 5, 134);
  }else if (vipContriller.index==2){
 return   const Color.fromARGB(255, 195, 23, 11) ; 
  }else if (vipContriller.index==3){
 return   const Color.fromARGB(255, 201, 182, 7) ; 
  }else if (vipContriller.index==4){
 return   const Color.fromARGB(255, 125, 4, 4);
  }else if (vipContriller.index==5){
     return const Color.fromARGB(255, 9, 86, 149) ; 
  }else if (vipContriller.index==6){
    return const Color.fromARGB(255, 6, 154, 11);
  }else {
    return const Color.fromARGB(255, 170, 6, 61) ; 
  }
   
}