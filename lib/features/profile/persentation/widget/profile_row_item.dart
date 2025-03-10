import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ProfileRowItem extends StatelessWidget {
  final String title;
  final double? scale;
  final String image;
  final Color? color;
  final void Function()? onTap;

  const ProfileRowItem(
      {this.onTap,this.scale,this.color, required this.image, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 5,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            Image.asset(
              image,
              scale:scale?? 2.5,
              color: color,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: ConfigSize.defaultSize! * 1.6,
              ),
            ),
            const Spacer(
              flex: 20,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
              size: ConfigSize.defaultSize! * 1.4,
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
