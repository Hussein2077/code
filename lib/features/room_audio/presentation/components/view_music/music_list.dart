import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';

class MusicListWidget extends StatefulWidget {
  final String ownerId;

  const MusicListWidget({super.key, required this.ownerId});

  @override
  MusicListWidgetState createState() => MusicListWidgetState();
}

class MusicListWidgetState extends State<MusicListWidget> {
  late StreamSubscription scanResultStreamSubscription;
  late StreamSubscription pickResultStreamSubscription;
  late Map<String, dynamic> mapChachedMusic;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();

    MusicScreen.musicController.stream.listen((musicList) {
      setState(() {

      });
    });

    Future.delayed(Duration.zero, () async {
      mapChachedMusic = await Methods().getCachingMusic();
      if (mapChachedMusic[widget.ownerId] != null) {
        for (int i = 0; i < mapChachedMusic[widget.ownerId].length; i++) {
          MusicObject musicObject = MusicObject(
              uri: mapChachedMusic[widget.ownerId][i]['uri'],
              name: mapChachedMusic[widget.ownerId][i]['name'],
              duration: mapChachedMusic[widget.ownerId][i]['duration']);
          if (!RoomScreen.musicesInRoom.contains(musicObject)) {
            RoomScreen.musicesInRoom.add(musicObject);
          }
        }
      }
    });
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.chooseYourMusic.tr()),
        backgroundColor: ColorManager.gold1,
      ),
      body: !_hasPermission
          ? noAccessToLibraryWidget()
          : FutureBuilder<List<SongModel>>(
              // Default values:
              future: _audioQuery.querySongs(
                sortType: null,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true,
              ),
              builder: (context, item) {
                // Display error, if any.
                if (item.hasError) {
                  return Text(item.error.toString());
                }

                // Waiting content.
                if (item.data == null) {
                  return const LoadingWidget();
                }

                // 'Library' is empty.
                if (item.data!.isEmpty) return const Text("Nothing found!");

                // You can use [item.data!] direct or you can create a:
                // List<SongModel> songs = item.data!;
                return ListView.builder(
                  itemCount: item.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(item.data![index].title),
                      subtitle: Text(item.data![index].artist ?? "No Artist"),
                      trailing: InkWell(
                        onTap: () async {
                          if (RoomScreen.musicesInRoom.contains(MusicObject(
                              duration: item.data![index].duration!,
                              name: item.data![index].title,
                              uri: item.data![index].uri!))) {

                          } else {
                            setState(() {
                              RoomScreen.musicesInRoom.add(MusicObject(
                                  duration: item.data![index].duration!,
                                  name: item.data![index].title,
                                  uri: item.data![index].uri!));
                              if (mapChachedMusic.containsKey(widget.ownerId)) {
                                mapChachedMusic.update(widget.ownerId,
                                    (value) => RoomScreen.musicesInRoom);
                              } else {
                                mapChachedMusic.putIfAbsent(widget.ownerId,
                                    () => RoomScreen.musicesInRoom);
                              }
                            });

                            MusicScreen.musicController.sink.add(RoomScreen.musicesInRoom);

                            Methods().setCachingMusic(cachingMusic: mapChachedMusic);
                          }

                          // widget.refreshMusicScreen();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: RoomScreen.musicesInRoom.contains(
                                      MusicObject(
                                          duration: item.data![index].duration!,
                                          name: item.data![index].title,
                                          uri: item.data![index].uri!))
                                  ? ColorManager.lightGray
                                  : ColorManager.mainColor,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          child: Text(
                            RoomScreen.musicesInRoom.contains(MusicObject(
                                    duration: item.data![index].duration!,
                                    name: item.data![index].title,
                                    uri: item.data![index].uri!))
                                ? StringManager.added.tr()
                                : StringManager.add.tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: AppPadding.p14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      leading: QueryArtworkWidget(
                        controller: _audioQuery,
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
          color: ColorManager.whiteColor.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(StringManager.applicationDoesnt.tr()),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => checkAndRequestPermissions(retry: true),
              child: Text(StringManager.allow.tr()),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicObject extends Equatable {
  final String uri;
  final String name;
  final int duration;

  const MusicObject(
      {required this.uri, required this.name, required this.duration});

  MusicObject.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        uri = json['uri'],
        duration = json['duration'];

  Map<String, dynamic> toJson() {
    return {'name': name, 'uri': uri, 'duration': duration};
  }

  @override
  List<Object?> get props => [uri, name, duration];
}
