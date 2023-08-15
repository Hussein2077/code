
import 'package:flutter/material.dart';

class CilcularAssetImage extends StatelessWidget {

  final String image ;
  final double border ;
  final double size ;
  final  Color?  colorBorder;
  final void Function()? onPressed ;
  const CilcularAssetImage({ this.onPressed ,
    this.colorBorder,required this.image,this.border=0,required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(image)),
            border: Border.all(
                width:border, color: colorBorder??Colors.white)),

      ),
    );
  }
}
