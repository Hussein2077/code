

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ProblemType extends StatefulWidget {
  static int seletedProblem=0 ;
 static  List<String> types = [
    StringManager.porn,
    StringManager.bullying,
    StringManager.violence,
    StringManager.other ,
  ];
  const ProblemType({super.key});

  @override
  State<ProblemType> createState() => _ProblemTypeState();
}

class _ProblemTypeState extends State<ProblemType> {
 
  @override
  Widget build(BuildContext context) {
    return        SizedBox(
      height: ConfigSize.defaultSize!*5,
      child: ListView.builder(
        
        shrinkWrap: true,
              scrollDirection: Axis.horizontal,
                itemCount: ProblemType.types.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        ProblemType.seletedProblem = index ; 
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                      padding: EdgeInsets.all(ConfigSize.defaultSize!),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize!*2),
                        color: ProblemType.seletedProblem==index?ColorManager.orang: Colors.grey,
                      ),
                      child:  Center(child: Text(ProblemType.types[index]),),
                    ),
                  );
                }),
    );
  }
}