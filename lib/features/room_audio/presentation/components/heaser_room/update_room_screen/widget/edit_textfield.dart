import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class EditTextField extends StatefulWidget{
  late TextEditingController textFieldControler;
  String title;
  String hint;
  String? roomName;
  EditTextField({super.key, required this.textFieldControler,required this.title,required this.hint, this.roomName});

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {


  @override
  Widget build(BuildContext context) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [

       Text(widget.title,

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
           controller: widget.textFieldControler,
           cursorColor: ColorManager.mainColor,
           decoration: InputDecoration(
             hintText: widget.hint,

             //StringManager.updateRoomName.tr(),
             hintStyle:   TextStyle(color: ColorManager.gray.withOpacity(.7)),
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