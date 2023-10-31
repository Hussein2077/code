



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Components/Messages_Screen/Widges/Chat_Widget.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Components/Messages_Screen/Widges/official_appbar.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_bloc.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_events.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_states.dart';

import '../../../../../../core/utils/config_size.dart';

class OfficialMessagesScreen extends StatefulWidget {
  const OfficialMessagesScreen({Key? key}) : super(key: key);

  @override
  State<OfficialMessagesScreen> createState() => _OfficialMessagesScreenState();
}

class _OfficialMessagesScreenState extends State<OfficialMessagesScreen> {
  @override

  Widget build(BuildContext context) {
    BlocProvider.of<GetOfficialMsgsBloc>(context)
                        .add( getOfficailMsgsEvent() );
    return BlocBuilder<GetOfficialMsgsBloc,getOfficialMsgsStates>(
        buildWhen: (previous, current)=> previous.officialMsgsState !=current.officialMsgsState,
        builder: (context,state){
          switch(state.officialMsgsState){
            case RequestState.loaded:
              return  Scaffold(
                  body: Stack(
                    children: [
                      const OfficialChatAppbar(),
                      SizedBox(
                        width: ConfigSize.screenWidth,
                        child: Padding(
                          padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 4),
                          child: SingleChildScrollView(
                            
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                               SizedBox(
                                height: MediaQuery.of(context).size.height-100,
                                 child: ListView.builder(
                                  itemCount:  state.data!.official!.length, 
                                  reverse: true,
                                  itemBuilder: (context , index){ 
                                    
                                  return  ChatWidget(img: state.data!.official![index].img,
                                    content: state.data!.official![index].content,
                                      title:state.data!.official![index].title ,
                                      creadet:  state.data!.official![index].created,
                                    );
                                 }),
                               )
                                 

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            case RequestState.loading:
            return const LoadingWidget();
            case RequestState.error:
            return CustomErrorWidget(message:state.errorMessge);
          }
          });


  }
}
