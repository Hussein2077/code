import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class GradientSnackBar extends StatelessWidget {
  final Widget content;
  final Gradient gradient;

  const GradientSnackBar({super.key, required this.content, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: content,
    );
  }
}

// SnackBar custoumSnackBar(BuildContext context, String content) {
//   return SnackBar(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
//     elevation: 0,
//     backgroundColor: Colors.transparent,
//     margin: EdgeInsets.only(
//       bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
//       right: ConfigSize.screenWidth! * 0.15,
//       left: ConfigSize.screenWidth! * 0.15,
//     ),
//     behavior: SnackBarBehavior.floating,
//     content: Container(
//       width: ConfigSize.defaultSize! * 2,
//       height: ConfigSize.screenHeight! * 0.04,
//       decoration: BoxDecoration(
//        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
//       ),
//       child: Center(
//         child: Text(
//           content,
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.background,
//             fontSize: ConfigSize.defaultSize! * 1.5,
//           ),
//         ),
//       ),
//     ),
//   );
// }

SnackBar loadingSnackBar(BuildContext context) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
    elevation: 0,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
      bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
      right: ConfigSize.screenWidth! * 0.15,
      left: ConfigSize.screenWidth! * 0.15,
    ),
    behavior: SnackBarBehavior.floating,
    content: Container(
      width: ConfigSize.defaultSize! * 2,
      height: ConfigSize.screenHeight! * 0.04,
      decoration: BoxDecoration(
        color: const Color(0xFF03a9fc),
        // gradient: const LinearGradient(
        //   colors: ColorManager.blueloadingList,
        //   end: Alignment.bottomRight,
        //   begin: Alignment.topLeft,
        // ),
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
      ),
      child: Center(
        child: Row(
          children: [
            const Spacer(
              flex: 10,
            ),
            Text(
              StringManager.loading.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: ConfigSize.defaultSize! * 1.5,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              height: ConfigSize.screenHeight! * 0.02,
              width: ConfigSize.screenHeight! * 0.02,
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    ),
  );
}

SnackBar errorSnackBar(BuildContext context, String content) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),
    elevation: 0,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
      bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
      right: ConfigSize.screenWidth! * 0.15,
      left: ConfigSize.screenWidth! * 0.15,
    ),
    behavior: SnackBarBehavior.floating,
    content: Container(
     // width: ConfigSize.defaultSize! * 2,
      height: ConfigSize.screenHeight! * 0.04,
      decoration:  BoxDecoration(
        color: const Color(0xFFfc0303),
      //     gradient: const LinearGradient(
      //   colors: ColorManager.redErrorList,
      //       end: Alignment.bottomRight,
      //       begin: Alignment.topLeft,
      // ),
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontSize: ConfigSize.defaultSize! * 1.5,
          ),
        ),
      ),
    ),
  );
}

SnackBar successSnackBar(BuildContext context, String content) {
  return SnackBar(
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5)),
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
        bottom: ConfigSize.screenHeight! - ConfigSize.defaultSize! * 10,
        right: ConfigSize.screenWidth! * 0.15,
        left: ConfigSize.screenWidth! * 0.15),
    behavior: SnackBarBehavior.floating,
    content: Container(
      //width: ConfigSize.defaultSize! * 2,
      height: ConfigSize.screenHeight! * 0.04,
      decoration: BoxDecoration(
        color: ColorManager.succesColor,
        // gradient: const LinearGradient(
        //   colors: ColorManager.greenSuccessList,
        //   end: Alignment.bottomRight,
        //   begin: Alignment.topLeft,
        // ),
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontSize: ConfigSize.defaultSize! * 1.5,
          ),
        ),
      ),
    ),
  );
}