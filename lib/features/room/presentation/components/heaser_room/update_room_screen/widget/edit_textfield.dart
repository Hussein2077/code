import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class EditTextField extends StatefulWidget{
  final TextEditingController textFieldControler;
  String title;
  String hint;
  String? roomName;
  EditTextField({super.key, required this.textFieldControler,required this.title,required this.hint, this.roomName});

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  late  TextEditingController textFieldControler;
  late String title;
  late String hint;
  late String roomName;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    hint = widget.hint;
    textFieldControler=TextEditingController();
    //roomName = widget.roomName;
  }

  @override
  Widget build(BuildContext context) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [

       Text(title!,

           //StringManager.roomIntro.tr(),
           style: Theme.of(context).textTheme.headlineMedium!.copyWith(
             fontSize: ConfigSize.defaultSize! * 2,
             fontWeight: FontWeight.w600,
           )),
       Container(
         padding: EdgeInsets.symmetric(
             horizontal: ConfigSize.defaultSize! * 2.11),
         decoration: BoxDecoration(
             color: ColorManager.lightGray,
             borderRadius: BorderRadius.circular(AppPadding.p10)),
         child: TextFormField(
           onChanged: (value) {
             setState(() {});
           },
           style: const TextStyle(color: ColorManager.mainColor),
           controller: textFieldControler,
           cursorColor: ColorManager.mainColor,
           decoration: InputDecoration(
             hintText: hint!,
             //StringManager.updateRoomName.tr(),
             hintStyle: const TextStyle(color: ColorManager.gray),
             border: InputBorder.none,
             disabledBorder: InputBorder.none,
             focusedBorder: InputBorder.none,
           ),
         ),
       ),
     ],
   );
  }
}