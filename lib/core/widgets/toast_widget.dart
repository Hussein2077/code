


import 'package:flutter/widgets.dart';
import 'package:motion_toast/motion_toast.dart';

dynamic deleteToast ({required BuildContext context , required String title , String? subTitle , } ){
  return MotionToast.delete(
  
	title:  Text(title),
	description:  Text(subTitle??""),
).show(context);
}

dynamic sucssesToast ({required BuildContext context , required String title , String? subTitle , } ){
  return MotionToast.success(
  
	title:  Text(title),
	description:  Text(subTitle??""),
).show(context);
}

dynamic errorToast ({required BuildContext context , required String title , String? subTitle , } ){
  return MotionToast.error(
  
	title:  Text(title),
	description:  Text(subTitle??""),
).show(context);
}

dynamic infoToast ({required BuildContext context , required String title , String? subTitle , } ){
  return MotionToast.info(
  
	title:  Text(title),
	description:  Text(subTitle??""),
).show(context);
}

dynamic warningToast ({required BuildContext context , required String title , String? subTitle , } ){
  return MotionToast.warning(
  
	title:  Text(title),
	description:  Text(subTitle??""),
).show(context);
}