import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/model/video_cache_model.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';


class VideoCacheManager {
  SharedPreferences? _preferences;
  final Map<String, List<VideoCacheModel>> _cacheMap = {};

  Map<String, List<VideoCacheModel>> get cacheMap => _cacheMap ;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    final cachedKeys = _preferences!.getStringList('reels_cache_keys');
    if (cachedKeys != null) {
      List<VideoCacheModel> finalList = [];
      for (final key in cachedKeys) {
        final videoUrl = _preferences!.getString('video_cache_reel_$key');
        final imgUrl = _preferences!.getString('img_cache_reel_$key');
        VideoCacheModel video = VideoCacheModel(img: imgUrl!, url: videoUrl!);
        finalList.add(video);
        if (finalList.isNotEmpty) {
          _cacheMap[key] = finalList;
        }
      }
    }
  }

  Future<void> cacheVideo(VideoCacheModel video, String cacheKey) async {

    log(video.img.toString()+"aaaaaaaaaa");
    final cacheManager =  getIt<DefaultCacheManager>() ;
    await cacheManager.downloadFile(video.url);
    await cacheManager.downloadFile(video.img);
    if (_cacheMap.containsKey(cacheKey)) {
      _cacheMap[cacheKey]!.add(video);
    } else {
      _cacheMap[cacheKey] = [video];
    }

    await _saveCacheMap();
    if(kDebugMode){
      log(_cacheMap.toString()) ;
    }

  }

  Future<void> removeVideosByCacheKey(String cacheKey) async {
    final cacheManager =  getIt<DefaultCacheManager>() ;
    if (_cacheMap.containsKey(cacheKey)) {
      final videoUrls = _cacheMap[cacheKey];
      for (final url in videoUrls!) {
        await cacheManager.removeFile(url.url);
      }
      _cacheMap.remove(cacheKey);
      await _saveCacheMap();
      if(kDebugMode){
        log(_cacheMap.length.toString()) ;
      }

    }
  }

  Future<void> _saveCacheMap() async {
    final keys = _cacheMap.keys.toList();
    await _preferences!.setStringList('reels_cache_keys', keys);
    for (final key in keys) {
      final videoUrls = _cacheMap[key];
      for(int i = 0; i < videoUrls!.length; i++) {
        await _preferences!.setString('video_cache_reel_$key', videoUrls[i].url);
        await _preferences!.setString('img_cache_reel_$key', videoUrls[i].img);
      }
    }
  }
}