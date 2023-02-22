import 'package:background_downloader/background_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/download_helper.dart';
import '../../../domain/entities/scan_image.dart';

abstract class DownloadDataSource {
  Future<bool> storeInfoInCache(String keyword, String chapterName);
  Future<bool> downloadScans(String mangaName, List<ScanImage> scan, void Function(int status, double progress) statusCallback);
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
  Future<bool> downloadScans(String mangaName, List<ScanImage> scans, void Function(int status, double progress) statusCallback) async {
    FileDownloader.initialize();
    
    // String path = await getFilePath(mangaName);

    print(BaseDirectory.applicationDocuments);
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

    final result = await FileDownloader.downloadBatch(tasks, (succeeded, failed) {
      print('$succeeded files succeeded, $failed have failed');
      print('Progress is ${(succeeded + failed) / tasks.length} %');
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
}
