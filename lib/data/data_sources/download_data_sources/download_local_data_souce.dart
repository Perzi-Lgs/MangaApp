import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/download_helper.dart';
import '../../../domain/entities/scan_image.dart';

abstract class DownloadDataSource {
  Future<bool> storeInfoInCache(String keyword, String chapterName);
  Future<bool> downloadScans(String mangaName, List<ScanImage> scans);
}

class DownloadDataSourceImpl implements DownloadDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  DownloadDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  @override
  Future<bool> storeInfoInCache(String keyword, String chapterName) async {
    List<String>? mangaCacheInfo = sharedPreferences.getStringList(keyword);

    if (mangaCacheInfo != null) {
      mangaCacheInfo.add(chapterName);
      return await sharedPreferences.setStringList(keyword, mangaCacheInfo);
    } else {
      return await sharedPreferences.setStringList(keyword, [chapterName]);
    }
  }

  @override
  Future<bool> downloadScans(String mangaName, List<ScanImage> scans) async {
    String path = await getFilePath(mangaName);
    print(path);

    for (var i in scans) {
      final rawData = await client.get(Uri.parse(i.imageLink),
          headers: {'Referer': 'https://readmanganato.com/'});
      saveFile(path + '/' + i.name, rawData.bodyBytes);
    }
    return true;
  }
}
