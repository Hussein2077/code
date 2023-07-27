import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';

class InstructionsScreen extends StatefulWidget {
  static bool selectedMode = false;

  const InstructionsScreen({super.key});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
 final List<String> listOfInstructions = [
   StringManager.firstInstructions,
   StringManager.secondInstructions,
   StringManager.thirdInstructions,
   StringManager.fourthInstructions,
   StringManager.fifthInstructions,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackGround(
        image: AssetsPath.incomeBackGroundScreen,
        child: Column(
          children:  [
            SizedBox(height: ConfigSize.defaultSize!/0.25),
            const HeaderWithOnlyTitle(title: StringManager.agency),
            SizedBox(height: ConfigSize.defaultSize!*5.2),
            Text(StringManager.instructionsForJoiningAgency,
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ConfigSize.defaultSize!*2.75,
                    color:const Color(0xFFFBD711)) ,

            ),
            SizedBox(height: ConfigSize.defaultSize!*6.4),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*1.6,),
                separatorBuilder: (context,index){
                  return SizedBox(
                    height: ConfigSize.defaultSize!*1.4,
                  );
                },
                  itemBuilder: (context,index){
                return  Text(listOfInstructions[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ConfigSize.defaultSize!*1.5,
                  ),);
              },
                itemCount: listOfInstructions.length,
                physics: const BouncingScrollPhysics(),

              ),
            ),
            SizedBox(height: ConfigSize.defaultSize!*2.4),
            modeRow(
              context: context,
              mode: StringManager.agreedToTheRegulations,
              onTap: () {
                setState(() {
                  InstructionsScreen.selectedMode = !InstructionsScreen.selectedMode;
                });
              },
            ),
            SizedBox(height: ConfigSize.defaultSize!*2.4),

            MainButton(
              onTap: () {
                Navigator.pushNamed(context, Routes.joinToAgencyScreen);
              },
              title: StringManager.goToJoin,
            ),
            SizedBox(height: ConfigSize.defaultSize!*2.4),
          ],
        ),
      ),
    );
  }

  Widget modeRow(
     {required BuildContext context,
       required String mode,
       void Function()? onTap}) {
   return Padding(
     padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Expanded(
           child: Text(
             mode,
             style: Theme.of(context).textTheme.bodyMedium,
           ),
         ),
         InkWell(
           onTap: onTap,
           child: Container(
             width: ConfigSize.defaultSize! * 3,
             height: ConfigSize.defaultSize! * 3,
             decoration: BoxDecoration(
                 color: InstructionsScreen.selectedMode
                     ? ColorManager.orang
                     : Colors.transparent,
                 shape: BoxShape.circle,
                 border: Border.all(color: Colors.grey)),
             child:  InstructionsScreen.selectedMode
                 ?  const Icon(Icons.check,color: Colors.black,):const SizedBox(),
           ),
         )
       ],
     ),
   );
 }
}
