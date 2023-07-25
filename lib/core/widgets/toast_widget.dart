import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

dynamic deleteToast ({required BuildContext context , required String title , String? subTitle , } ){
  return CherryToast.warning(
  
	title:  Text(title,style:const TextStyle(color:Colors.red)),
	description:  Text(subTitle??""),
).show(context);
}

dynamic sucssesToast ({required BuildContext context , required String title , String? subTitle , } ){
  return CherryToast.success(
  
	title:   Text(title,style:const TextStyle(color:Colors.green)),
	description:  Text(subTitle??""),
).show(context);
}

dynamic errorToast ({required BuildContext context , required String title , String? subTitle , } ){
  return CherryToast.error(
  
	title:   Text(title,style:const TextStyle(color:Colors.red)),

	description:  Text(subTitle??""),
).show(context);
}

dynamic infoToast ({required BuildContext context , required String title , String? subTitle , } ){
  return CherryToast.info(
  
	title:  Text(title,style:const TextStyle(color:Colors.black)),
	description:  Text(subTitle??""),
).show(context);
}

dynamic warningToast ({required BuildContext context , required String title , String? subTitle , } ){
  return CherryToast.warning(
  
	title:  Text(title),
	description:  Text(subTitle??""),
).show(context);
}