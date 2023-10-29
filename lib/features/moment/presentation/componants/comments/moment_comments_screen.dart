
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/comments/widgets/comment_textfield.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_state.dart';
import 'widgets/moment_comment_row.dart';

class MomentCommentsScreen extends StatefulWidget {
  final String momentId;
  final String? type;
  const MomentCommentsScreen({
  required this.momentId,
  this.type,
  super.key,
});

@override
State<MomentCommentsScreen> createState() => MomentCommentsScreenState();
}

class MomentCommentsScreenState extends State<MomentCommentsScreen> {
  List<MomentCommentModel>? commentListtemp=[];
  TextEditingController commentController = TextEditingController(text: '');
  final ScrollController scrollController = ScrollController();


  double _keyboardHeight = 0;
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();
  static ValueNotifier<bool> showTextFieldmoment = ValueNotifier<bool>(false);



  @override
  void initState() {
    BlocProvider.of<GetMomentCommentBloc>(context)
        .add(GetMomentCommentEvent(momentId: widget.momentId.toString()));
    super.initState();
    scrollController.addListener(scrollListener);
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      _keyboardHeight = height;
      showTextFieldmoment.value = !showTextFieldmoment.value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    commentListtemp!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
         body: Column(
           children: [
             SizedBox(
               height: ConfigSize.defaultSize!,
             ),
             Row(
               children: [
                 const Spacer(flex: 1,),
                 IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
                 const Spacer(flex: 4,),
                 Text(StringManager.comments.tr(),style: Theme.of(context).textTheme.titleLarge,),
                 const Spacer(flex: 5,),
               ],
             ),


             SizedBox(
               width: ConfigSize.screenWidth!,
               height: ConfigSize.screenHeight! * 0.59,
               child: BlocBuilder<GetMomentCommentBloc, GetMomentCommentState>(
                 builder: (context, state) {
                   if (state is GetMomentCommentSucssesState) {

                     commentListtemp = state.data;
                     return Column(
                       children: [
                         state.data!.isNotEmpty
                             ? Expanded(
                           child: MomentComments(
                             type: widget.type,
                             momentCommentListModel: state.data!,
                             scrollController: scrollController,
                           ),
                         )
                             : Expanded(
                           child: Center(
                             child: Text(
                               StringManager.thisMomentc
                                   .tr(),
                               style: Theme.of(context)
                                   .textTheme
                                   .bodyLarge,
                             ),
                           ),
                         ),
                         CommentTextField(
                           commentController: commentController,
                           momentId: widget.momentId.toString(),
                         ),
                         ValueListenableBuilder<bool>(
                             valueListenable: showTextFieldmoment,
                             builder: (context, isShow, _) {
                               if (isShow) {
                                 return   SizedBox(height:_keyboardHeight);
                               } else {
                                 return const SizedBox(height: 0,);
                               }
                             }
                         )
                       ],
                     );
                   }
                   else if (state is GetMomentCommentErrorState) {
                     return CustomErrorWidget(
                       message: state.errorMassage,
                     );
                   }
                   else if (state is GetMomentCommentLoadingState) {
                     if (commentListtemp!.isNotEmpty) {
                       return Column(
                         children: [
                           Expanded(
                             child: MomentComments(
                               type: widget.type,
                               momentCommentListModel: commentListtemp!,
                               scrollController: scrollController,
                             ),
                           ),
                           CommentTextField(
                             commentController: commentController,
                             momentId: widget.momentId.toString(),
                           ),
                           ValueListenableBuilder<bool>(
                               valueListenable: showTextFieldmoment,
                               builder: (context, isShow, _) {
                                 if (isShow) {
                                   return   SizedBox(height:_keyboardHeight);
                                 } else {
                                   return const SizedBox(height: 0,);
                                 }
                               }
                           )

                         ],
                       );
                     }
                     else {
                       return  Align(
                           alignment: Alignment.topCenter,
                           child: LoadingWidget(height: ConfigSize.screenHeight!*.3,width: ConfigSize.screenWidth!*.3,));
                     }
                   }
                   else {
                     return

                       CustomErrorWidget(
                         message: StringManager.noDataFoundHere.tr());
                   }
                 },
               ),
             ),
           ],
         ),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetMomentCommentBloc>(context).add(
          LoadMoreMomentCommentEvent(momentId: widget.momentId.toString()));

    } else {}
  }
}