import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class LinearGradientContainer extends StatelessWidget {
  final List <Color>? listColor;
  final String title;
  final Function onPress;
  const LinearGradientContainer({super.key, this.listColor,required this.title,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPress();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
            gradient: LinearGradient(colors: listColor??ColorManager.mainColorList)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
            color: Theme.of(context).colorScheme.background,
          ),
          width: MediaQuery.of(context).size.width - 50,
          margin: const EdgeInsets.all(2),
          child: Text(title,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
