import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VideoCacheManager {
  SharedPreferences? _preferences;
  Map<String, List<String>> _cacheMap = {};

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
    final cacheManager = DefaultCacheManager();
    await cacheManager.downloadFile(videoUrl);
    if (_cacheMap.containsKey(cacheKey)) {
      _cacheMap[cacheKey]!.add(videoUrl);
    } else {
      _cacheMap[cacheKey] = [videoUrl];
    }
    await _saveCacheMap();
  }

  Future<void> removeVideosByCacheKey(String cacheKey) async {
    final cacheManager = DefaultCacheManager();
    if (_cacheMap.containsKey(cacheKey)) {
      final videoUrls = _cacheMap[cacheKey];
      for (final url in videoUrls!) {
        await cacheManager.removeFile(url);
      }
      _cacheMap.remove(cacheKey);
      await _saveCacheMap();
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