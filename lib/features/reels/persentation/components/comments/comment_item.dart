import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/user_profile_image.dart';

class CommentItem extends StatelessWidget {
  final ReelCommentModel commentItem;
  const CommentItem({Key? key, required this.commentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.only(bottom: ConfigSize.defaultSize!*1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO repleace  this widget with yours
                UserProfileImage(profileUrl: commentItem.userProfilePic),
                 SizedBox(width: ConfigSize.defaultSize!*0.7),
                Flexible(
                  child: Container(
                    padding:
                         EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!*0.7, horizontal: ConfigSize.defaultSize!),
                    decoration:  BoxDecoration(
                      color: const Color.fromARGB(225, 239, 239, 239),
                      borderRadius: BorderRadius.all(
                        Radius.circular(ConfigSize.defaultSize!*1.5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(width: ConfigSize.defaultSize!*0.5),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    commentItem.userName,
                                    style:  TextStyle(
                                      fontSize: ConfigSize.defaultSize!*1.4,
                                      color:
                                          Color.fromARGB(255, 41, 35, 35),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                commentItem.comment,
                                style:   TextStyle(
                                  fontSize: ConfigSize.defaultSize!*1.2,
                                  color: Color.fromARGB(255, 69, 67, 67),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ),
              ],
            ),
             SizedBox(height: ConfigSize.defaultSize!*0.3),
            Padding(
              padding:  EdgeInsets.only(left: ConfigSize.defaultSize!*4.4),
              child: Text(
               commentItem.commentTime.substring(0,10),
                style: Theme.of(context).textTheme.bodySmall
              ),
            ),
          ],
        ),
    );
  }
}
