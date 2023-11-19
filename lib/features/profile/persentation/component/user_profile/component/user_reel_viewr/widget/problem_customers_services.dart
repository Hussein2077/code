import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/report_dailog_for_users.dart';
// import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/user_reel_view.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';


class ProblemTextFormField extends StatefulWidget{
  final TextEditingController? textEditingController;
  const ProblemTextFormField({super.key,this.textEditingController});

  @override
  State<ProblemTextFormField> createState() => _ProblemTextFormFieldState();
}



class _ProblemTextFormFieldState extends State<ProblemTextFormField> {
  @override
  Widget build(BuildContext context) {
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return  TextFormField(
    controller: widget.textEditingController,
    keyboardType: TextInputType.text,
    textAlignVertical: TextAlignVertical.top,
    style: TextStyle(
       color: Colors.black
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return StringManager.cantBeEmpty.tr();
      }
      return null;
    },
      scrollPadding:EdgeInsets.only(bottom:bottomInsets + 40.0) ,
    decoration: InputDecoration(

        hintMaxLines: 3,

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.mainColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.mainColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.only(
          left: ConfigSize.defaultSize! * 0.5,
          bottom: ConfigSize.defaultSize! * 14.8,
          top: ConfigSize.defaultSize! * 1.0,
          right: ConfigSize.defaultSize! * 1.5,
        ),
        alignLabelWithHint: true,
        filled: true,
        hintStyle: TextStyle(
            color:  Colors.black,
            fontSize: ConfigSize.defaultSize! * 1.5,
            fontWeight: FontWeight.w400),

        fillColor: const Color(0xffFBFBFB),
        hintText: StringManager.pleaseExplain.tr(),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        )),
  );
  }
}