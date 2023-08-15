
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_admin_room/admin_room_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_admin_room/admin_room_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_admin_room/admin_room_states.dart';
class AdminsRoomWidget extends StatelessWidget {
  final String ownerId;
  final String userId;
  const AdminsRoomWidget(
      {required this.userId, required this.ownerId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AdminRoomBloc>(context)
        .add(GetAdminsEvent(ownerId: ownerId));
    return Container(
      color: Colors.white,
      height: ConfigSize.defaultSize! * 60,
      width: ConfigSize.screenWidth,
      child: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3,
          ),
          Text(
            StringManager.adminOfRoom.tr(),
            style:const TextStyle(color: Colors.black, fontSize: 30),
          ),
            Divider(
              indent: ConfigSize.defaultSize! * 8,
              endIndent: 0,
              thickness: 1,
              height: ConfigSize.defaultSize! * 2,
              color: Colors.black12
          ),
          BlocConsumer<AdminRoomBloc, AdminRoomStates>(
            builder: (context, state) {
              if (state is SuccessAdminsRoomState) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: state.admins.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [

                                  SizedBox(
                                    width: ConfigSize.defaultSize! * 1.7,
                                  ),
                                  UserImage(
                                      image: state.admins[index].profile!.image!,
                                   ),
                                  SizedBox(
                                    width: ConfigSize.defaultSize! * 3,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.admins[index].name.toString(),
                                        style: TextStyle(
                                            fontSize: ConfigSize.defaultSize! * 1.5,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: ConfigSize.defaultSize! * 0.8,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              MaleFemaleIcon(
                                                age:state.admins[index].profile!.age ,
                                                  maleOrFeamle: state.admins[index].profile!.gender,
                                                 ),
                                              if(state.admins[index].level!.receiverImage != '')
                                                LevelContainer(
                                                image:ConstentApi().getImage(state.admins[index].level!.receiverImage),
                                              ),
                                              SizedBox(width: ConfigSize.defaultSize,),
                                              if(state.admins[index].level!.senderImage != '')
                                                LevelContainer(
                                                image:ConstentApi().getImage(state.admins[index].level!.senderImage),
                                              ),
                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<
                                            AdminRoomBloc>(
                                            context)
                                            .add(RemoveAdminEvent(
                                            ownerId: ownerId,
                                            userId: state.admins[index].id.toString()));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),// name & details
                                  SizedBox(
                                    width: ConfigSize.defaultSize! * 1.7,
                                  ),

                                ],
                              ),
                               Divider(
                                  indent: ConfigSize.defaultSize! * 8,
                          endIndent: 0,
                          thickness: 1,
                          height: ConfigSize.defaultSize! * 2,
                          color: Colors.black12
                          )
                            ],
                          );
                        }));
              } else if (state is LoadingAdminsRoomState) {
                return   TransparentLoadingWidget(width: ConfigSize.defaultSize!*11.6,height: ConfigSize.defaultSize!*11.6,);
              } else if (state is ErrorAdminsRoomState) {
                return CustomErrorWidget(message: state.errorMessage);
              } else {
                return const SizedBox();
              }
            },
            listener: (context, state) {
              if (state is SuccessRemoveAdminRoomState) {
                BlocProvider.of<AdminRoomBloc>(context)
                    .add(GetAdminsEvent(ownerId: ownerId));
              }
            },
          )
        ],
      ),
    );
  }
}
