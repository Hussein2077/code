

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

SnackBar custoumSnackBar(BuildContext context, String content) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
    elevation: ConfigSize.defaultSize!,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    margin: EdgeInsets.only(
        bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
        right: ConfigSize.screenWidth! * 0.15,
        left: ConfigSize.screenWidth! * 0.15),
    behavior: SnackBarBehavior.floating,
    content: Center(
      child: Text(
        content,
        style: TextStyle(
            fontSize: ConfigSize.defaultSize! * 1.6,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}

SnackBar loadingSnackBar(BuildContext context) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
    elevation: ConfigSize.defaultSize!,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    margin: EdgeInsets.only(
      bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
      right: ConfigSize.screenWidth! * 0.15,
      top: ConfigSize.screenHeight! * 0.15,
      left: ConfigSize.screenWidth! * 0.15,
    ),
    behavior: SnackBarBehavior.floating,
    content: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            StringManager.loading.tr(),
            style: TextStyle(
                color: Colors.green,
                fontSize: ConfigSize.defaultSize! * 1.6,
                fontWeight: FontWeight.w600),
          ),
          CircularProgressIndicator(
            color: Colors.green,
          )
        ],
      ),
    ),
  );
}

SnackBar ErrorSnackBar(BuildContext context, String content) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
    elevation: ConfigSize.defaultSize!,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    margin: EdgeInsets.only(
        bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
        right: ConfigSize.screenWidth! * 0.15,
        left: ConfigSize.screenWidth! * 0.15),
    behavior: SnackBarBehavior.floating,
    content: Center(
      child: Text(
        content,
        style: TextStyle(
            fontSize: ConfigSize.defaultSize! * 1.6,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}

SnackBar SuccessSnackBar(BuildContext context, String content) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
    elevation: ConfigSize.defaultSize!,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    margin: EdgeInsets.only(
        bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
        right: ConfigSize.screenWidth! * 0.15,
        left: ConfigSize.screenWidth! * 0.15),
    behavior: SnackBarBehavior.floating,
    content: Center(
      child: Text(
        content,
        style: TextStyle(
            fontSize: ConfigSize.defaultSize! * 1.6,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}