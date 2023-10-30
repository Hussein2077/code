


import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

import '../../../../core/utils/config_size.dart';

class Styles {
  static TextStyle h1() {
    return  TextStyle(
        fontSize: ConfigSize.defaultSize!*2, fontWeight: FontWeight.w500, color: Colors.white);
  }

  static friendsBox() {
    return const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)));
  }

  static messagesCardStyle(check) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    
      color: check ? ColorManager.orang: Colors.grey.shade300,
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.orang),
        borderRadius: BorderRadius.circular(10));
  }

  static messageTextFieldStyle({required Function() onSubmitImage, required Function() onSubmit}) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Message',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      prefixIcon: IconButton(onPressed: onSubmitImage , icon:  const Icon(Icons.photo , ),),
      suffixIcon: IconButton(onPressed: onSubmit, icon: const Icon(Icons.send , color: ColorManager.orang,)),
    );
  }
  static searchTextFieldStyle() {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Name',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded)),
    );
  }
}
