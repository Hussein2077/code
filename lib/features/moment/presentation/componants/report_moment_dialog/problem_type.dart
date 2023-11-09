import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ProblemType extends StatefulWidget {
  static int seletedMomentProblem = 0;

  //  static const String pornAr = ;
  //   static const String otherAr = ;
  //   static const String bullyingAr = ;
  //   static const String violenceAr = ;
  static List<String> types = [
    StringManager.porn.tr(),
    StringManager.bullying.tr(),
    StringManager.violence.tr(),
    StringManager.other.tr(),
  ];
  static List<String> typesArabic = [
    "اباحية",
    "تنمر",
    "عنف",
    "اخري",
  ];

  const ProblemType({super.key});

  @override
  State<ProblemType> createState() => _ProblemTypeState();
}

class _ProblemTypeState extends State<ProblemType> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 5,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: ProblemType.types.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  ProblemType.seletedMomentProblem = index;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                padding: EdgeInsets.all(ConfigSize.defaultSize!),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ConfigSize.defaultSize! * 2),
                  color: ProblemType.seletedMomentProblem == index
                      ? ColorManager.orang
                      : Colors.grey,
                ),
                child: Center(
                  child: Text(ProblemType.types[index],style: TextStyle(fontSize: ConfigSize.defaultSize!*1.3),),
                ),
              ),
            );
          }),
    );
  }
}
