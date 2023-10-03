import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/music_list.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';




class MusicScreen extends StatefulWidget {
  static ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  static int? nowPlaying;
  final String ownerId ;
  final void Function() refrashRoom ;



 const  MusicScreen({Key? key, required this.ownerId , required this.refrashRoom}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {


  // List<MusicObject>  listChachedMusic =[] ;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {

     Map<String,dynamic> mapChachedMusic = await Methods().getCachingMusic() ;

     log(mapChachedMusic.toString()) ;
     log(mapChachedMusic[widget.ownerId].toString());
     if(mapChachedMusic[widget.ownerId] != null){

       for(int i=0 ; i<mapChachedMusic[widget.ownerId].length ; i++){
         MusicObject musicObject =MusicObject(uri: mapChachedMusic[widget.ownerId][i]['uri'],
             name: mapChachedMusic[widget.ownerId][i]['name'],
             duration: mapChachedMusic[widget.ownerId][i]['duration']) ;
         if(!RoomScreen.musicesInRoom.contains(musicObject)){

           setState(() {
             RoomScreen.musicesInRoom.add(musicObject);
           });
         }
       }
     }
    });



  }

  @override
  void dispose() {
    super.dispose();
  }

  refreshMuisicScreen(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(StringManager.songs.tr()),
        backgroundColor: ColorManager.gold1,
        actions: [
          IconButton(
              onPressed: (){
            Navigator.pushNamed(context, Routes.musicList,

                arguments: MusicPramiter(refresh: refreshMuisicScreen,ownerId: widget.ownerId));

          }, icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:15,vertical: 15),
              child: GestureDetector(
                onLongPress: (){
                  showDialog(context: context,
                      builder: (context){
                        return  Dialog(
                            backgroundColor: ColorManager.mainColor,
                            child: Container(
                              width: ConfigSize.defaultSize!*23.1,
                              height: ConfigSize.defaultSize!*6.9,
                              decoration: const  BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(

                                child:   InkWell(
                                  onTap: ()async{
                                    distroyMusic();
                                    setState(() {
                                      MusicScreen.nowPlaying = index;
                                      MusicScreen.isPlaying.value=false;
                                      widget.refrashRoom();
                                    });
                                    setState(() {
                                      RoomScreen.musicesInRoom.removeAt(index) ;
                                    });
                                    Map<String,dynamic>  mapChachedMusic = await Methods().getCachingMusic();
                                    mapChachedMusic.update(widget.ownerId, (value) => RoomScreen.musicesInRoom);
                                    Methods().setCachingMusic(cachingMusic:mapChachedMusic);
                                    Navigator.pop(context);

                                  },
                                  child: Text(StringManager.delete.tr(),style: const  TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18   ),),
                                ) ,
                              )


                            )
                        );
                      }
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(RoomScreen.musicesInRoom[index].name
                      ,style:  TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold,
                      fontSize: AppPadding.p14,

                    ),)),
                    IconButton(
                        onPressed: ()async{
                          if (!MusicScreen.isPlaying.value){
                        await    loadMusice(path:RoomScreen.musicesInRoom[index].uri);
                               MusicScreen.isPlaying.value=true;
                              MusicScreen.nowPlaying = index;
                              widget.refrashRoom();
                            setState(() {
                        
                            });

                          }
                          else if(MusicScreen.isPlaying.value&&MusicScreen.nowPlaying==index)
                          {

                           await distroyMusic();
                              MusicScreen.nowPlaying = null;
                              MusicScreen.isPlaying.value=false;
                              widget.refrashRoom();
                            setState(() {
                            
                            });
                          }else if(MusicScreen.isPlaying.value&&MusicScreen.nowPlaying!=index){
                               await  distroyMusic();
                               await loadMusice(path:RoomScreen.musicesInRoom[index].uri);
                                   MusicScreen.isPlaying.value=true;
                              MusicScreen.nowPlaying = index;
                              widget.refrashRoom();

                            setState(() {
                           
                            });
                          }

                        }, icon:
                    (MusicScreen.isPlaying.value&& (MusicScreen.nowPlaying==index)) ?
                    Icon( Icons.pause_circle_outline,color:
                    (MusicScreen.isPlaying.value&& (MusicScreen.nowPlaying==index)) ?
                    ColorManager.mainColor:Colors.grey,
                      size:AppPadding.p30,):
                    Icon( Icons.play_circle_outline,
                      size: AppPadding.p30,
                      color: (MusicScreen.isPlaying.value&& (MusicScreen.nowPlaying==index)) ?ColorManager.mainColor:Colors.grey,))
                  ],
                ) ,
              )
             ,
            );
          },
          itemCount:RoomScreen.musicesInRoom.length),

    );
  }
}
