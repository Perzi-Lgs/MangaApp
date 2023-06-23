import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../domain/entities/scan_image.dart';

abstract class DownloadDataSource {
  Future<bool> storeInfoInCache(String keyword, String chapterName);
  Future<bool> downloadScans(String mangaName, List<ScanImage> scan, void Function(int status, double progress) statusCallback);
  Future<List<String>> getDownloadedManga();
  Future<List<String>> getDownloadedMangaChapters(String mangaName);

  Future<List<Uint8List>> getDownloadedChapterData(
      String mangaName, String chapter);
}

class DownloadDataSourceImpl implements DownloadDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  DownloadDataSourceImpl(
      {required this.client, required this.sharedPreferences});


  /*
    Load and save the cache informations about the list of chapters already downloaded and the manga name
  */
  // TODO: mettre mangaDownloaded en const et l'importer depuis un fichier
  @override
  Future<bool> storeInfoInCache(String keyword, String chapterName) async {
    List<String>? mangaCacheInfo = sharedPreferences.getStringList(keyword);
    List<String>? mangaDownloadedIndex = sharedPreferences.getStringList("mangaDownloaded");

     if (mangaDownloadedIndex == null) {
      await sharedPreferences.setStringList("mangaDownloaded", [keyword]);
    } else {
      if (!mangaDownloadedIndex.contains(keyword)) {
        mangaDownloadedIndex.add(keyword);
        await sharedPreferences.setStringList("mangaDownloaded", mangaDownloadedIndex);
      }
    }

    if (mangaCacheInfo != null) {
      mangaCacheInfo.add(chapterName);
      return await sharedPreferences.setStringList(keyword, mangaCacheInfo);
    } else {
      return await sharedPreferences.setStringList(keyword, [chapterName]);
    }
  }

  @override
  Future<bool> downloadScans(String mangaName, List<ScanImage> scans, void Function(int status, double progress) statusCallback) async {
    FileDownloader.initialize();
    
    List<DownloadTask> tasks = List.empty(growable: true);
    for (var i in scans) {
      tasks.add(DownloadTask(
        taskId: i.name,
        url: i.imageLink,
        filename: i.name,
        updates: Updates.statusAndProgress,
        baseDirectory: BaseDirectory.applicationDocuments,
        directory: mangaName,
        headers: {'Referer': 'https://readmanganato.com/'}
      ));
    }

    await FileDownloader.downloadBatch(tasks, (succeeded, failed) {
      if (failed > 0) {
        statusCallback(-1, (succeeded + failed) / tasks.length);
      }
      else if (succeeded == tasks.length) {
        statusCallback(1, (succeeded + failed) / tasks.length);
      } else {
        statusCallback(0, (succeeded + failed) / tasks.length);
      }
    });
    return true;
  }
  
  @override
  Future<List<String>> getDownloadedManga() async {
    final List<String>? res = sharedPreferences.getStringList("mangaDownloaded");
    
    if (res == null)
      throw CacheException("Could not get manga downloaded in cache");
    return res; 
  }

  @override
  Future<List<String>> getDownloadedMangaChapters(String mangaName) async {
    final List<String>? res =
        sharedPreferences.getStringList(mangaName);

    if (res == null)
      throw CacheException("Could not get manga chapters list store in cache");
    return res;
  }
  
  @override
  Future<List<Uint8List>> getDownloadedChapterData(String mangaName, String chapter) async {
    try {
    final Directory directory = Directory((await getApplicationDocumentsDirectory()).path.toString() +
            '/'  + mangaName + '/' + chapter);
      final files = await directory
          .list()
          .where((entity) => entity is File)
          .cast<File>()
          .toList();
      return await Future.wait(files.map((file) => file.readAsBytes()));
    } catch (e) {
      throw PlatformException(
          code: 'READ_ERROR',
          message: 'Failed to read files from directory: $e');
    }
  }
}