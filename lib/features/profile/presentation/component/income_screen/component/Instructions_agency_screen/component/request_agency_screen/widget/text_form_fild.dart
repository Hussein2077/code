import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';



class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool readOnly;
  final String? Function(String?)? validator;

  const TextFormFieldWidget(
      {required this.readOnly,
      Key? key,
      required this.textEditingController,
        this.validator,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      readOnly: readOnly,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: ColorManager.mainColor,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: ColorManager.mainColor,
              )),
          contentPadding:
              EdgeInsets.symmetric(vertical:  ConfigSize.defaultSize! * 2.0, horizontal:  ConfigSize.defaultSize! * 3.0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:  TextStyle(
              fontWeight: FontWeight.normal,
              color: const Color(0xffAEAEAE),
              fontSize:  ConfigSize.defaultSize! * 1.5)),
      onChanged: (value) {},
      controller: textEditingController,
      style:  TextStyle(fontWeight: FontWeight.w500, fontSize:  ConfigSize.defaultSize! * 1.5),
      cursorColor: ColorManager.mainColor,
    );
  }
}
