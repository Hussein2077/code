import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/room/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_add_room_backGround/add_room_background_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_add_room_backGround/add_room_background_event.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_add_room_backGround/add_room_background_state.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_get_my_background/get_my_background_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_get_my_background/get_my_background_event.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_get_my_background/get_my_background_state.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';

class BackGround extends StatefulWidget {
  final String ownerId;
  const BackGround({required this.ownerId, super.key});

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
    List<BackGroundModel> backGround =[];
    int count = 0; 


  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile?.path != null) {
      setState(() {
        _image = File(pickedFile!.path);
      });
      BlocProvider.of<AddRoomBackgroundBloc>(context)
          .add(AddRoomBackgroundEvent(roomBackGround: _image!));
    }
  }

  @override
  void initState() {
    BlocProvider.of<OnRoomBloc>(context).add(GetBackGroundEvent());
        BlocProvider.of<GetMyBackgroundBloc>(context).add(GetMyBackGroundEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomBackgroundBloc, AddRoomBackgroundState>(
      listener: (context, state) {
        if (state is AddRoomBackgroundSucsses) {
          errorToast(context: context, title: state.massage) ;
        } else if (state is AddRoomBackgroundLoading) {
          loadingToast(context: context, title: '') ;
        } else if (state is AddRoomBackgroundError) {
          errorToast(context: context, title: state.error);
        }
      },
      builder: (context, state) {
        return BlocBuilder<OnRoomBloc, OnRoomStates>(
          builder: (context, state) {
            if (state is GetBackGroundloadingState) {
              return const TransparentLoadingWidget();
            } else if (state is GetBackGroundSucsseState) {
              count = state.data.length;
              backGround=state.data;
              return BlocBuilder<GetMyBackgroundBloc, GetMyBackgroundState>(
                builder: (context, state) {
                  if(state is GetMyBackgroundSucssesState){
                    backGround = backGround+state.data;
                return Container(
                      height: ConfigSize.defaultSize! * 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(AppPadding.p18),
                              topLeft: Radius.circular(AppPadding.p18))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ConfigSize.defaultSize! * 5,
                                width: MediaQuery.of(context).size.width,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: ConfigSize.defaultSize! * 3,
                                    ),
                                    onPressed: () async {
                                      await getImage();
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 45,
                            child: GridView.count(
                              // physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              children: List.generate(
                                 backGround.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<OnRoomBloc>(context)
                                                .add(UpdateRoom(
                                                  change: index<count?"app":"me",
                                                    roomId: widget.ownerId,
                                                    roomBackgroundId:backGround[index].id
                                                        .toString()));
                                            Navigator.pop(context);
                                          },
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ConfigSize.defaultSize! *
                                                          2),
                                              child: CustoumCachedImage(
                                                  height:
                                                      ConfigSize.defaultSize! *
                                                          28,
                                                  width:
                                                      ConfigSize.defaultSize! *
                                                          28,
                                                  url: ConstentApi().getImage(
                                                      backGround[index].img))),
                                        ),
                                      )),
                            ),
                          ),
                        ],
                      ));
                  }else {
                    return const SizedBox();
                  }
                
               
                },
              );
            } else if (state is GetBackGroundErrorState) {
              return CustomErrorWidget(message: state.errorMassage);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
// Widget BackGround(BuildContext context, int roomId) {
  
// }
