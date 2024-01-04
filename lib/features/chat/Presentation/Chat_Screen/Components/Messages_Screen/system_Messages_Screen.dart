


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Components/Messages_Screen/Widges/chat_appbar.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Components/Messages_Screen/Widges/system_massage_card.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_bloc.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_events.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_states.dart';

import '../../../../../../core/utils/config_size.dart';

class SystemMessagesScreen extends StatefulWidget {
  const SystemMessagesScreen({Key? key}) : super(key: key);

  @override
  State<SystemMessagesScreen> createState() => _SystemMessagesScreenState();
}

class _SystemMessagesScreenState extends State<SystemMessagesScreen> {
  @override
  void initState() {
    BlocProvider.of<GetOfficialMsgsBloc>(context)
        .add( getOfficailMsgsEvent() );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetOfficialMsgsBloc,getOfficialMsgsStates>(
        builder: (context,state){
          switch(state.officialMsgsState){
            case RequestState.loaded:
              return  Scaffold(
                  body: Stack(
                    children: [
                      const ChatAppbar(

                      ),
                      SizedBox(
                        width: ConfigSize.screenWidth,
                        child: Padding(
                          padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 4),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                 SizedBox(
                                height: MediaQuery.of(context).size.height-100,
                                 child: ListView.builder(
                                  itemCount:  state.data!.sys!.length,
                                  reverse: true,
                                  itemBuilder: (context , index){

                                  return
                                    SystemMaasageCard(
                                    userId: state.data!.sys![index].fromUserId,
                                    img: state.data!.sys![index].img,
                                    title:state.data!.sys![index].title ,
                                    creadet:  state.data!.sys![index].created,
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
