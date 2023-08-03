import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_state.dart';

class MemberAgencyBody extends StatefulWidget {
  final OwnerDataModel owner ; 
  const MemberAgencyBody({required this.owner , super.key});

  @override
  State<MemberAgencyBody> createState() => _MemberAgencyBodyState();
}

class _MemberAgencyBodyState extends State<MemberAgencyBody> {
    int page = 1;
      final ScrollController scrollController = ScrollController();


  @override
  void initState() {
     BlocProvider.of<AgnecyMemberBloc>(context).add(const AgnecyMemberEvent(page: 1));
    scrollController.addListener(scrollListener);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ownerCard(
            context: context, id: widget.owner.uuid!, image: widget.owner.profile!.image!, name: widget.owner.name!),
        SizedBox(
          height: ConfigSize.defaultSize,
        ),
        Text(
          StringManager.members,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: ConfigSize.defaultSize,
        ),
        BlocBuilder<AgnecyMemberBloc, AgnecyMemberState>(
          builder: (context, state) {
            if (state is AgnecyMemberSucsessState) {
              return Expanded(

                  child: ListView.builder(
                    
                    controller: scrollController,
                    itemCount: state.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!,),
                   child: UserInfoRow(userData: state.data![index],underName: const SizedBox(), endIcon: Icon(Icons.arrow_forward_ios , color: Theme.of(context).colorScheme.primary,),)) ;
              }));
            } else if (state is AgnecyMemberLoadingState) {
              return SizedBox(height: MediaQuery.of(context).size.height/2.5, child: const LoadingWidget());
            } else if (state is AgnecyMemberErrorState) {
              return SizedBox(height: MediaQuery.of(context).size.height/2, child: CustoumErrorWidget(message: state.error));
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height/2.4,
                child: const CustoumErrorWidget(
                    message: StringManager.unexcepectedError),
              );
            }
          },
        )
      ],
    );
  }

    void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
           BlocProvider.of<AgnecyMemberBloc>(context).add( LoadMoreAgnecyMemberEvent(page: page));

    
    } else {}
  }
}

Widget ownerCard(
    {required BuildContext context,
    required String image,
    required String name,
    required String id}) {
  return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
        width: MediaQuery.of(context).size.width - 50,
        height: ConfigSize.defaultSize! * 20,
        decoration: BoxDecoration(
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
          border: Border.all(
            color: ColorManager.blue.withOpacity(0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              StringManager.agencyOwner,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                UserImage(image: image, imageSize: ConfigSize.defaultSize! * 7),
                const Spacer(),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                                const Spacer(flex: 2,),

              ],
            ),
            Text(
              "ID : $id",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ));
}
