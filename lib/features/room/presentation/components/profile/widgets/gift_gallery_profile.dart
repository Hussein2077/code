import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class GiftGalleryContainer extends StatelessWidget {
  final int userId ; 
  const GiftGalleryContainer({required this.userId ,  super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.giftGallery , arguments:userId  );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ConfigSize.defaultSize!*1.5,
          horizontal: ConfigSize.defaultSize!*1.5,
        ),
        decoration: BoxDecoration(
          color: ColorManager.giftColors,
          borderRadius:BorderRadius.circular(
              ConfigSize.defaultSize! * 1.2
          ),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black),
                SizedBox(
                  width: ConfigSize.defaultSize!*8.0,
                  height: ConfigSize.defaultSize!*2.5,
                  child: ListView.builder(
                      itemBuilder: (context,index){
                        return const Icon(Icons.ac_unit,color: Colors.black);
                      },
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
    
                  ),
                ),
              ],
            ),
            Text(StringManager.giftGallery,
                style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    color: ColorManager.darkBlack,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
