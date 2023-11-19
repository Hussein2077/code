
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';

ShowMToast toast = ShowMToast();

dynamic deleteToast ({required BuildContext context , required String title , String? subTitle , } ){
	return toast.errorToast(

		message:title,
		textColor:Colors.red,
		icon: Icons.delete,
		iconColor:Colors.red,
		context, alignment: Alignment.topCenter,
	);
}

dynamic sucssesToast ({required BuildContext context , required String title , String? subTitle , } ){
	return toast.successToast(
		message:title,
		textColor:Colors.green,
		icon: Icons.check_circle,
		iconColor:Colors.green,
		context, alignment: Alignment.topCenter,
	);
}

dynamic errorToast ({required BuildContext context , required String title , String? subTitle , } ){
  return toast.errorToast(

       message:title,
			textColor:Colors.red,
			icon: Icons.error,
			iconColor:Colors.red,
			context, alignment: Alignment.topCenter,
	);
}

dynamic loadingToast ({required BuildContext context ,  String? title , String? subTitle , } ){
  return toast.loadingToast(
       message:title??StringManager.loading.tr(),
			textColor:Colors.green,
			widget: const SizedBox(
				width: 30,
					height:30,
					child:
					CircularProgressIndicator(
						color: Colors.green,
					)),

			iconColor:Colors.green,
			context,
		  alignment: Alignment.topCenter,
	);
}



dynamic warningToast ({required BuildContext context , required String title , String? subTitle , } ){
	return toast.errorToast(

		message:title,
		textColor:Colors.red,
		icon: Icons.warning,
		iconColor:Colors.red,
		context, alignment: Alignment.topCenter,
	);
}