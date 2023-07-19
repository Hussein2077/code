import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class HeaderWithOnlyTitle extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Widget? endIcon ; 
  const HeaderWithOnlyTitle({this.endIcon,  this.titleColor, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: ConfigSize.defaultSize! * 2,
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: ConfigSize.defaultSize! * 3,
          ),
          color: titleColor ?? Theme.of(context).colorScheme.primary,
        ),
        titleColor == null
            ? Text(title, style: Theme.of(context).textTheme.headlineLarge)
            : Text(title,
                style: TextStyle(
                    color: Colors.white, fontSize: ConfigSize.defaultSize! * 2)),
                    const Spacer() , 
                    if(endIcon!=null)
                    endIcon!,

                    SizedBox(width: ConfigSize.defaultSize,),

      ],
    );
  }
}
