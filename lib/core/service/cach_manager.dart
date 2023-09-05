import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';


class VideoCacheManager {
  SharedPreferences? _preferences;
  Map<String, List<String>> _cacheMap = {};

  Map<String, List<String>> get cacheMap => _cacheMap ;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    final cachedKeys = _preferences!.getStringList('video_cache_keys');
    if (cachedKeys != null) {
      for (final key in cachedKeys) {
        final videoUrls = _preferences!.getStringList('video_cache_$key');
        if (videoUrls != null) {
          _cacheMap[key] = videoUrls;
        }
      }
    }
  }

  Future<void> cacheVideo(String videoUrl, String cacheKey) async {

    final cacheManager =  getIt<DefaultCacheManager>() ;
    await cacheManager.downloadFile(videoUrl);
    if (_cacheMap.containsKey(cacheKey)) {
      _cacheMap[cacheKey]!.add(videoUrl);
    } else {
      _cacheMap[cacheKey] = [videoUrl];
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
        await cacheManager.removeFile(url);
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
    await _preferences!.setStringList('video_cache_keys', keys);
    for (final key in keys) {
      final videoUrls = _cacheMap[key];
      await _preferences!.setStringList('video_cache_$key', videoUrls!);
    }
  }
}