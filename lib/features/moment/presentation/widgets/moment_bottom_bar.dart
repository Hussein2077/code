import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/comments/moment_comments_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/moment_giftbox_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/likes/moment_likes_screen.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_event.dart';


class MomentBottomBar extends StatelessWidget{
  final MomentModel momentModel;
  const MomentBottomBar({
    required this.momentModel,
    super.key
  });

  @override
  Widget build(BuildContext context) {
   return SizedBox(
height: ConfigSize.defaultSize!*2,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         InkWell(
           onTap: (){
             BlocProvider.of<GetMomentLikesBloc>(context).add(GetMomentLikesEvent(momentId:momentModel.momentId.toString() ));

             bottomDailog(context: context,
             widget: MomentLikesScreen(momentModel:momentModel ,) ,
             color: Theme.of(context).colorScheme.background);
           },
           child: Row(
             children: [
               //'likes number'
               Text(momentModel.likeNum.toString(),style:Theme.of(context).textTheme.bodyLarge),
             const Icon(Icons.favorite_border_rounded),
             ],
           ),
         ),

         InkWell(//Routes.momentCommentsScreen
           onTap: (){
             bottomDailog(context: context,

                 widget: MomentCommentsScreen(momentModel: momentModel,) ,

                 color: Theme.of(context).colorScheme.background);
           },
           child: Row(
             children: [
               //'message number'
               Text(momentModel.commentNum.toString(),style:Theme.of(context).textTheme.bodyLarge),
             const Icon(Icons.mode_comment_outlined),
             ],
           ),
         ),

         InkWell(
           onTap: (){
             bottomDailog(context: context,

                 widget:
                 //const SizedBox(),
                  const MomentGiftboxScreen(


                 ) ,
                 color: Theme.of(context).colorScheme.background);
           },
           child: Row(
             children: const [
               //'likes number'
              // Text('123',style:Theme.of(context).textTheme.bodyLarge),
             Icon(Icons.card_giftcard_rounded),
             ],
           ),
         ),
       ],
     ),
   );
  }


}